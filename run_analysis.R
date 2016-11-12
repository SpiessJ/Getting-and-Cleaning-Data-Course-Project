
### Download and Unzip
zipfiledownload <- tempfile() ## temporary file is created for zipfile download
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zipfiledownload) ## download of zipfile
unzip(zipfiledownload) ## unzip of downloaded zipfile

### Read data for Test and Train
XTest <- read.table(unzip(zipfiledownload, "UCI HAR Dataset/test/X_test.txt")) ## read dataset XTest
XTrain <- read.table(unzip(zipfiledownload, "UCI HAR Dataset/train/X_train.txt")) ## read dataset XTrain
YTest <- read.table(unzip(zipfiledownload, "UCI HAR Dataset/test/y_test.txt")) ## read dataset YTest
YTrain <- read.table(unzip(zipfiledownload, "UCI HAR Dataset/train/y_train.txt")) ## read dataset YTrain
SubjectTest <- read.table(unzip(zipfiledownload, "UCI HAR Dataset/test/subject_test.txt")) ## read dataset SubjectTest
SubjectTrain <- read.table(unzip(zipfiledownload, "UCI HAR Dataset/train/subject_train.txt")) ## read dataset SubjectTrain

### Merge datasets for Training and Test
XDATA <- rbind(XTrain, XTest) ## Merge XTRAIN and XTEST
YDATA <- rbind(YTrain, YTest) ## Merge YTRAIN and YTEST
SUBJECTDATA <- rbind(SubjectTrain, SubjectTest) ## Merge SubjectTrain and SubjectTest

### Extract only the variables on the mean and standard deviation for each measurement from dataset Features
Features <- read.table("UCI HAR Dataset/features.txt") ## read dataset Features
mean_and_std_Features <- grep("-(mean|std)\\(\\)", Features[, 2]) ## obtain only columns with "mean" or "std" in their names using REGEX grep
XDATA <- XDATA[, mean_and_std_features] ## subset relevant columns
names(XDATA) <- Features[mean_and_std_Features, 2] ## rename variables in XDATA

### Read data for Activities
Activities <- read.table("UCI HAR Dataset/activity_labels.txt")

### Update the values reflecting activities with activity names
YDATA[, 1] <- Activities[YDATA[, 1], 2]

### Upate the column name for activity in YDATA
names(YDATA) <- "Activity"

### Upate the column name for Subject in SUBJECTDATA
names(SUBJECTDATA) <- "Subject"

### Merge XDATA, YDATA and SUBJECTDATA into one set called MERGED_DATA
MERGED_DATA <- cbind(XDATA, YDATA, SUBJECTDATA)

### Create a derived dataset that contains the average of each variable for each activity and each subject
library(plyr) ## load library plyr in order to use ddply in order to split, apply function and return results)
CALCULATED_DATASET <- ddply(MERGED_DATA, .(Subject, Activity), function(x) colMeans(x[, 1:66])) ## use ddply and apply colMeans to all columns with values in it

### Write text file as deliverable
write.table(CALCULATED_DATASET, "CALCULATED_DATASET.txt", row.name=FALSE)

