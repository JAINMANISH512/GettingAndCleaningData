#"UCI HAR Dataset" is the working directory

#Read files of subject id's,feature vectors(X_test),actitvity labels(y_test) for test as well as train sets

subject_test <- read.table("test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)
X_test <- read.table("test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
y_test <- read.table("test/y_test.txt", quote="\"", stringsAsFactors=FALSE)

subject_train <- read.table("train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
X_train <- read.table("train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
y_train <- read.table("train/y_train.txt", quote="\"", stringsAsFactors=FALSE)


#Read the feature names from "features" file
features <- read.table("features.txt", quote="\"", stringsAsFactors=FALSE)

#Read activity labels from "activity_label" file
activity_labels <- read.table("activity_labels.txt", quote="\"", stringsAsFactors=FALSE)
 
#Step 1:Merging

#naming columns of X_test,X_train datasets using features datafframe
names(X_test)<-features[,2]
names(X_train)<-features[,2]

#naming columns of subject_test,subject_train datasets as "subjectid"
names(subject_test)<-"subjectid"
names(subject_train)<-"subjectid"

#naming columns of y_test,y_train datasets as "activitylabel"
names(y_test)<-"activitylabel"
names(y_train)<-"activitylabel"

#column binding subject_test,y_test,X_test into single dataset "test"
test<-cbind(subject_test,y_test,X_test)

#column binding subject_train,y_train,X_train into single dataset "train"
train<-cbind(subject_train,y_train,X_train)

#Row binding(merging) test and train data into single dataset "data"
data<-rbind(train,test)

#Step 2: ExtractING only the measurements on the mean and standard deviation for each measurement

#changing the names of the dataset to lower case for easy search of desired column names later
names(data)<-tolower(names(data))

#collecting desired column names (names having "mean()"or"std()"or"subjectid"or"activitylabel")
colNames<-colnames(data)
DesiredNames <-(colNames[(grepl("mean\\()",colNames) | grepl("std\\()",colNames) | grepl("subjectid",colNames) | grepl("activitylabel",colNames)) ==TRUE])

#selecting desired columns
data <- data[ , DesiredNames]

#Step 3:Putting descriptive activity names to name the activities in the data set

#Using grep function repllacing numeric label to activity name in "data" using "activity_labels"dataframe
data[grep("1",data$activitylabel),2]<-activity_labels[1,2]
data[grep("2",data$activitylabel),2]<-activity_labels[2,2]
data[grep("3",data$activitylabel),2]<-activity_labels[3,2]
data[grep("4",data$activitylabel),2]<-activity_labels[4,2]
data[grep("5",data$activitylabel),2]<-activity_labels[5,2]
data[grep("6",data$activitylabel),2]<-activity_labels[6,2]

#Step 4:Appropriately labelling the data set with descriptive variable names.(using gsub)

#Names stored in new variable naming
naming<-names(data)

naming<-gsub("freq","frequency",naming) #Changing 'freq' to 'frequency'
naming<-gsub("^f","frequencydomain",naming) #Changing names starting with 'f'
naming<-gsub("^t","timedomain",naming) #Changing name starting with 't'
naming<-gsub("acc","accelerometer",naming) #Changing 'acc' to 'accelerometer'
naming<-gsub("gyro","gyroscope",naming) #Changing 'gyro' to 'gyroscope'
naming<-gsub("mag","magnitude",naming) #Changing 'mag' to 'magnitude'
naming<-gsub("std","standarddeviation",naming) #Changing 'std' to 'standarddeviation'
naming<-gsub("-x","xaxis",naming) #Changing '-x' to 'xaxis'
naming<-gsub("-y","yaxis",naming) #Changing '-y' to 'yaxis'
naming<-gsub("-z","zaxis",naming) #Changing '-z' to 'zaxis'
naming<-gsub("\\()","",naming) #Changing names ending with '()' to '' using escape sequence
naming<-gsub("-","",naming) #Changing '-' to ''
naming<-gsub("bodybody","body",naming) #Changing 'bodybody' to 'body'

#Modifying names of variables of original dataset "data"
names(data)<-naming

#Step 5: Creating independent tidy data set with the average of each variable for each activity and each subject
library(reshape2)

#Melting data to dataMMelt
dataMelt<-melt(data,id.vars=c("subjectid","activitylabel"),measure.vars=names(data)[-(1:2)])

#Casting dataMelt tp requires TidyData dataframe
TidyData<-dcast(dataMelt,subjectid+activitylabel~variable,mean)

#writing requires dataset to text file
write.table(TidyData, file = "tidy_data.txt",row.name=FALSE)









