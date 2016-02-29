#Start by ensuring the required packages are installed 
if (!require("plyr")) install.packages("plyr")
if (!require("data.table")) install.packages("data.table")

#create directory for data to be downloaded
if(!file.exists("./data1")){dir.create("./data1")}

#download and unzip files in data1 directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileUrl,destfile="./data1/Dataset.zip",mode='wb')
unzip("./data1/Dataset.zip",exdir="./data1")

#Assign all test and training data to variables
train_data_x <- read.table("./data1/UCI HAR Dataset/train/X_train.txt")
test_data_x <- read.table("./data1/UCI HAR Dataset/test/X_test.txt")
train_data_y <- read.table("./data1/UCI HAR Dataset/train/y_train.txt")
test_data_y <- read.table("./data1/UCI HAR Dataset/test/y_test.txt")
train_data_subject <- read.table("./data1/UCI HAR Dataset/train/subject_train.txt")
test_data_subject <- read.table("./data1/UCI HAR Dataset/test/subject_test.txt")

#Gather list of features and labels and assign them to variables
features_list <- read.table("./data1/UCI HAR Dataset/features.txt",col.names=c("featureId", "featureName"))
activity_labels_list <- read.table("./data1/UCI HAR Dataset/activity_labels.txt",col.names=c("ActivityId", "ActivityName"))

#Assign names to dataset columns
colnames(train_data_x) <- t(features_list[2])
colnames(test_data_x) <- t(features_list[2])
colnames(train_data_y)<-c("ActivityId")
colnames(test_data_y)<-c("ActivityId")
colnames(train_data_subject)<-c("SubjectId")
colnames(test_data_subject)<-c("SubjectId")

#### Accidently did number 3 earlier than planned.
#### Number 3
#Uses descriptive activity names to name the activities in the data set
#Cross reference activityID with Activityname for readability
train_data_y_xref<-merge(train_data_y,activity_labels_list)
test_data_y_xref<-merge(test_data_y,activity_labels_list)

#Append activityids and subjectids to datasets
Full_Train_Data<-cbind(train_data_y_xref,train_data_subject,train_data_x)
Full_Test_Data<-cbind(test_data_y_xref,test_data_subject,test_data_x)

#### Number 1
#Merges the training and the test sets to create one data set.
Merged_Data<-rbind(Full_Train_Data,Full_Test_Data)

#### Number 2
#Extracts only the measurements on the mean and standard deviation for each measurement.
Merged_Data_SummaryStats <- Merged_Data[,grepl("mean|std|Subject|Activity", names(Merged_Data))]

#### Number 4
#Appropriately labels the data set with descriptive names.
#We will replace abbreviations and remove the '()' symbol in the column names

names(Merged_Data_SummaryStats) <- gsub("Acc", "Accelerator", names(Merged_Data_SummaryStats))
names(Merged_Data_SummaryStats) <- gsub("Mag", "Magnitude", names(Merged_Data_SummaryStats))
names(Merged_Data_SummaryStats) <- gsub("Gyro", "Gyroscope", names(Merged_Data_SummaryStats))
names(Merged_Data_SummaryStats) <- gsub("^t", "Time_", names(Merged_Data_SummaryStats))
names(Merged_Data_SummaryStats) <- gsub("^f", "Frequency_", names(Merged_Data_SummaryStats))
names(Merged_Data_SummaryStats) <- gsub("\\(\\)", "", names(Merged_Data_SummaryStats))

#### Number 5
#From the data set in step 4, creates a second, independent tidy data set 
#with the average of each variable for each activity and each subject.

#First create data table
SecondIndependentTinyDataSet_Table<-data.table(Merged_Data_SummaryStats)
#Using lapply, group by Activity, subject
SecondIndependentTinyDataSet <- SecondIndependentTinyDataSet_Table[, lapply(.SD, mean), by = 'SubjectId,ActivityName']
#Write to text file in current directory
write.table(SecondIndependentTinyDataSet, file = "./SecondIndependentTinyDataSet.txt", row.names = FALSE)



