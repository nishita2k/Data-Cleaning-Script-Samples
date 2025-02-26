df <- read.csv("~/Desktop/predict+students+dropout+and+academic+success.csv")
#-------------------------------------------------
# Data Cleaning Script for Student Dropout & Success Dataset
# Author: Nishita Singh
# Date: [2025-02-25]
# Purpose: Cleaning and Preprocessing UCI dataset on Student Dropout for BCI Application, UMICH
#-------------------------------------------------

#installing & loading required packages
required_packages <- c("tidyverse", "janitor", "readr")

#installing missing packages
for (pkg in required_packages) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg)
  }
}

#loading libraries
library(tidyverse)
library(janitor)
library(readr)

#seed for reproducibility
set.seed(1708)

#file paths
input_file <- "Desktop/predict+students+dropout+and+academic+success.csv"
output_file <- "Desktop/cleaned_student_data.csv"

#loading the dataset
data <- read_csv(input_file, col_types = cols())
print("Dataset loaded successfully")

#ensuring the dataset is read correctly
data <- read_delim("Desktop/predict+students+dropout+and+academic+success.csv", 
                   delim = ";", 
                   col_types = cols(), 
                   locale = locale(encoding = "UTF-8"))

#cleaning and organizing column names
colnames(data) <- gsub("\t", "", colnames(data))  # Remove tabs
colnames(data) <- trimws(colnames(data))  # Trim spaces

#debugging: check column names
print(colnames(data))  

#checking if categorical variables are missing
missing_cols <- setdiff(categorical_vars, colnames(data))
print(missing_cols)  # debugging missing columns

#final check
print(colnames(data))

#checking missing values
missing_values <- sum(is.na(data))
print(paste("Total missing values:", missing_values))
if (missing_values > 0) {
  print("Missing values per column:")
  print(colSums(is.na(data)))
}

##Handling Missing Values
#applying function to replace missing values for numeric columns with median
replace_na_numeric <- function(x) {
  ifelse(is.na(x), median(x, na.rm = TRUE), x)
}

#applying function to replace missing values for categorical columns with mode
replace_na_categorical <- function(x) {
  mode_val <- names(sort(table(x), decreasing = TRUE))[1]  #find most frequent value
  ifelse(is.na(x), mode_val, x)
}

##Final Check
missing_values_after <- sum(is.na(data))
print(paste("Total missing values after handling:", missing_values_after))

#standardizing column names
data <- data %>% clean_names()
print("Column names standardized.")

#removing duplicate rows
duplicates <- data[duplicated(data), ]
print(paste("Number of duplicate rows found:", nrow(duplicates)))
data <- data %>% distinct()
print("Duplicate rows removed.")

#converting categorical variables to factors
categorical_vars <- c("marital_status", "application_mode", "course", "nacionality",
                      "mothers_qualification", "fathers_qualification", "mothers_occupation",
                      "fathers_occupation", "displaced", "educational_special_needs", "debtor",
                      "tuition_fees_up_to_date", "gender", "scholarship_holder", "international",
                      "target")
data[categorical_vars] <- lapply(data[categorical_vars], as.factor)
print("Categorical variables converted to factors.")

#converting numeric variables to appropriate type
numeric_vars <- c("previous_qualification_grade", "admission_grade", "age_at_enrollment", 
                  "curricular_units_1st_sem_credited", "curricular_units_1st_sem_enrolled", 
                  "curricular_units_1st_sem_evaluations", "curricular_units_1st_sem_approved", 
                  "curricular_units_1st_sem_grade", "curricular_units_1st_sem_without_evaluations", 
                  "curricular_units_2nd_sem_credited", "curricular_units_2nd_sem_enrolled", 
                  "curricular_units_2nd_sem_evaluations", "curricular_units_2nd_sem_approved", 
                  "curricular_units_2nd_sem_grade", "curricular_units_2nd_sem_without_evaluations", 
                  "unemployment_rate", "inflation_rate", "gdp")
data[numeric_vars] <- lapply(data[numeric_vars], as.numeric)
print("Numeric variables converted.")

##impute missing values
#impute numeric columns with mean
data <- data %>%
  mutate(across(all_of(numeric_vars), ~ ifelse(is.na(.), mean(., na.rm = TRUE), .)))

#impute categorical columns with mode (most frequent value)
mode_function <- function(x) {
  unique_x <- unique(x[!is.na(x)])
  unique_x[which.max(tabulate(match(x, unique_x)))]
}

data <- data %>%
  mutate(across(all_of(categorical_vars), ~ ifelse(is.na(.), mode_function(.), .)))

print("Missing values imputed.")

#removing special characters from text columns
data <- data %>% mutate(across(where(is.character), ~gsub("[^A-Za-z0-9 ]", "", .)))
print("Special characters removed from text columns.")

#handling outliers using IQR Method
for (var in numeric_vars) {
  Q1 <- quantile(data[[var]], 0.25, na.rm = TRUE)
  Q3 <- quantile(data[[var]], 0.75, na.rm = TRUE)
  IQR <- Q3 - Q1
  lower_bound <- Q1 - 1.5 * IQR
  upper_bound <- Q3 + 1.5 * IQR
  data <- data %>% mutate(!!var := ifelse((.data[[var]] < lower_bound | .data[[var]] > upper_bound), NA, .data[[var]]))
}
print("Outliers handled using IQR method.")

#saving the cleaned dataset
write_csv(data, output_file)
print("Cleaned dataset saved successfully!")

#task completion
print("Data cleaning complete, woohoo!")
