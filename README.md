Getting and Cleaning Data: Course Project
=========================================

## Files

* *README.md* - This file.

* *run_analysis.R* - Loads and processes data from *UCI HAR Dataset* then exports a summary.

* *summary_data.txt* - Output of *run_analysis.R*

## Operation 

The script *run_analysis.R* loads the test and training data from the
[UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%
2FUCI%20HAR%20Dataset.zip) and produces the output file
*summary_data.txt*.  

To run *run_analysis.R* and recreate *summary_data.txt*, the UCI HAR Dataset must first 
be unpacked so that its top level directory is in the same directory as the 
*run_analysis.R*.

The script proceeds as follows:

	1. Create tidy matrices based on the data in the "train" and "test" directories
	using the function *load_and_assemble_data*. Only a subset of the total data 
	corresponding to the means and standard deviations is included in this file. See
	codebook section below for details.
	
	2. Combine these two matrices into the full, tidy data set.
	
	3. Use dplyr's *group_by* and *summarise_each* to create the summary data. This data
	contains the averages for each of the observations over groups defined by 
	subject and activity.
	
	4. Make the column headers more descriptive. This involves making the headers match
	their original forms in "activity_labels.txt" adding the prefix "meanOf-" to 
	each header in order to emphasize that the values presented are group means.

The bulk of the work is done in the function *load_and_assemble_data(kind)*. This function
works on either the "test" or "train" data, depending on the value *kind*. The function:

	1. Reads the subject ids.
	
	2. Reads the activity ids and converts them into text values for activities.
	
	3. Reads the measured values and subsets them, keeping only the mean and
	standard deviation entires.
	
	4. Combine these three parts into one matrix.



##Codebook for summary_data.txt

### Overview

The first two columns contain the subject (i.e. person wearing the phone) and an activity.
The subsequent columns contain the average of values for that subject and activity. For
example the table begins:

	"subject" "activity" "meanOf-tBodyAcc-mean()-X" "meanOf-tBodyAcc-mean()-Y"...
	1 "LAYING" 0.22159824394 -0.0405139534294 -0.11320355358 -0.9280564692 -0....
	1 "SITTING" 0.261237565425532 -0.00130828765170213 -0.104544182255319 -0.9...
	...

In the first row after the headings, "meanOf-tBodyAcc-mean()-X" column contains an average
of all the values for subject #1 that were recorded while he or she was laying down.

### Column Descriptions
 
* subject : The ID of the subject; an integer ranging from 1 to 30.
* activity : Activity occurring during observation. One of "LAYING", "SITTING", 
  "STANDING", "WALKING", "WALKING_DOWNSTAIRS" or "WALKING_UPSTAIRS"

These columns listed below use the names used in "UCI HAR Dataset/features_info.tx" 
with "meanOf-" prepended to make it clear that these are mean values for a given 
subject and activity.  Data has been normalized to be in the range [-1,1], so is
effectively unitless. More details can be found in the files "README.md" and 
"features_info.txt" in the *UCI HAR Dataset*.

* "meanOf-tBodyAcc-mean()-X"
* "meanOf-tBodyAcc-mean()-Y"
* "meanOf-tBodyAcc-mean()-Z"
* "meanOf-tBodyAcc-std()-X"
* "meanOf-tBodyAcc-std()-Y"
* "meanOf-tBodyAcc-std()-Z"
* "meanOf-tGravityAcc-mean()-X"
* "meanOf-tGravityAcc-mean()-Y"
* "meanOf-tGravityAcc-mean()-Z"
* "meanOf-tGravityAcc-std()-X"
* "meanOf-tGravityAcc-std()-Y"
* "meanOf-tGravityAcc-std()-Z"
* "meanOf-tBodyAccJerk-mean()-X"
* "meanOf-tBodyAccJerk-mean()-Y"
* "meanOf-tBodyAccJerk-mean()-Z"
* "meanOf-tBodyAccJerk-std()-X"
* "meanOf-tBodyAccJerk-std()-Y"
* "meanOf-tBodyAccJerk-std()-Z"
* "meanOf-tBodyGyro-mean()-X"
* "meanOf-tBodyGyro-mean()-Y"
* "meanOf-tBodyGyro-mean()-Z"
* "meanOf-tBodyGyro-std()-X"
* "meanOf-tBodyGyro-std()-Y"
* "meanOf-tBodyGyro-std()-Z"
* "meanOf-tBodyGyroJerk-mean()-X"
* "meanOf-tBodyGyroJerk-mean()-Y"
* "meanOf-tBodyGyroJerk-mean()-Z"
* "meanOf-tBodyGyroJerk-std()-X"
* "meanOf-tBodyGyroJerk-std()-Y"
* "meanOf-tBodyGyroJerk-std()-Z"
* "meanOf-tBodyAccMag-mean()"
* "meanOf-tBodyAccMag-std()"
* "meanOf-tGravityAccMag-mean()"
* "meanOf-tGravityAccMag-std()"
* "meanOf-tBodyAccJerkMag-mean()"
* "meanOf-tBodyAccJerkMag-std()"
* "meanOf-tBodyGyroMag-mean()"
* "meanOf-tBodyGyroMag-std()"
* "meanOf-tBodyGyroJerkMag-mean()"
* "meanOf-tBodyGyroJerkMag-std()"
* "meanOf-fBodyAcc-mean()-X"
* "meanOf-fBodyAcc-mean()-Y"
* "meanOf-fBodyAcc-mean()-Z"
* "meanOf-fBodyAcc-std()-X"
* "meanOf-fBodyAcc-std()-Y"
* "meanOf-fBodyAcc-std()-Z"
* "meanOf-fBodyAccJerk-mean()-X"
* "meanOf-fBodyAccJerk-mean()-Y"
* "meanOf-fBodyAccJerk-mean()-Z"
* "meanOf-fBodyAccJerk-std()-X"
* "meanOf-fBodyAccJerk-std()-Y"
* "meanOf-fBodyAccJerk-std()-Z"
* "meanOf-fBodyGyro-mean()-X"
* "meanOf-fBodyGyro-mean()-Y"
* "meanOf-fBodyGyro-mean()-Z"
* "meanOf-fBodyGyro-std()-X"
* "meanOf-fBodyGyro-std()-Y"
* "meanOf-fBodyGyro-std()-Z"
* "meanOf-fBodyAccMag-mean()"
* "meanOf-fBodyAccMag-std()"
* "meanOf-fBodyBodyAccJerkMag-mean()"
* "meanOf-fBodyBodyAccJerkMag-std()"
* "meanOf-fBodyBodyGyroMag-mean()"
* "meanOf-fBodyBodyGyroMag-std()"
* "meanOf-fBodyBodyGyroJerkMag-mean()"
* "meanOf-fBodyBodyGyroJerkMag-std()"


