# removes the variables
rm(list=ls())

# load library
library("plyr", lib.loc="~/R/win-library/3.1")

# Step 1: Merges the training and the test sets to create one data set.
# reads the test set
xTest <- read.csv("./UCI HAR Dataset/test/X_test.txt", sep="", header = FALSE)
yTest <- read.csv("./UCI HAR Dataset/test/y_test.txt", sep="", header = FALSE)
subjectTest <- read.csv("./UCI HAR Dataset/test/subject_test.txt", sep="", header = FALSE)

# reads the training set
xTrain <- read.csv("./UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE)
yTrain <- read.csv("./UCI HAR Dataset/train/y_train.txt", sep="", header = FALSE)
subjectTrain <- read.csv("./UCI HAR Dataset/train/subject_train.txt", sep="", header = FALSE)

# merges the data
# test set
test <- cbind(xTest,yTest,subjectTest)
# training set
train <- cbind(xTrain,yTrain,subjectTrain)
# data set
dataSet <- rbind(train,test)

# Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
# all features
features <- read.csv("./UCI HAR Dataset/features.txt",sep="",header=FALSE)
# mean and std features
meanAndStdCols <- which((grepl(c("mean"),features[,2])==TRUE) | (grepl(c("std"),features[,2])==TRUE))
# data set with just mean, std, subject and activity
dataSet <- dataSet[,c(meanAndStdCols,562,563)]

# Step 3: Uses descriptive activity names to name the activities in the data set
activities <- read.csv("./UCI HAR Dataset/activity_labels.txt",sep="",header=FALSE)
for (i in seq_along(activities[,1])){
    dataSet[,ncol(dataSet) - 1] <- gsub(activities[i,1],activities[i,2],dataSet[,ncol(dataSet) - 1])
}

# Step 4: Appropriately labels the data set with descriptive variable names.
colLabels <- features[meanAndStdCols,2]
#,"ActivityLabels","Subject"
# changes the name to be more human readable
colLabels <- gsub("Acc","Acceleration",colLabels)
colLabels <- gsub("tB","timeB",colLabels)
colLabels <- gsub("tG","timeG",colLabels)
colLabels <- gsub("fB","frequencyB",colLabels)
colLabels <- gsub("Mag","Magnitude",colLabels) 
colLabels <- gsub("BodyBody","Body",colLabels) 

# data set col names
colnames(dataSet) <- c(colLabels,"ActivityLabels","Subject")

# Step 5: From the data set in step 4, creates a second, 
# independent tidy data set with the average of each variable
# for each activity and each subject.
tidyData <- ddply(dataSet,.(ActivityLabels,Subject),numcolwise(mean))
write.table(tidyData,"./tidyData.txt",row.names=FALSE)
