##currentdir <- getwd()
##setwd("C://Users//paulofv//coursera//Getting&CleaningData//project")

##
## reading features and activity labels
##
##setwd("C://Users//paulofv//coursera//Getting&CleaningData//project//UCI HAR Dataset")
features <- read.table("./features.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

##
## reading test data
##
##setwd("C://Users//paulofv//coursera//Getting&CleaningData//project//UCI HAR Dataset//test")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
##setwd("C://Users//paulofv//coursera//Getting&CleaningData//project//UCI HAR Dataset//test//Inertial Signals")
##body_acc_x_test <- read.table("./body_acc_x_test.txt")
##body_acc_y_test <- read.table("./body_acc_y_test.txt")
##body_acc_z_test <- read.table("./body_acc_z_test.txt")
##total_acc_x_test <- read.table("./total_acc_x_test.txt")
##total_acc_y_test <- read.table("./total_acc_y_test.txt")
##total_acc_z_test <- read.table("./total_acc_z_test.txt")
##body_gyro_x_test <- read.table("./body_gyro_x_test.txt")
##body_gyro_y_test <- read.table("./body_gyro_y_test.txt")
##body_gyro_z_test <- read.table("./body_gyro_z_test.txt")

## reading training data
setwd("C://Users//paulofv//coursera//Getting&CleaningData//project//UCI HAR Dataset//train")
x_train <- read.table("./x_train.txt")
y_train <- read.table("./y_train.txt")
subject_train <- read.table("./subject_train.txt")
setwd("C://Users//paulofv//coursera//Getting&CleaningData//project//UCI HAR Dataset//train//Inertial Signals")
body_acc_x_train <- read.table("./body_acc_x_train.txt")
body_acc_y_train <- read.table("./body_acc_y_train.txt")
body_acc_z_train <- read.table("./body_acc_z_train.txt")
total_acc_x_train <- read.table("./total_acc_x_train.txt")
total_acc_y_train <- read.table("./total_acc_y_train.txt")
total_acc_z_train <- read.table("./total_acc_z_train.txt")
body_gyro_x_train <- read.table("./body_gyro_x_train.txt")
body_gyro_y_train <- read.table("./body_gyro_y_train.txt")
body_gyro_z_train <- read.table("./body_gyro_z_train.txt")

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
##test_ds <- cbind(subject_test,y_test,x_test_sub,body_acc_x_test,body_acc_y_test,body_acc_z_test,body_gyro_x_test,
##                 body_gyro_y_test,body_gyro_z_test,total_acc_x_test,total_acc_y_test,total_acc_z_test)
test_ds <- cbind(subject_test,y_test,x_test_sub)


##train_ds <- cbind(subject_train,y_train,x_train_sub,body_acc_x_train,body_acc_y_train,body_acc_z_train,body_gyro_x_train,
##                 body_gyro_y_train,body_gyro_z_train,total_acc_x_train,total_acc_y_train,total_acc_z_train)
train_ds <- cbind(subject_train,y_train,x_train_sub)




## merging rows
merged_ds <- rbind(train_ds,test_ds)

##
## Labelling the dataset
##
body_acc_x_names <- paste("body_acc_x_",c(1:128))
body_gyro_x_names <- paste("body_gyro_x_",c(1:128))
total_acc_x_names <- paste("total_acc_x_",c(1:128))
body_acc_y_names <- paste("body_acc_y_",c(1:128))
body_gyro_y_names <- paste("body_gyro_y_",c(1:128))
total_acc_y_names <- paste("total_acc_y_",c(1:128))
body_acc_z_names <- paste("body_acc_z_",c(1:128))
body_gyro_z_names <- paste("body_gyro_z_",c(1:128))
total_acc_z_names <- paste("total_acc_z_",c(1:128))

##names(merged_ds) <- c("Subject", "Activity",as.character(feat),body_acc_x_names,body_acc_y_names,body_acc_z_names,
##                              body_gyro_x_names,body_gyro_y_names,body_gyro_z_names,total_acc_x_names,
##                              total_acc_y_names,total_acc_z_names)
names(merged_ds) <- c("Subject", "Activity",as.character(feat))
##head(merged_ds)


        
        
##setwd(currentdir)