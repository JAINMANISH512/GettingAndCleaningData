

For each record it is provided:
======================================

- A 68-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.md'

- 'run_analysis.R' : R Script containing required transformation frm raw to desired tidy dataset.

- 'CodeBook.md' : Codebook for raw as well as tidy dataset. 

Tranformation of Dataset from raw form to tidy form (run_analysis.R):
==============================================

-Read files of subject id's,feature vectors(X_test),actitvity labels(y_test) for test as well as train sets

-Read the feature names from "features" file

-Read activity labels from "activity_label" file
 

-Step 1:Merging:
================

--naming columns of X_test,X_train datasets using features datafframe

--naming columns of subject_test,subject_train datasets as "subjectid"

--naming columns of y_test,y_train datasets as "activitylabel"

--column binding subject_test,y_test,X_test into single dataset "test"

--column binding subject_train,y_train,X_train into single dataset "train"

--Row binding(merging) test and train data into single dataset "data"


-Step 2: Extracting only the measurements on the mean and standard deviation for each measurement :
====================================================================================================

--changing the names of the dataset to lower case for easy search of desired column names later

--collecting desired column names (names having "mean()"or"std()"or"subjectid"or"activitylabel") 
  (Here by using mean() we have safely removed colums like 'meanFreq()' etc.)

--selecting desired columns


-Step 3:Putting descriptive activity names to name the activities in the data set:
==================================================================================

--Using grep function repllacing numeric label to activity name in "data" using "activity_labels" dataframe


-Step 4:Appropriately labelling the data set with descriptive variable names:
==================================================================================

--labelling the data set with descriptive variable names using gsub

--Names stored in new variable naming

--Modifying names of variables of original dataset "data"


-Step 5: Creating independent tidy data set with the average of each variable for each activity and each subject:
=====================================================================================================================

--Melting data to dataMMelt

--Casting dataMelt tp requires TidyData dataframe

  Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.








