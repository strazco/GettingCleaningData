
## You should create one R script called run_analysis.R that does the following.

## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement.
## Use descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names.
## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Good luck!
  
## Human Activity Recognition Using Smartphones Data Set 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Here are the data for the project:
##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



# Package Requirements

require("data.table")
require("dplyr")
require("magrittr")
require("tidyr")
require("plyr")

# download ZIP file and unpack
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zfile)
#unzip("zfile", overwrite = TRUE)

# load and merge training and test sets

# first get real variable names and activity codes
var_names <-read.table("./UCI HAR Dataset/features.txt") [,2]
act_labels <-read.table("./UCI HAR Dataset/activity_labels.txt") [,2]

##### load training data

# X vals
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
names(x_train) = var_names

# Y vals
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_train[,2] = act_labels[y_train[,1]]
names(y_train) = c("Act_ID", "Act_Label")

# Subjects
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train) = "Subject"

# Extract only the measurements on the mean and standard deviation for each measurement.
meas_var <- grepl("mean|std", var_names)
x_train = x_train[meas_var]

train_ds <- cbind(as.data.frame.table(subject_train), y_train, x_train)

View(train_ds)





