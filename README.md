The R script, run_analysis.R, does the following:

* if the file isn't already downloaded, downloads the zip file & unzipps it
* loads labels&features, converts factors into character; extracts only measurements of mean & stdev
* leads & merges the train & test data
* creates tidy data with the average of each variable for each activity and each subject

The end result is shown in the file tidyData.txt.

In CodeBook you can find the list of column names and explanations of the variables. 