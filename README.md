__Data Cleaning Script for Gapminder Dataset__

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


* Data Cleaning Steps Covered via. script:

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
