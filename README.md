# Getting and Cleaning Data

## Course Project:

Create one R script called ```run_analysis.R``` that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Execution:

1. Copy ```run_analysis.R``` in your working directory.
2. Launch R or RStudio and change your working directory using ```setwd("WORKING_DIR")``` function.
3. Execute  ```source("run_analysis.R")``` command.


## What to expect:

1. The original zip file with raw data will be downloaded and unziped in your working directory. You should have a ```UCI HAR Dataset``` folder.
2. Following data sets will be created in Global Environment ```test_data, train_data, tidy_data, tidy_data_mean```. If you will use RStudio, you could open and see them as a table.
3. In your working directory you should see the output files: ```tiny_data.txt``` ```tidy_data_mean.txt```.


## How the script run_analysis.R works:

1. This script

	a) is supposed to be launched from the working directory;
	b) uses ```data.table``` and ```reshapre2``` libraries, which will be installed automatically.
	c) will download and unzip the file "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
	   if the working directory will not contain the "UCI HAR Dataset" folder which with the raw data;
	d) contains following two functions:
		 - ```loadDataTable(fileNameTemplate, setID, colLabels)```
	     - ```loadDataSet(setID)``` 
	   and the Main Program.

2. The function ```loadDataTable(fmTemplate, setID, colLabels)``` performs the loading of the data table.
   
Arguments:

- fnTemplate: a string, which represents a template for the name of the text file to be loaded;  
- setID:      a string, which is used in the template to construct a real name of the file to be loaded; 
- colLabels:  a vector of strings, which will be used as the labels of the columns for loaded data table.

Implementation details:

a) fnTemplate contains the "setID" fragment(s), which will be substituted by value of the input variable setID
b) fileName constructed in (a) is used as an input parameter of the read.table(fileName)
c) colLabels are assigned as a column names of the constructed table.
	
3. The function ```loadDataSet(setID)``` creates the tidy data set by loading, transforming and combining corresponding data tables (subject_IDs, activity_IDs, measurements)

Argument:
   
- setID: a string, which is used in the template to construct a real name of the file to be loaded;


   Variable from the Global Environment used:
   
	 - Person_ID_label:	   string 
	 - Activity_ID_label:  string 
	 - activity_labels:    vector of strings
     - features:           vector of strings
     - extracted_features: vector of logical values (i-th coordinate is TRUE, if it corresponds to measurements on the mean OR standard deviation)

Implementation details:

a) the local variables Person_IDs, y, X, which represent the person's IDs, activity IDs and the measurements, respectively, are constructed by calling the function loadDataTable with corresponding parameters first.
	   After such calls
	     - vector of activity indexes y is converted into vector of corresponding activity names.
		 - we use the extracted_features vector to construct X only from specific columns of the table.
b) tidy data set is constructed by combining the columns of three tables:
	      ```cbind(Person_IDs, y, X)```

4. 	Main Program:
    a) loads string vectors features,  activity_labels by reading the information from corresponding files. Besides that 
	   - we remove "()" from all elements of the feature vector.
	   - we will use only 2-nd column of the data set (which corresponds to activity_labels.txt file) AND we convert all activity names into low characters.
	b) by searching for "mean" OR "std" in the elements of the features vector, we construct the logical vector 
	      ```extracted_features <- grepl("(mean|std)", features, ignore.case=TRUE)```
    c) the variables Person_ID_label and Activity_ID_label are defined as "Person_ID" and "Activity_Name", respectively.
	d) the loading of the test and train data is performed by
	       test_data  <- loadDataSet("test")
           train_data <- loadDataSet("train")
	e) by merging the test and train data, we construct
        ```tidy_data <- rbind(test_data, train_data)```
    f) by using the melt/dcast functions from "reshape2" library, we calculate data set tidy_data_mean, which contains the average of each variable for each activity and each subject.
    g) tidy_data and tidy_data_mean data sets are written into corresponding text files.	
    