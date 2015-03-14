Getting and Cleaning Data: Course Project
=========================================

## Files

* *README.md* - This file.

* *run_analysis.R* - Loads and processes data from *UCI HAR Dataset* then exports a summary.

## Operation 

The script *run_analysis.R* loads the test and training data from the
[UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%
2FUCI%20HAR%20Dataset.zip) and produces the output file
*summary_data.txt*.  

To run *run_analysis.R* and create *summary_data.txt*, the UCI HAR Dataset must first 
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


## Output Format

For a description of the format of *summary_data.txt*, please see the file *CODEBOOK.md*.
