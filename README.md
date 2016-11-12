# Getting-and-Cleaning-Data-Course-Project

The course project is about writing an R script (`run_analysis.R`) that fulfills the following tasks:

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data to be processed was collected from accelerometers of Samsung Galaxy S smartphones.

The script `run_analysis.R` which can be found in this repo does the following:
* Downloads and unzips the zipped data from the URL indicated in the assignment briefing
* Reads the datasets `XTest`, `XTrain`, `YTest`, `YTrain`, `SubjectTest`, `SubjectTrain`
* Merges datasets for "Training" and "Test" into auxiliary data frames (XDATA, YDATA, SUBJECTDATA)
* Reads dataset "Features" and extracts only the variables for mean and standard deviation for each measurement
* Conducts subsetting and updates on XDATA, YDATA, SUBJECTDATA
* Merges upated datasets XDATA, YDATA, SUBJECTDATA into MERGED_DATA
* Generates .txt-file named CALCULATED_DATASET using the function ddply from the package `plyr`which was previously loaded. The function ddply splits a data frame, applies a function and returns results into another data frame. In our case the function applied is `colMeans`.
