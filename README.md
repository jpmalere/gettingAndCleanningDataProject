gettingAndCleanningDataProject
==============================
This repo contains the code to clean the data from the following data repository (data from accelerometers from the Samsung Galaxy S smartphone)
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The files shall be unzipped on the folder "./UCI HAR Dataset/"

The R script "run_analysis.R" executes the following steps:
1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement. 
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive variable names.
5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The file 'codebook.txt' contains the explanation of the tidy data file and its respective variables.
