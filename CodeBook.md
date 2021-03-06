# CodeBook

## In order to make the data more read-able, the following changes were made:

1.
The files:
X_train.txt
X_test.txt
were given the column titles from features.txt

2.
y_train.txt
y_test.txt
were given the column title 'ActivityId'

3.
subject_train.txt
subject_test.txt
were given the column title SubjectId

4.
features.txt
was given the column titles featureId and featureName

5.
activity_labels.txt
was given the column titles ActivityId ActivityName

6.
y_train.txt
y_test.txt
were merged with activity_labels.txt to provide clarity to the activityIDs

7.
The data was then appended together into a single dataset (Merged_Data) containing the following for both the test and train datasets:
* Activity Name and ID from y_test.txt, y_train.txt, and activity_labels.txt
* SubjectId from subject_train.txt and subject_test.txt
* The measured values from X_train.txt,X_test.txt with the columns headers from activity_labels.txt

8.
A separate (Merged_Data_SummaryStats) was then created which contained only:
* the subjectIDs
* activityId and Name
* mean and std metrics

9.
The column headings were then cleaned by making the following changes:
* Acc was changed to Accelerator
* Mag was changed to Magnitude
* Gyro was changed to Gyroscope
* leading "t" were changed to "time"
* leading "f" were changed to "frequency"
* '()' were removed

10.
A Second Independent Tiny Data Set (called "SecondIndependentTinyDataSet") was then created which contained the mean of each metric
on a SubjectID, ActivityName level
