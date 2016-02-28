
## You should create one R script called run_analysis.R that does the following.

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Use descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Good luck!
  
## Human Activity Recognition Using Smartphones Data Set 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Here are the data for the project:
##https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



# Package Requirements

require("data.table")
require("dplyr")


# download ZIP file and unpack
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",zfile)
#unzip("zfile", overwrite = TRUE)

# load and merge training and test sets

# first get real variable names and descriptive activity names
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

train_ds <- cbind(as.data.table(subject_train, keep.rownames = FALSE), y_train, x_train)



    ##### load testing data

# X vals
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
names(x_test) = var_names

# Y vals
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
y_test[,2] = act_labels[y_test[,1]]
names(y_test) = c("Act_ID", "Act_Label")

# Subjects
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test) = "Subject"

# Extract only the measurements on the mean and standard deviation for each measurement.
meas_var <- grepl("mean|std", var_names)
x_test = x_test[meas_var]

test_ds <- cbind(as.data.table(subject_test, keep.rownames = FALSE), y_test, x_test)


## Merges the training and the test sets to create one data set.

combo_ds <- rbind(train_ds, test_ds)

## Appropriately labels the data set with descriptive variable names.



View(combo_ds)
