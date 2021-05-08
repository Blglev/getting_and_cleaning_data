**The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set**

*Review criteria:*
The submitted data set is tidy. 
The Github repo contains the required scripts.
GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
The README that explains the analysis files is clear and understandable.
The work submitted for this project is the work of the student who submitted it.

*This repo contains:*
1. run_analysis.R - the main file with code
2. codebook.md
3. newdata.txt - the output file
4. README.md - what you are reading now

*EXPLANATION OF CODE*
0. Installing package and setting WD
1. Downloading and unzipping file with data
 **a**. Downloading and putting into a folder
 **b**. Unzipping file
2. Reading the data
 **a**. Reading activity file
 **b**. Reading Subject file
 **c**. Reading feature file
3. Merging the training and the test datasets to create one dataset
 **a**. Concatenate the data tables by rows
 **b**. Naming the cols
 **c**. Merging the data
4. Extracting only the means and st. deviations for each measurement
5. Appropriately labels the data set with descriptive variable names
6. Creating a second, independent tidy dataset with the average of each variable for each activity and each subject

