# CodeBook

This code book describes the variables, the data and transformations which were performed to clean up the data.


## Data Source:

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Description of the data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## Data Set Information:

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


## The data:

The dataset includes the following files:

- 'README.txt'
- 'features_info.txt':   Information about the variables used on the feature vector.
- 'features.txt': 		 List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

The following files contain
- 'SET_ID/X_SET_ID.txt': 		measurements obtained for different subjects and different activities
- 'SET_ID/y_SET_ID.txt': 		set of activity_IDs. Each element is an identifier of the activity performed for each window sample, its range is from 1 to 6. 
- 'SET_ID/subject_SET_ID.txt':  set of subject_IDs. Each element is an identifier of the subject who performed the activity for each window sample, its range is from 1 to 30. 

The following files are also available for the train and test data, but they were not used for that project. Their descriptions are equivalent for AXIS = X, Y, Z.
- 'SET_ID/Inertial Signals/total_acc_AXIS_SET_ID.txt': The acceleration signal from the smartphone accelerometer AXIS in standard gravity units 'g'. Every row shows a 128 element vector. 
- 'SET_ID/Inertial Signals/body_acc_AXIS_SET_ID.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.
- 'SET_ID/Inertial Signals/body_gyro_AXIS_SET_ID.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


## Transformation details:

There are 5 parts:

1. Merging of the train and the test sets to create one data set.
2. Extraction of the measurements only for the mean and standard deviation for each measurement.
3. The descriptive activity names should be used in the data set
4. The data set columns should be appropriately labelled with descriptive names.
5. Second, independent tidy data set with the average of each variable for each activity and each subject should be created.


## Implementation details:

1. All transformations of the data are implemented in ```run_analysis.R``` script.
2. This script uses ```data.table``` and ```reshapre2``` libraries, which will be installed automatically
3. It loads the features and activity labels.
4. It loads the measurements and associates corresponding subject IDs activity names with them. 
5. It extracts the columns, corresponding to the mean and standard deviations.
6. It does the steps 4 and 5 for test and train data.
7. It merges data sets, created on step 6.
8. For the data set created on step 7, it calculates the average of each variable for each activity and each subject.
9. It writes the data sets, created on step 7 and 8 into ```tidy_data.txt``` and ```tidy_data_mean.txt```, respectively.

## Variable names are:

"Person_ID"                 
"Activity_Name"             
"tBodyAcc-mean-X"          
"tBodyAcc-mean-Y"           
"tBodyAcc-mean-Z"           
"tBodyAcc-std-X"           
"tBodyAcc-std-Y"            
"tBodyAcc-std-Z"            
"tGravityAcc-mean-X"       
"tGravityAcc-mean-Y"        
"tGravityAcc-mean-Z"        
"tGravityAcc-std-X"        
"tGravityAcc-std-Y"         
"tGravityAcc-std-Z"         
"tBodyAccJerk-mean-X"      
"tBodyAccJerk-mean-Y"       
"tBodyAccJerk-mean-Z"       
"tBodyAccJerk-std-X"       
"tBodyAccJerk-std-Y"        
"tBodyAccJerk-std-Z"        
"tBodyGyro-mean-X"         
"tBodyGyro-mean-Y"          
"tBodyGyro-mean-Z"          
"tBodyGyro-std-X"          
"tBodyGyro-std-Y"           
"tBodyGyro-std-Z"           
"tBodyGyroJerk-mean-X"     
"tBodyGyroJerk-mean-Y"      
"tBodyGyroJerk-mean-Z"      
"tBodyGyroJerk-std-X"      
"tBodyGyroJerk-std-Y"       
"tBodyGyroJerk-std-Z"       
"tBodyAccMag-mean"         
"tBodyAccMag-std"           
"tGravityAccMag-mean"       
"tGravityAccMag-std"       
"tBodyAccJerkMag-mean"      
"tBodyAccJerkMag-std"       
"tBodyGyroMag-mean"        
"tBodyGyroMag-std"          
"tBodyGyroJerkMag-mean"     
"tBodyGyroJerkMag-std"     
"fBodyAcc-mean-X"           
"fBodyAcc-mean-Y"           
"fBodyAcc-mean-Z"          
"fBodyAcc-std-X"            
"fBodyAcc-std-Y"            
"fBodyAcc-std-Z"           
"fBodyAccJerk-mean-X"       
"fBodyAccJerk-mean-Y"       
"fBodyAccJerk-mean-Z"      
"fBodyAccJerk-std-X"        
"fBodyAccJerk-std-Y"        
"fBodyAccJerk-std-Z"       
"fBodyGyro-mean-X"          
"fBodyGyro-mean-Y"          
"fBodyGyro-mean-Z"         
"fBodyGyro-std-X"           
"fBodyGyro-std-Y"           
"fBodyGyro-std-Z"          
"fBodyAccMag-mean"          
"fBodyAccMag-std"           
"fBodyBodyAccJerkMag-mean" 
"fBodyBodyAccJerkMag-std"   
"fBodyBodyGyroMag-mean"     
"fBodyBodyGyroMag-std"     
"fBodyBodyGyroJerkMag-mean" 
"fBodyBodyGyroJerkMag-std" 
