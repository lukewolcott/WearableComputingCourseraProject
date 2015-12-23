run_analysis <- function(){
      # assumes unzipped folder "UCI HAR Dataset" is the working directory
      library(dplyr)
      
      # Part 1: read tables into R and merge
      subject_train <- read.table("train/subject_train.txt")
      y_train <- read.table("train/y_train.txt")
      X_train <- read.table("train/X_train.txt")
      train <- cbind(subject_train, y_train, X_train) #merge training data
      subject_test <- read.table("test/subject_test.txt")
      y_test <- read.table("test/y_test.txt")
      X_test <- read.table("test/X_test.txt")
      test <- cbind(subject_test, y_test, X_test) #merge test data
      data <- rbind(train, test)
      
      # assign variable names using features.txt
      features <- read.table("features.txt")
      var_names <- c("subject", "activity", as.character(features[,2]))
      names(data) <- var_names
      
      # Part 2: limit variables to means and st devs of measurements
      good <- grepl("mean", names(data)) | grepl("std", names(data))
      good[1:2] <- TRUE
      data <- data[,good]
      
      # Part 3: give useful names to activities, using activity_labels.txt
      activity_labels <- read.table("activity_labels.txt")
      data[,2] <- as.character(activity_labels[data[,2],2])
      
      # Part 4: assign descriptive variable names
      # (did this earlier, using features.txt)
      
      # Part 5
      avs <- function(one_activity) {
            a <- list("subject" = one_activity[1,1], "activity" = one_activity[1,2])
            y<- select(one_activity, -c(1,2))
            b <- as.list(colMeans(y))
            as.data.frame(c(a,b), optional = TRUE)
      }
      
      split_up <- split(data, list(data$subject, data$activity))
      calc_avs <- lapply(split_up, avs)
      unsplit_up <- do.call(rbind, calc_avs)
      rownames(unsplit_up) <- 1:180
      tidyData <- arrange(unsplit_up, subject)
      tidyData
}