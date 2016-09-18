library(readr)
library(dplyr)




#extracting data


mainDir <- "C:/Users/Ihussain3/Desktop/R Course/cleaning data"
subDir <- "UCI HAR Dataset"

setwd(file.path(mainDir, subDir))


feature <- read.table(file = "features.txt")

activity_label <- read.table(file = "activity_labels.txt", col.names = c("activityid","activity"))

x_test <- read_fwf(file = "./test/X_test.txt",   fwf_widths(c(rep(c(16),561))))
subject_test <- read.table(file = "./test/subject_test.txt", col.names = "subject")
activity_test <- read.table(file = "./test/y_test.txt", col.names = "activityid")

 
x_train <- read_fwf(file = "./train/X_train.txt",   fwf_widths(c(rep(c(16),561))))
subject_train <- read.table(file = "./train/subject_train.txt", col.names = "subject")
activity_train <- read.table(file = "./train/y_train.txt", col.names = "activityid")



#processing and merging data

names(x_test) <- feature[[2]]
names(x_train) <- feature[[2]]


Train <- cbind(subject_train, activity_train, x_train )
completeTrain <- merge(activity_label, Train)


Test <- cbind(subject_test, activity_test, x_test )
completeTest <- merge(activity_label, Test)


mergedDataset <- rbind(completeTrain, completeTest)



#extracting and summarizing

summarized <- mergedDataset %>% select(grep("subject|activity|std|mean",names(mergedDataset), ignore.case = TRUE)) %>% 
              group_by(subject,activity) %>% summarize_each(funs(mean))

names(summarized)<-gsub("^t", "time", names(summarized))
names(summarized)<-gsub("^f", "frequency", names(summarized))
names(summarized)<-gsub("Acc", "Accelerometer", names(summarized))
names(summarized)<-gsub("Gyro", "Gyroscope", names(summarized))
names(summarized)<-gsub("Mag", "Magnitude", names(summarized))

write.table(summarized, file = "summarizeddata.txt", row.name = FALSE)