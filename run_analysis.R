#read in train/y_train.txt file
y<-read.table("train/y_train.txt", stringsAsFactors=FALSE)

#read in train/x_train.txt file
x<-read.table("train/x_train.txt", stringsAsFactors=FALSE)

#read in train/subject_train.txt file
s<-read.table("train/subject_train.txt", stringsAsFactors=FALSE)

#read in features.txt file
f<-read.table("features.txt", stringsAsFactors=FALSE)

#match x column names with activity labels in features file
names(x)<-c(as.character(f$V2))

#merge y and x, and rename V1 in train dataset as "activity"
train<-cbind(y,x)
names(train)[1]<-"activity"

#merge s and train, and rename V1 in train dataset as "subject"
train<-cbind(s, train)
names(train)[1]<-"subject"

#read in test/y_test.txt file
y1<-read.table("test/y_test.txt", stringsAsFactors=FALSE)

#read in test/x_test.txt file
x1<-read.table("test/x_test.txt", stringsAsFactors=FALSE)

#read in test/subject_test.txt file
s1<-read.table("test/subject_test.txt", stringsAsFactors=FALSE)

#match x1 column names with activity labels in features file
names(x1)<-c(as.character(f$V2))

#merge y1 and x1, and rename V1 in test dataset as "activity"
test<-cbind(y1,x1)
names(test)[1]<-"activity"

#merge test and test, and rename V1 in test dataset as "subject"
test<-cbind(s1, test)
names(test)[1]<-"subject"

#combine train and test
data<-rbind(train, test)

#select variables with "mean", or with "std" in variable names and generate lists of column numbers
m<-grep("mean",names(data))
s<-grep("std", names(data))

#subset data to keep variables with "mean" or "std" in variable names
newdata<-data[,c(1:2, m, s)]

#change the label of activity to descriptive activity names 
newdata$activity<-gsub(1, "walking", newdata$activity)
newdata$activity<-gsub(2, "walking_upstairs", newdata$activity)
newdata$activity<-gsub(3, "walking_downstairs", newdata$activity)
newdata$activity<-gsub(4, "sitting", newdata$activity)
newdata$activity<-gsub(5, "standing", newdata$activity)
newdata$activity<-gsub(6, "laying", newdata$activity)

#create a new variable by pasting "subject" and "activity" together
newdata$subact<-paste(newdata$subject, newdata$activity)

#melt newdata by passing the dataset to melt function, putting "subject", "activity", and "subact" as id values, and putting the remaining variables as measure values
library(reshape2)
name<-names(newdata)[3:81]
newdatamelt<-melt(newdata, id=c("subject", "activity", "subact"), measure.vars=name)

#creates a tidy data set with the average of each variable for each activity and each subject
tidy<-dcast(newdatamelt, subact ~ variable, mean)

#replace column labels of the tidy dataset with appropriate names
names(tidy)<-gsub("-", "", names(tidy))
names(tidy)<-gsub("\\(\\)", "", names(tidy))

#export the tidy dataset to a txt file
write.table(tidy, "tidy.txt", sep=",")
library(xlsx)
write.xlsx(tidy, "tidy.xlsx")
