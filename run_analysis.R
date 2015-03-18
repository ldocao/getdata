###NAME: course_project.R
###PURPOSE: course project for Get and Clean data on coursera.org

library(dplyr)
library(plyr)


### DEFINE FILES
output_name="docao.txt"


main_dir <- "UCI_HAR_Dataset"
train_dir <- paste0(main_dir,"/train/")
test_dir <- paste0(main_dir,"/test/")

train_file1 <- paste0(train_dir,"X_train.txt") #features
train_file2 <- paste0(train_dir,"y_train.txt") #activity
train_file3 <- paste0(train_dir,"subject_train.txt") #subjects

test_file1 <- paste0(test_dir,"X_test.txt")
test_file2 <- paste0(test_dir,"y_test.txt")
test_file3 <- paste0(test_dir,"subject_test.txt")

features_file <- paste0(main_dir,"/features.txt")
activity_labels_file <- paste0(main_dir,"/activity_labels.txt")





### STEP 1
##read the values for features
train_df1 <- read.table(train_file1) 
test_df1 <- read.table(test_file1)
df1 <- rbind(train_df1,test_df1) 

##read activity ID name
train_df2 <- read.table(train_file2)
test_df2 <- read.table(test_file2)
df2 <- rbind(train_df2,test_df2)

##read subject ID name
train_df3 <- read.table(train_file3)
test_df3 <- read.table(test_file3)
df3 <- rbind(train_df3,test_df3)





### STEP 2
features <- read.table(features_file,col.names=c("id","feature.name"))
subset <- grep("std\\(\\)|mean\\(\\)",features$feature.name,perl=TRUE) #select column containing mean() or std()
df1 <- df1[,subset]
print(dim(df1))


### STEP3
dict <- read.table(activity_labels_file,col.names=c("id","activity"),stringsAsFactors=TRUE) #dictionnary ID => activity name
df2$V1 <- with(dict, tolower(dict$activity[match(df2$V1, dict$id)])) #replace ID by name


### STEP 4
colnames(df1) <- gsub("\\(\\)","",features$feature.name[subset]) #remove parenthesis in activity name
df<-mutate(df1,activity=df2$V1,volunteer=df3$V1) #merge all data

### STEP 5
newdf <- df %>% group_by(activity,volunteer) %>% summarise_each(funs(mean))



### OUTPUT
write.table(newdf,output_name,row.name=FALSE)

