## 0 - installing package and setting WD
install.packages("plyr")
library(plyr)
setwd("D:/R/")

## 1a (Hereinafter - numbering from README.md) - downloading and putting in folder
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "D:/R/my_data.zip")

## 1b - unzipping the file
unzip(zipfile = "D:/R/my_data.zip", exdir = "D:/R/my_data")

## putting unzipped file in UCI HAR Dataset
path_data<- file.path("D:/R/my_data", "UCI HAR Dataset")

## 2a - reading the activity file
activitytestY <- read.table(file.path(path_data, "test", "Y_test.txt"), header = FALSE)
activitytrainY <- read.table(file.path(path_data, "train", "Y_train.txt"), header = FALSE)

## 2b - reading the subject files
subjecttest <- read.table(file.path(path_data, "test", "subject_test.txt"), header = FALSE)
subjecttrain <- read.table(file.path(path_data, "train", "subject_train.txt"), header = FALSE)

##2c - reading the features files
featuretestX <-read.table(file.path(path_data, "test", "X_test.txt"), header = FALSE)
featuretrainX <- read.table(file.path(path_data, "train", "X_train.txt"), header = FALSE)

## Merging the training and the test datasets to create one dataset

##3a - Concatenate the data tables by rows
subject <- rbind(subjecttrain, subjecttest)
activity <- rbind(activitytrainY, activitytestY)
feature <- rbind(featuretrainX, featuretestX)

##3b - Naming the cols
featurenames <- read.table(file.path(path_data, "features.txt"), header = FALSE)
names(feature) <- featurenames$V2

##3c - Merging the data
names(activity) <- c("Activity")
names(subject) <- c("Subject")
DATAcomb <- cbind(subject, activity)
mdata <- cbind(feature, DATAcomb)

##4 - Extracting only the means and st. deviations for each measurement
colmeansd <- featurenames$V2[grep("mean\\(\\)|std\\(\\)", featurenames$V2)]
selnames <- c(as.character(colmeansd), "Subject", "Activity")
mdata <- subset(mdata, select = selnames)


activitylbls <- read.table(file.path(path_data, "activity_labels.txt"), header = FALSE)
mdata$Activity <- as.character(mdata$Activity)
for (i in 1:6){
  mdata$Activity[mdata$Activity==i] <- as.character(activitylbls[i,2])
}

##5 - Appropriately labels the data set with descriptive variable names
names(mdata) <- gsub("^t", "Time", names(mdata))
names(mdata) <- gsub("^f", "Frequency", names(mdata))
names(mdata) <- gsub("^Acc", "Accelerometer", names(mdata))
names(mdata) <- gsub("^Gyro", "Gyroscope", names(mdata))
names(mdata) <- gsub("^Mag", "Magnitude", names(mdata))
names(mdata) <- gsub("^BodyBody", "Body", names(mdata))

names(mdata)

##6 - creating a second, independent tidy data set with the average of each
## variable for each activity and each subject
newdata <- aggregate(.~Subject + Activity, mdata, mean)
newdata <- newdata[order(newdata$Subject, newdata$Activity),]
write.table(newdata, file = "newdata.txt", row.names = FALSE)
