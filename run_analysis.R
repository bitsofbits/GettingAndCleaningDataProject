library(dplyr)

data_dir = "UCI HAR Dataset"

feature_names = read.table(paste(data_dir, "features.txt", sep="/"), stringsAsFactors=FALSE)

activity_labels = read.table(paste(data_dir, "activity_labels.txt", sep="/"))[[2]]
    
# This pattern selects only the columns whose labels end in "mean" or "std"
# optionally followed by a '.' and X, Y or Z. This selects all of the mean
# and standard deviation columns, except the angle ones. 
observation_pattern = "((mean..)|(std..))(.[XYZ])?$"

path_for <- function(kind, name) {
    base_path = paste(data_dir, kind, sep="/")
    full_name = paste(name, "_", kind, ".txt", sep="")
    paste(base_path, full_name, sep="/")
}
    
# This function takes an argument of either "train" or "test" and loads and assembles the 
# data set from the directory into a tidy data frame. The first two columns of the data
# frame are the subject ID and 
load_and_assemble_data <- function(kind) {
    # Read the subject IDs in with the column name "subject"
    subject = read.table(path_for(kind, "subject"), col.names=c("subject"))
    # Read the activity for each observation and then replace them with their names.
    Y = read.table(path_for(kind, "Y"), col.names=c("activity"))
    Y = mutate(Y, activity= activity_labels[activity])
    # Read the X data in with feature names as column names.  Note that these
    # names get fixed to be syntactically valid so they no longer match the 
    # feature names exactly. This can be prevented using "check.names=FALSE",
    # but that causes other problems later. Then select only the subset of the 
    # observations that we are interested in (std and mean) using observation_pattern
    # defined above.
    X = read.table(path_for(kind, "X"), col.names=feature_names[[2]])
    X = select(X, matches(observation_pattern))
    # Return the assembled matrix.
    cbind(subject, Y, X)
}


# Main script starts here.

# 1. Load and assemble the data from the "test" and "train" directories. 
test_data = load_and_assemble_data("test")
train_data = load_and_assemble_data("train")

# 2. Assemble into one data set
all_data = rbind(test_data, train_data)

# 3. Create the summary data. Average over groups with the same subject and activity.
summary_data = all_data %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# 4. Make the names in summary data slightly more descriptive. We make a little extra effort 
# here so that we can use the names from "features.txt" with "meanOf-" prepended. When we 
# load our data, illegal character for identifiers get mapped to ".", so we start from 
# scratch and use feature_names to make new column names.
feature_names_we_are_using = filter(feature_names, grepl(observation_pattern, V2))
descriptive_names = sapply(feature_names_we_are_using[[2]], function(x) paste("meanOf", x, sep="-"))
colnames(summary_data)[3:ncol(summary_data)] = descriptive_names

# 5. Done! Write out the data.
write.table(summary_data, "summary_data.txt", row.name=FALSE)