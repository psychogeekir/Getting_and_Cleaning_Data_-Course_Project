
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
    download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
    unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

###############################################

# reading features and activity file

dir = "./UCI HAR Dataset/"

features = read.table(paste(dir,"features.txt",sep=""))

activity = read.table(paste(dir,"activity_labels.txt",sep=""))

###############################################

# reading test file

dir1 = "./UCI HAR Dataset/test/"

name.file1 = list.files(dir1,pattern = "*.txt")

test.data1 = lapply(1:length(name.file1), function(x) read.table(paste(dir1, name.file1[x], sep="")))

names(test.data1) = name.file1



###########################################

# reading train file

dir1 = "./UCI HAR Dataset/train/"

name.file1 = list.files(dir1,pattern = "*.txt")

train.data1 = lapply(1:length(name.file1), function(x) read.table(paste(dir1, name.file1[x], sep="")))

names(train.data1) = name.file1



########################################

# merging the test set and the train set

X_all = merge(test.data1$"X_test.txt",train.data1$"X_train.txt", sort = FALSE, all = TRUE)

# an identical but faster way is using rbind due to their same features vector
# X_an = rbind(test.data1$"X_test.txt",train.data1$"X_train.txt") 
# identical(X_an,X_all)

# write.csv2(X_all, "X_all.txt", fileEncoding="UTF-8", quote=FALSE)

#######################################

# extracting the mean and the std variables

ind = grep(pattern = "*mean\\(\\)*|*std\\(\\)*", features[,2])

X_sub = X_all[,ind]

colnames(X_sub) = features[ind,2]

#######################################

# adding columns indicating subjects and activity names respectively

all_act = rbind(test.data1$"y_test", train.data1$"y_train")

X_sub$activity = sapply(1:length(all_act[,1]), function(x) activity[all_act[x,1],2] )

X_sub$subject = rbind(test.data1$"subject_test", train.data1$"subject_train")[,1]

# write.csv2(X_sub, "X_sub.txt", fileEncoding="UTF-8", quote=FALSE)

#######################################

# creating a new tidy set with the average of each variable for each activity and each subject

result = aggregate(X_sub[,1:(dim(X_sub)[2]-2)], by=list(X_sub$activity, X_sub$subject), FUN = mean)

colnames(result)[1:2] = c("activity", "subject")

# save as a csv file

write.csv2(result, "result.txt", fileEncoding="UTF-8", quote=FALSE)

