##currentdir <- getwd()
##setwd("C://Users//paulofv//coursera//Getting&CleaningData//project")

##
## This script reads data from UCI HAR dataset, merges test and trainning datasets,
## extracts only mean and standard devition measurements and labels the dataset columns
## as part of the Getting and Cleaning Data Course Project - november/2015.
##

##
## reading features and activity labels
##
features <- read.table("./UCI HAR Dataset/features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

##
## reading test data
##
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## reading training data
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

##
## Replacing Numeric by Descriptive Activity Label
##
y_test_mod <- data.frame()
for(i in 1:dim(y_test)[1]){y_test_mod[i,1] <- activity_labels[y_test[i,1],2]}
y_train_mod <- data.frame()
for(i in 1:dim(y_train)[1]){y_train_mod[i,1] <- activity_labels[y_train[i,1],2]}

##
## extracting only mean and std measurements
##

## selecting mean and std features
aux <- NULL
for (j in 1:dim(features)[1]){
        aux[j] <- FALSE
        for(i in 1:(nchar(as.character(features[j,2]))-5)){
                if (substr(as.character(features[j,2]),i,i+5)=="mean()"){
                        aux[j] <- TRUE
                } 
        }
        for(i in 1:(nchar(as.character(features[j,2]))-4)){
                if (substr(as.character(features[j,2]),i,i+4)=="std()"){
                        aux[j] <- TRUE
                } 
        }
}
feat <- features[aux,2]
feat_index <- c(1:dim(features)[1])[aux]

## subsetting x_train and x_test for mean and std measurements
x_train_sub <- x_train[feat_index]
x_test_sub <- x_test[feat_index]


##
## Merging datasets
##

## merging columns
test_ds <- cbind(subject_test,y_test_mod,x_test_sub)
train_ds <- cbind(subject_train,y_train_mod,x_train_sub)

## merging rows
merged_ds <- rbind(train_ds,test_ds)

##
## Labelling the dataset
##
names(merged_ds) <- c("Subject", "Activity",as.character(feat))


##
## 2nd dataset with average for each subject and activity
##

## Computing averages
result <- list()
for (j in 1:30){
        average <- list()
        for (i in 3:dim(merged_ds)[2]){
                average[[i]] <- sapply(split(split(merged_ds[,i],merged_ds$Subject)[[j]],merged_ds$Activity),mean)
        }
        result[[j]] <- average
}

## organizing averages in dataset
new_ds <- data.frame()
for (i in 1:180){
        new_ds[i,1] <- (i+5)%/%6
        new_ds[i,2] <- names(result[[3]][[3]])[(i+5)%%6+1]
        for (j in 3:68){
                new_ds[i,j] <- as.numeric(result[[(i+5)%/%6]][[j]][(i+5)%%6+1])
        }
}

## labeling columns
names(new_ds) <- c("Subject", "Activity",as.character(feat))

##
## generating text file with dataset
##
##write.table(merged_ds,file = "./first_ds.txt",row.names=F)
write.table(new_ds,file = "./second_ds.txt",row.names=F)
##teste <- read.table("./second_ds.txt",header = T)

##setwd(currentdir)