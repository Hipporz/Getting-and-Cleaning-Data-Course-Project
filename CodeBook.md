Code Book: Human Activity Recognition Using Smartphones Dataset
========================================================

The code book describes the variables, the data, and any transformations or work that performed to clean up the data. There are 2 tidy data files: tiny_data.csv with all mean and std variables, and mean_tiny_data.csv with all mean of variables.

## 1. Data Cleaning Process
**Step 0:** Download and extract the data (Human Activity Recognition Using Smartphones Dataset) from the link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip . Also set working place in R.

**Step 1:** Merges the training and the test sets to create one data set.
```{r}
train <- read.table("UCI\ HAR\ Dataset\\train\\X_train.txt")
subject_train <- read.table("UCI\ HAR\ Dataset\\train\\subject_train.txt")
activity_train <- read.table("UCI\ HAR\ Dataset\\train\\y_train.txt")

test <- read.table("UCI\ HAR\ Dataset\\test\\x_test.txt")
subject_test <- read.table("UCI\ HAR\ Dataset\\test\\subject_test.txt")
activity_test <- read.table("UCI\ HAR\ Dataset\\test\\y_test.txt")

features <- read.table("UCI\ HAR\ Dataset\\features.txt", colClasses=c("integer", "character"))

train_n_test <- rbind(train, test)
subject <- rbind(subject_train, subject_test)
activity <- rbind(activity_train, activity_test)

tidy <- cbind(subject,activity,train_n_test)

names(tidy)[1:2] <- c("subject", "activity")
```

**Step 2:** extracts only the measurements on the mean and standard deviation for each measurement.
```{r}
mean <- grep("mean()",features$V2, value="FALSE", fixed="TRUE")
std <- grep("std()",features$V2, value="FALSE", fixed="TRUE")
mean_n_std <- sort(c(mean,std))

tidy <- tidy[, c("subject", "activity", paste("V", mean_n_std, sep=""))]
```

**Step 3:** uses descriptive activity names to name the activities in the data set
```{r}
tidy[tidy$activity == 1, 'activity'] <- "WALKING"           
tidy[tidy$activity == 2, 'activity'] <- "WALKING UPSTAIRS"
tidy[tidy$activity == 3, 'activity'] <- "WALKING DOWNSTAIRS"
tidy[tidy$activity == 4, 'activity'] <- "SITTING"
tidy[tidy$activity == 5, 'activity'] <- "STANDING"
tidy[tidy$activity == 6, 'activity'] <- "LAYING"
```

**Step 4:**  appropriately labels the data set with descriptive variable names

```{r}
mean_n_std_features <- features$V2[mean_n_std]  
names(tidy) <- c("subject", "activity", mean_n_std_features)
```

**Step 5:** Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
```{r}
second_tidy <- aggregate(tidy[, mean_n_std_features], list(subject = tidy$subject, activity = tidy$activity), mean)
```

**Step 6:** write them to 2 tidy files
```{r}
write.table(tidy, file="tiny_data.csv", sep=",")
write.table(second_tidy, file="mean_tiny_data.csv", sep=",")
```


## 2. Dictionary
### 2.a) tiny_data.csv
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
meanFreq(): Weighted average of the frequency components to obtain a mean frequency

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

**The complete list of variables of each feature vector**

tBodyAcc-mean()-X           
tBodyAcc-mean()-Y           
tBodyAcc-mean()-Z          
tBodyAcc-std()-X            
tBodyAcc-std()-Y            
tBodyAcc-std()-Z           
tGravityAcc-mean()-X        
tGravityAcc-mean()-Y        
tGravityAcc-mean()-Z       
tGravityAcc-std()-X         
tGravityAcc-std()-Y         
tGravityAcc-std()-Z        
tBodyAccJerk-mean()-X       
tBodyAccJerk-mean()-Y       
tBodyAccJerk-mean()-Z      
tBodyAccJerk-std()-X        
tBodyAccJerk-std()-Y        
tBodyAccJerk-std()-Z       
tBodyGyro-mean()-X          
tBodyGyro-mean()-Y          
tBodyGyro-mean()-Z         
tBodyGyro-std()-X           
tBodyGyro-std()-Y           
tBodyGyro-std()-Z          
tBodyGyroJerk-mean()-X      
tBodyGyroJerk-mean()-Y      
tBodyGyroJerk-mean()-Z     
tBodyGyroJerk-std()-X       
tBodyGyroJerk-std()-Y       
tBodyGyroJerk-std()-Z      
tBodyAccMag-mean()          
tBodyAccMag-std()           
tGravityAccMag-mean()      
tGravityAccMag-std()        
tBodyAccJerkMag-mean()      
tBodyAccJerkMag-std()      
tBodyGyroMag-mean()         
tBodyGyroMag-std()          
tBodyGyroJerkMag-mean()    
tBodyGyroJerkMag-std()      
fBodyAcc-mean()-X           
fBodyAcc-mean()-Y          
fBodyAcc-mean()-Z           
fBodyAcc-std()-X            
fBodyAcc-std()-Y           
fBodyAcc-std()-Z            
fBodyAccJerk-mean()-X       
fBodyAccJerk-mean()-Y      
fBodyAccJerk-mean()-Z       
fBodyAccJerk-std()-X        
fBodyAccJerk-std()-Y       
fBodyAccJerk-std()-Z        
fBodyGyro-mean()-X          
fBodyGyro-mean()-Y         
fBodyGyro-mean()-Z          
fBodyGyro-std()-X           
fBodyGyro-std()-Y          
fBodyGyro-std()-Z           
fBodyAccMag-mean()          
fBodyAccMag-std()          
fBodyBodyAccJerkMag-mean()  
fBodyBodyAccJerkMag-std()   
fBodyBodyGyroMag-mean()    
fBodyBodyGyroMag-std()      
fBodyBodyGyroJerkMag-mean() 
fBodyBodyGyroJerkMag-std()

### 2.b) mean_tiny_data.csv

The file includes all mean of variables in the file tiny_data.csv.