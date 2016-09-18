# How does `run_analysis.R` work?

The script requires two packages in addition to the base R packages: `dplyr` and `readr`.

The script is divided into differenct components that serve different purposes:

* `extracting data` : Reads:
  - `activity_labels.txt`, 
  - `features.txt`,
  - `X_test.txt`, `X_train.txt` 
  - `subject_test.txt`, `subject_train.txt` 
  - `y_test.txt`, `y_train.txt` 

* `processing and merging data` :
  - Adds the feature names
  - Combines the subject details, activity details and raw data for both training and testing data sets
  - Merges training and testing data sets to get the complete data

* `extracting and summarizing` :
  - Extracts the relevant values of mean and standard deviation
  - Summarizes all the data by subject and activity
  - Renames the  variables so that they are more understandable


