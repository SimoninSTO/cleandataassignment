library(data.table)
features <- read.table('./UCI HAR Dataset/features.txt', header = FALSE, sep = ' ')
features <- as.character(features[,2])
##read features(future variable names)

data.train.x <- read.table('./UCI HAR Dataset/train/X_train.txt')
data.train.y <- read.table('./UCI HAR Dataset/train/y_train.txt', header = FALSE, sep = ' ')
data.train.subject <- read.table('./UCI HAR Dataset/train/subject_train.txt',header = FALSE, sep = ' ')
##read the activity, subject and xtrain in

data.train <-  data.frame(data.train.subject, data.train.y, data.train.x)
##combining them

names(data.train) <- c(c('subject', 'activity'), features)
##attach the names to the variables 

data.test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')
data.test.y <- read.table('./UCI HAR Dataset/test/y_test.txt', header = FALSE, sep = ' ')
data.test.subject <- read.table('./UCI HAR Dataset/test/subject_test.txt', header = FALSE, sep = ' ')

data.test <-  data.frame(data.test.subject, data.test.y, data.test.x)
names(data.test) <- c(c('subject', 'activity'), features)
##same thing for the test data, reading in and label with varibale names

data <- rbind(data.train, data.test)
##merge the training and test data together 

mean_std<- grep('mean|std', names(data))
##return the number of the columns that with names containing mean or std
data.sub <- data[,c(1,2,mean_std)]
##select the columns with mean or std in the variable names

activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
names(activity.labels)<-c("activity","activity names")
data.sub<-merge(x=activity.labels,y=data.sub,by="activity")
##merge the activity labels with data.sub so that a new column of activity name is added

name.new <- names(data.sub)
name.new <- gsub("[(][)]", "", name.new)
name.new <- gsub("^t", "TimeDomain_", name.new)
name.new <- gsub("^f", "FrequencyDomain_", name.new)
name.new <- gsub("Acc", "Accelerometer", name.new)
name.new <- gsub("Gyro", "Gyroscope", name.new)
name.new <- gsub("Mag", "Magnitude", name.new)
name.new <- gsub("-mean-", "_Mean_", name.new)
name.new <- gsub("-std-", "_StandardDeviation_", name.new)
name.new <- gsub("-", "_", name.new)
names(data.sub) <- name.new
##Change names to appropriate ones

data.tidy <- aggregate(data.sub[,4:82], by = list(activity = data.sub$"activity names", subject = data.sub$subject),FUN = mean)
write.csv(data.tidy, file = "data_tidy.csv")