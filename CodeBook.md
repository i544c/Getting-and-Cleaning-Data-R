**Variables:**

1. `s_train`, `y_train`, `x_train`: Variables that store training data, including subjects (subject identification), activities (activity identification) and features (measurements).

2. `s_test`, `y_test`, `x_test`: Variables that store test data, similar to training variables.

3. `df`: Variable that stores the combined dataset, where training and testing data are merged.

4. `feature_names` and `features`: Variables that store the feature names, read from the "features.txt" file, and a list of names that includes "subject", "activity" and the selected mean and standard deviation characteristics.

5. `filtered_feature_index`: A logical variable that indicates which columns of the `df` dataset to keep, based on the presence of the words "mean", "std", "subject", and "activity" in the column names.

6. `filtered_data`: Variable that stores the resulting dataset after applying the filter to the columns of the original dataset.

7. `activities`: Variable that stores the descriptive names of activities, read from the "activity_labels.txt" file.

8. `filtered_names`: Variable that stores the descriptive names of the columns after cleaning and renaming.

9. `tidy_dataset`: Variable that stores the final data set, with the average of each variable for each activity and subject.

**Data and Transformations:**

1. **Step 1 (Merge the training and testing sets):** The code loads the training and testing data for subjects, activities, and characteristics. It then merges this data into a single dataset called `df`.

2. **Step 2 (Extract Mean and Standard Deviation Measurements):** The code identifies the relevant columns in the `df` dataset based on the keywords "mean", "std", "subject" and " activity". It creates a new variable called `filtered_data` containing only the relevant columns.

3. **Step 3 (Use descriptive activity names):** The activity IDs in the dataset are replaced with the descriptive activity names read from the "activity_labels.txt" file. This is done to make the activities more understandable.

4. **Step 4 (Properly label the dataset with descriptive variable names):** Column names are adjusted and cleaned up to make them more descriptive and readable. This involves removing parentheses, replacing abbreviations with full words, and converting to lowercase letters.

5. **Step 5 (Create a second dataset with the mean of each variable for each activity and each subject):** The code uses the `dplyr` library to group the `filtered_data` dataset by subject and activity and then calculates the mean of each variable for each group. The result is stored in the `tidy_dataset` variable. The final dataset `tidy_dataset` is saved in a text file called "new_data.txt" in the current working directory.

The code performs these steps to clean and organize the data, resulting in a final dataset that is ready for further analysis, with descriptive names, identified activities, and summary measures with averages by activity and subject.
