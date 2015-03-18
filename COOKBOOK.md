# COOKBOOK

This is a detailed description of the transformation applied to the dataset

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

in order to generate docao.txt. The script (run_analysis.R) is divided into 6 parts: the first part defines the filenames, while the others follow the same steps than in the questions, ie step 1 is the answer to question 1 and so on. All units are the same than defined in the original raw data.

## DEFINE FILES
This is a preliminary section to define the filenames and the directories. The script assumes that the downloaded files are all placed with their original name into the "your_working_directory/UCI_HAR_Dataset/" directory.


## STEP 1
Read in all the necessary data, and row-bind them. Each datasets (features, activity and subjects) are kept separated until step4 to make step2 and step3 easier.

	*df1 : dataframe containing features values
	*df2 : dataframe containing the activity 
	*df3 : dataframe containing the subject, ie volunteer identification number

## STEP 2
Subselect in df1 only the mean and standard deviation values of features, using regular expression. We look for the features names containing mean() or std(). Note that we excluded FreqMean for example because it has a different physical meaning.

## STEP 3
I create a dictionnary between a number and activity. I then replace the number by the activity name, using factors to be able to sort them in step5.

## STEP 4
Remove the parenthesis in column name of dataframe1
Add activity and volunteer number to dataframe1 : this is the final dataframe

## STEP 5
We compute the mean of each feature for each combination of (activity, volunteer). For example, if there is 2 activities and 3 volunteers, the final number of rows are 2*3=6.

## OUTPUT
We finally dump the file containing the processed dataframe. The final output contains 180 rows and 68 columns. Each row corresponds to the average of each variable for each activity and each subject, in same units than the raw data.

