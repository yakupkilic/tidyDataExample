## Description

#### <run_analysis.R> script creates a tidy dataset from UCI HAR Dataset according to instructions given for the project assigment of Getting and Cleaning data course. The script should be run in the same folder with UCI HAR Dataset which is online available at <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> with a description at <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>. The script performs the following steps:


1. loads the necessary R packages, <dplyr> and <reshape2>
2. reads all the necessary .txt files.
   * feature names from <features.txt>
   * all the activity names from <activity_labels.txt>	 
   * train data <./train/x_train.txt> and activity and subject names in an ordered form for each observation of training data in <./train/y_train.txt> and <./train/subject_train.txt>, respectively
   * test data <./test/x_test.txt> and activity and subject names in an ordered form for each observation of test data in <./test/y_test.txt> and <./test/subject_test.txt>, respectively.
3. merges the train and test data.
   * in total, we have a data frame of 10299 obs and 561 variables.
4. extracts only the measurements on the mean and standard deviation for each measurement.
   * our approach is to extract the data related to the mean and standard deviation variables, given in <features.txt>. 
   * we find the variables with names mean and std (case insensitive) in it and only consider the part of the data with these variables.
   * the data frame consists of 10299 observations for 66 variables. 
5. gives the descriptive names for the activities in the dataset according to the names given in <activity_labels.txt>.	
6. appropriately labels the data set with the descriptive variable names 
   * we remove the "-" and "()" from the variable names
   * we add the subject labels and activity names to our data, hence we have in total 10299 observations and 68 variables.
   * this can be considered as our first tidy data set, variable <dataExtracted>	
7. creates a second an independent tidy dataset with the average of each variable for each activity and each subject.
   * in total we have a dataset with 180 rows because we compute the mean for 30 subjects and 6 activities. 	
8. finally the script writes the second tidy dataset in a file with a name <tidyDataSet.txt>.



## Acknowledgement	 		   		
	 	
#### Author of this script, owner of this github repo, acknowledges the contributors (especially David Hood) of the Getting and Cleaning Data course discussion forums, available on Coursera.  