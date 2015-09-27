library(reshape2)

## Download & unzip:
if (!file.exists("UCI HAR Dataset")){
  download.file("http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.zip", destfile= "./MeasureData.zip")
  unzip("./MeasureData.zip")
}  


# Loading labels & features, converting factors into char.
Labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
Labels[,2] <- as.character(Labels[,2])
Features <- read.table("./UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extracts only the measurements on the mean and standard deviation for each measurement. 
Features_mean_std <- grep(".*mean.*|.*std.*", Features[,2])
Features1 <- Features[Features_mean_std,2]

# Load & merge data
train <- read.table("./UCI HAR Dataset/train/X_train.txt")[Features_mean_std]
t.Act <- read.table("./UCI HAR Dataset/train/Y_train.txt")
t.Sub <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(t.Sub, t.Act, train)

test <- read.table("./UCI HAR Dataset/test/X_test.txt")[Features_mean_std]
te.Act <- read.table("UCI HAR Dataset/test/Y_test.txt")
te.Sub <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(te.Sub, te.Act, test)

mergedData <- rbind(train, test)
colnames(mergedData) <- c("subject", "activity", Features1)

# create tidy data with the average of each variable for each activity and each subject
mergedData$activity <- factor(mergedData$activity, levels = Labels[,1], labels = Labels[,2])
mergedData$subject <- as.factor(mergedData$subject)

Data2 <- melt(mergedData, id = c("subject", "activity"))
Data2.mean <- dcast(Data2, subject + activity ~ variable, mean)

write.table(Data2.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)