# GettingAndCleaningData
Course Project Repository 

# Running the script
First, make sure your working directory contains the unzipped UCI HAR Dataset.

Then, run the script from your working directory.

Finally, you'll got as an output the file second_ds.txt, which contains the tidy 
dataset requested in the step 5 of the assignment.

To read the dataset to R use 

>"data <- read.table(file_path, header = TRUE)"

If you didn't move the second.txt file from your working directory, the file_path
to be used is "./second_ds.txt". Hence, you should run

>"data <- read.table("./second_ds.txt", header = TRUE)"

# The "run_analysis.R"" script
This script reads data from UCI HAR dataset, merges test and trainning datasets,
extracts only mean and standard devition measurements, labels the dataset 
columns and take the average of those variables over each pair (subject,activity)
as part of the Getting and Cleaning Data Course Project - november/2015.

1) reads the features and activity labels from files 
UCI HAR Dataset/features.txt and UCI HAR Dataset/activity_labels.txt

2) reads test data from files UCI HAR Dataset/test/x_test.txt,
UCI HAR Dataset/test/y_test.txt and UCI HAR Dataset/test/subject_test.txt

3) reads trainning data from files UCI HAR Dataset/train/x_train.txt,
UCI HAR Dataset/train/y_train.txt and UCI HAR Dataset/train/subject_train.txt

4) replaces the Numeric Label by a Descriptive Activity Label on both test
and trainning sets

5) extracts only mean and standard deviation measurements

6) merge test and trainning datasets, labelling the variables

7) averages all the variables over each pair (subject,activity)

8) generates text file named second_ds.txt with the tidy dataset required in the
assignment







