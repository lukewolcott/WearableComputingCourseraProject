### The Data

The data comes from the Coursera project assignment.  It originally is sourced from:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

and the file downloaded is the following.

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Within that zipped file is a README.txt file with more information about the measurements performed.  Basically 30 people (subjects) did 6 different activities while wearing a smartphone around their waist.  The smartphone's accelerometer and gyroscope collected lots of data.  Each subject performed each activity many times.  The data was split into a training group and a test group.

The smartphone recorded lots of measurements, and these give some of the variables.  These measurements were analyzed further (e.g. mean, standard deviation), and these give other values for other variables.  All told, there are 561 variables for each instance of an activity being performed by a subject.

### The Transformations

#### Merging the data

The script run_analysis.R assumes that it is in the same directory as the unzipped data from the above file.  The first thing is does is read the data files into R.

Then it pulls together the list of subjects and activities with the table of values of all 561 variables, to make a 7352 x 563 data frame of training data (one column for subject, one for activity, 561 variables; 7352 instances of a subject doing a training activity).  This involves combining the files subject_train, y_train, and X_train.

Then it does the same with the test data, combining subject_test, y_test, and X_test into a 2947 x 563 data frame.

#### Select for mean and standard deviation variables

Out of the 561 variables derived from the accelerometer and gyroscope data, we selected those related to means and standard deviations of the original measurements.  This was done by filtering for the strings "mean" and "std" found in the 561 variable names.  The filtration left 79 variables remaining (not counting the "subject" and "activity" values).

#### Calculate mean for each variable

Each of the 30 subjects performed each of the 6 activities many times, and we were interested in averaging these instances together.  This was done using an lapply command.  The resulting data frame has 180 rows (30 x 6 = 180), and 81 columns ("subject" + "activity" + 79 variables related to means and standard deviations).

#### Tidying the data

The first column is named "subject" and the second is "activity".  The tidy data set then has 79 descriptive variable names derived from the original data set, coming from the given file features.txt.

The 180 rows were arranged according to subject.  So the first 6 rows are the 6 activities of the first subject, and the last 6 rows are the 6 activities of the 30th subject.




