cleandataproject
================

course project of getting and cleaning data

##Description of how the script works
1. Set the appropriate working directory with datasets stored in the folder. 
2. Read in train/y_train.txt file, train/x_train.txt file, train/subject_train.txt file, and features.txt file using read.table function.
3. Change variable names of data in x_train to activity labels in features.txt file.
4. Merge data by cbind function from train_x and train_y to add in activity variable, and merge with data from subject_train to add subject variable
5. Read in test/y_train.txt file, test/x_train.txt file, test/subject_train.txt file using read.table function, and change variable names and merge data using the same functions as above steps.
6. Combine train and test data by rbind function.
7. Use grep function to subset variables with "mean" and "std" in the names.
8. Use gsub function to change activity values to descriptive activity names using information in the activity_labels.txt file.
9. Create a new variable by pasting subject and activity.
10. Melt and reshape data for calculation of average of each variable for each activity of each subject.
11. Create a tidy data set of the average of each variable for each activity of each subject using dcast function.
12. Use gsub to remove - and () to get appropriate variable names.
13. Export the final tidy dataset to a txt file using write.table function.
14. Or export the final tidy dataset as an excel file using write.xlsx function in the xlsx package.
