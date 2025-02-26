__README for Sample Data Cleaning Scripts__

__SECTION 1: Data Cleaning Script for Gapminder Dataset__

Overview:
This script performs data cleaning and preprocessing on the Gapminder dataset. The dataset contains country-level statistics such as GDP per capita, life expectancy, and population over time.

* Files Included in the ZIP Folder

1. cleaning script_nishita.R: R script for cleaning the dataset.
2. cleaned_gapminder.csv: Output file containing the cleaned dataset.
3. gapminder data cleaning script_nish.Rproj: accessible R project to load script and dataset

* Dependencies

This script requires the following R packages:
tidyverse
gapminder

*The script is coded to automatically install any missing packages before execution*


* Features of Data Cleaning Steps Covered via. script:

The script performs the following operations:

1. Loads the dataset
Uses the gapminder package to load the dataset into R.

2. Checks for missing values
Counts total missing values and provides a column-wise breakdown (if applicable).

3. Standardizes column names
Converts all column names to lowercase for consistency.

4. Ensures correct data types
- Converts categorical variables (country, continent) to factors.
- Ensures year is stored as an integer.

5. Removes duplicate rows
Identifies and removes any duplicate rows.

6. Checks for special characters
Cleans country names by removing unwanted special characters.

7. Identifies and removes extreme outliers
Uses the 99th percentile threshold to filter extreme values in GDP per capita.
Creates a histogram of GDP per capita for visualization.

8. Saves the cleaned dataset
The final cleaned dataset is saved as cleaned_gapminder.csv.

* Notes:
  a. The script is deterministic (no randomness), so no set.seed() is required.
  b. The original Gapminder dataset does not typically have missing values, but the script is structured to handle them if needed.



__SECTION #2: Data Cleaning Script for Student Dropout & Success Dataset__

* Overview: 
This script is designed to clean and preprocess the "Predict Student Dropout and Academic Success" dataset. It ensures that the data is formatted correctly, free from inconsistencies, and ready for analysis.
Cited as below, the dataset has been acquired from the UC Irvine Machine Learning Repository:  [
](https://archive.ics.uci.edu/dataset/697/predict+students+dropout+and+academic+success)
Realinho, V., Vieira Martins, M., Machado, J., & Baptista, L. (2021). Predict Students' Dropout and Academic Success [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5MC89.

* Files included in the ZIP Folder:
1. predict+students+dropout+and+academic+success.csv: Input (raw dataset)
2. cleaning script sample_nish.R: R script for cleaning the dataset
3. cleaned_student_data.csv: Output file containing the cleaned dataset

* Dependencies
- The following R packages must be installed:
  - `tidyverse`
  - `janitor`
  - `readr`

* Features of Data Cleaning Steps Covered via. script:

The script performs the following operations:

1. Ensures Reproducibility: Sets a random seed for consistent results.
2. Handles Missing Values: Identifies and reports missing values in the dataset.
3. Standardizes Column Names: Uses `clean_names()` to ensure consistent, readable column names.
4. Removes Duplicate Rows: Checks for and removes duplicate observations.
5. Handles Categorical Variables: Converts categorical columns to factors for appropriate statistical analysis.
6. Converts Numeric Variables: Ensures numeric columns are correctly typed.
7. Removes Special Characters: Cleans text columns of non-alphanumeric characters.
8. Handles Outliers: Uses the IQR method to identify and handle outliers.



For any issues or suggestions, please reach out to nishitasingh.psych@gmail.com

  
