# This script is written to create a tidy data set from the test and training data of UCI HAR Dataset.   

library(dplyr)
library(reshape2)

# Preparation: Read all the necessary .txt files

features<-read.table("./UCI HAR Dataset/features.txt")                # contains the names of 561 features.
activityNames<-read.table("./UCI HAR Dataset/activity_labels.txt")    # contains the activity names 1-6

  # A. train data

activityTrain<-read.table("./UCI HAR Dataset/train/y_train.txt")      # activity labels 1-6 for 7352 obs.
subjectTrain<-read.table("./UCI HAR Dataset/train/subject_train.txt") # subject labels 1-30 for 7352 obs. 

dataTrain<-read.table("./UCI HAR Dataset/train/x_train.txt")          # 7352 obs. for 561 variables 

  # B. test data

activityTest<-read.table("./UCI HAR Dataset/test/y_test.txt")         # activity labels 1-6 in 2947 obs.
subjectTest<-read.table("./UCI HAR Dataset/test/subject_test.txt")    # subject labels 1-30 in 2947 obs.  

dataTest<-read.table("./UCI HAR Dataset/test/x_test.txt")            # 2947 obs. for 561 variables 

# i) Merge the train and test data

activityTotal<-rbind(activityTrain,activityTest)         # activity labels 1-6 for 10299 obs in total
subjectTotal<-rbind(subjectTrain,subjectTest)            # subject labels 1-30 for 10299 obs in total

dataTotal<-rbind(dataTrain,dataTest)                     # total data 10299x561

# ii) Extract only the measurements on the mean and std for each measurement.

  # A. Get the index and names of features for mean and std
      # note only consider the mean and std for each measurement.

indexMean <-grep("mean()",features$V2,fixed=TRUE)               
indexSTD <-grep("std()",features$V2,fixed=TRUE)

nameMean <- features$V2[indexMean]
nameSTD <- features$V2[indexSTD]

index<-c(indexMean,indexSTD)                                # combine the indices of mean and std
name<- c(as.character(nameMean),as.character(nameSTD))      # combine the names
var<-data.frame(index,name)                                 # create a data frame
var<-arrange(var,index)                                     # indices are ordered, so the names, so that
                                                            # after, for instance tBodyACC-mean()[X,Y,Z]
                                                            # comes tBodyACC-std()[X,Y,Z] immediately

   # B. Extract only the variables of interest according to <var> from <dataTotal> 

dataExtracted<-dataTotal[,var$index] 

# iii) Give descriptive names for the activities in the dataset.

activityName<-character(dim(activityTotal)[1])
  for (i in 1:dim(activityTotal)[1]){
     activityName[i]<-as.character(activityNames$V2[activityTotal$V1[i]])  
  }
    
# iv) Appropriately label the data set with the descriptive variable names 

a<-gsub("-","",var$name)                                             # remove "-" from all the names
a<-gsub("BodyBody","Body",a,fixed=TRUE)                                # fix the typo
var$name<-gsub("()","",a,fixed=TRUE)                                 # remove "()" from all the names
names(dataExtracted)<-var$name                                       # set the descriptive names for the variables
dataExtracted$activityName<-activityName                             # activity names 
dataExtracted$subject<-subjectTotal$V1                               # subect numbers are also added.


# v) Create 2nd an independent tidy dataset with the average of each variable for each activity and each subject.

tidyDataSet<-aggregate(.~subject+activityName, data = dataExtracted,mean,na.rm=TRUE)   # 180 rows and 68 total variables

# vi) Write the tidy dataset.

write.table(tidyDataSet,file="tidyDataSet.txt",row.name=FALSE) 





