train <- read.table("UCI\ HAR\ Dataset\\train\\X_train.txt")
subject_train <- read.table("UCI\ HAR\ Dataset\\train\\subject_train.txt")
activity_train <- read.table("UCI\ HAR\ Dataset\\train\\y_train.txt")

test <- read.table("UCI\ HAR\ Dataset\\test\\x_test.txt")
subject_test <- read.table("UCI\ HAR\ Dataset\\test\\subject_test.txt")
activity_test <- read.table("UCI\ HAR\ Dataset\\test\\y_test.txt")

features <- read.table("UCI\ HAR\ Dataset\\features.txt", colClasses=c("integer", "character")) 

#Step1: merges the training and the test sets to create one data set. 
train_n_test <- rbind(train, test)
subject <- rbind(subject_train, subject_test)
activity <- rbind(activity_train, activity_test)

tidy <- cbind(subject,activity,train_n_test)

names(tidy)[1:2] <- c("subject", "activity")

#Step2: extracts only the measurements on the mean and standard deviation for each measurement.
mean <- grep("mean()",features$V2, value="FALSE", fixed="TRUE")
std <- grep("std()",features$V2, value="FALSE", fixed="TRUE")
mean_n_std <- sort(c(mean,std))

tidy <- tidy[, c("subject", "activity", paste("V", mean_n_std, sep=""))]

#Step3: uses descriptive activity names to name the activities in the data set
tidy[tidy$activity == 1, 'activity'] <- "WALKING"           
tidy[tidy$activity == 2, 'activity'] <- "WALKING UPSTAIRS"
tidy[tidy$activity == 3, 'activity'] <- "WALKING DOWNSTAIRS"
tidy[tidy$activity == 4, 'activity'] <- "SITTING"
tidy[tidy$activity == 5, 'activity'] <- "STANDING"
tidy[tidy$activity == 6, 'activity'] <- "LAYING"

#Step4: appropriately labels the data set with descriptive variable names.
mean_n_std_features <- features$V2[mean_n_std]  
names(tidy) <- c("subject", "activity", mean_n_std_features)

#Step5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
second_tidy <- aggregate(tidy[, mean_n_std_features], list(subject = tidy$subject, activity = tidy$activity), mean)

#Step 6: write them to 2 tidy files
write.table(tidy, file="tiny_data.csv", sep=",")
write.table(second_tidy, file="mean_tiny_data.csv", sep=",")
