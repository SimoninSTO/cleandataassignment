the code first read in the features file to provide the variable names,

then read in training data,

the x_train file contain most of the data, the y_train and subject_train contains subject information and activeiy information, 
then combine these three we got the training dataset, finally add the variable names

then same is done with the test data.

Then combining the training and test data together by rbind function to generate data.all. 

Then extract the columns from data.all that contains either mean or std in the varibale names to form data.sub

In order to label the activity with descriptive names, the activity_labels file is read in. Attach the activity to the first columns of this activity_label file, merge is used to combining the data.sub and activity_labels together by the common column "activity". 
This way the one more column called "activity names" is added to the data. 

The change the names of the varibale by using gsub function.

finally, independent tidy data set with the average of each variable for each activity and each subject is created by aggregate function and written out by write.csv function. 