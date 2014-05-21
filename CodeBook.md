## Download the data

Check the file and unzip the package, the directory containing the data is called "UCI HAR Dataset" which is the subdirectory of your work directory.

## Read the features and activity file

The `features` contains the 561 variable names.

The `activity` contains the 6 activity names.

## Read the test set and the train set

The works about the test and the train sets are identical. 

Firstly retrieve the names of all txt files as strings, then read all three txt files into `test.data1` as a list where all element are data frames, and assign names of txt files to `test.data1` names.

`test.data1$"subject_test.txt"`: the corresponding subject number conducting the experiment.

`test.data1$"X_test.txt"`: the test set where rows indicate observations and columns indicate the 561 different feature variables.

`test.data1$"y_test.txt"`: the corresponding activity number.

## Merge the test and the train sets to create one set

Due to their same feature variable names, the `merge()` operation is identical to the `rbind` operation.

`X_all`: the whole set.

## Extracts only the measurements on the mean and standard deviation for each measurement

Use regular expression to extract the mean and standard deviation variables from `features`. Due to the same order between the `features` and the `X_all` columns, the `ind` can be applied to subset `X_all`.

`X_sub`: the data set containing only the mean and standard deviation variable.

## Label the data set with descriptive activity names

`all_act`: the whole activity number for `X_all`.

`X_sub$activity`: add a column indicating the activity names.

`X_sub$subject`: add a column indicating the subjects.

## Create a new tidy set

Use `aggregate()` to create the result set.