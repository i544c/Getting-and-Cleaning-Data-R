# Johns Hopkins University - Getting and Cleaning Data - Coursera
# Activity: Obtaining and cleaning data - Course project
# Author: Isaac Gomes Veras
# Creation date: September 29, 2023
# IDE: DataSpell 2023.2.2 Build #DS-232.9921.48, built on September 13, 2023
# R Version: 4.3.1

R.version.string; cat("\n") # Check R version
getwd(); cat("\n")          # Check working directory

# Package installation:
if (!require("pacman")) install.packages("pacman")
pacman::p_load (pacman,		# pacman = package manager
                tidyverse	# tidyverse = set of tools for Data Science
)

#---- Data Base: Human Activity Recognition Using Smartphones Dataset:
    # Link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#---- Step 1: Merge the training and testing sets to create a dataset:

  # # Extract "train" data:
  s_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names= "subject")
  y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names= "activity")
  x_train <- read.table("UCI HAR Dataset/train/X_train.txt", comment.char="")
  d_train <- cbind(s_train, y_train, x_train)
  
  head(d_train) # data verification

  # # Extract "test" data:
  s_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names= "subject")
  y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names= "activity")
  x_test <- read.table("UCI HAR Dataset/test/X_test.txt", comment.char="")
  d_test <- cbind(s_test, y_test, x_test)
  
  head(d_test) # data verification

  # Merging the data:
  df <- rbind(d_train, d_test)
  
  head(df) # data verification

  # Reading Features:
  feature_names <- read.table("UCI HAR Dataset/features.txt", col.names=c("id", "name"))
  features <- c("subject", "activity", as.vector(feature_names[,"name"]))
  
  head(features) # data verification

#---- Step 2: Extract only the measurements about the mean and standard deviation of each measurement:

filtered_feature_index <- grepl("mean|std|subject|activity", features) & !grepl("meanFreq", features)
filtered_data <- df[, filtered_feature_index]

head(filtered_data)

#---- Step 3: Use descriptive activity names to name the activities in the dataset:

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names=c("id", "name"))
for (i in seq_len(nrow(activities))) {
  filtered_data$activity[filtered_data$activity == activities[i, "id"]] <- as.character(activities[i, "name"])
}

head(filtered_data$activity) # data verification

#---- Step 4: Appropriately label the dataset with descriptive variable names:

filtered_names <- features[filtered_feature_index]
filtered_names <- gsub("\\(\\)", "", filtered_names)
filtered_names <- gsub("Acc", "-acceleration", filtered_names)
filtered_names <- gsub("Mag", "-Magnitude", filtered_names)
filtered_names <- gsub("BodyBody", "Body", filtered_names)
filtered_names <- gsub("(Jerk|Gyro)", "-\\1", filtered_names)
filtered_names <- gsub("^t(.*)$", "\\1-time", filtered_names)
filtered_names <- gsub("^f(.*)$", "\\1-frequency", filtered_names)
filtered_names <- tolower(filtered_names)

  # Assign filtered names to resources:
  names(filtered_data) <- filtered_names
  head(filtered_names) # data verification

#---- Step 5: From the data set from step 4, create a second independent and organized data set with the average of each variable for each activity and each subject:

tidy_dataset <- tbl_df(filtered_data) %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))
  print(tidy_dataset)

# Save "tidy_dataset" in folder:
  write.table(tidy_dataset, file="tidy_dataset.txt", row.name=FALSE)
