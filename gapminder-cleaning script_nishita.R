#-------------------------------------------------
# Data Cleaning Sample Script for Gapminder Dataset
# Author: Nishita Singh
# Date: 2025-02-25
# Purpose: Cleaning and preprocessing the Gapminder dataset for BCI Application, UMich
#-------------------------------------------------

#install & load required packages
required_packages <- c("tidyverse", "gapminder")

#install missing packages
missing_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]
if (length(missing_packages)) install.packages(missing_packages)

#load libraries
library(tidyverse)
library(gapminder)

#load the dataset
data <- gapminder  #Load dataset
print("Dataset loaded successfully!")

#check for missing values
missing_values <- sum(is.na(data))  # Total missing values
print(paste("Total missing values:", missing_values))

#If missing values exist, show column-wise summary
if (missing_values > 0) {
  print("🔍 Missing values per column:")
  print(colSums(is.na(data)))
}

#note:gapminder typically has no missing values, so no imputation is needed. 
#however the code for missing values has still been added for demonstration purposes.

#standardize column names
colnames(data) <- tolower(colnames(data))  # Convert column names to lowercase
print("Column names standardized.")

#correct data format 
data <- data %>%
  mutate(year = as.integer(year),  #Ensuring 'year' is integer
         country = as.factor(country),  #Converting any categorical variables to factors
         continent = as.factor(continent))

print("data types checked and converted where necessary.")

#remove duplicate rows
duplicates <- data[duplicated(data), ]
print(paste("Number of duplicate rows found:", nrow(duplicates)))

#remove duplicates if any exist
data <- data %>% distinct()
print("duplicate rows removed.")

#check for special characters 
data$country <- str_replace_all(data$country, "[^[:alnum:][:space:]]", "")

#handle outliers in GDP per capita 
if (!"gdppercap" %in% colnames(data)) stop("Error: Column 'gdppercap' not found!")

#check distribution of gdppercap
summary(data$gdppercap)

#plot GDP per capita distribution (for quick visualisation)
ggplot(data, aes(x = gdppercap)) +
  geom_histogram(bins = 30, fill = "steelblue", alpha = 0.7) +
  labs(title = "Distribution of GDP per Capita", x = "GDP per Capita", y = "Frequency")

#define the 99th percentile threshold for outliers
threshold <- quantile(data$gdppercap, 0.99)

#remove extreme outliers
data <- data %>% filter(gdppercap <= threshold)

print("extreme outliers removed from GDP per capita.")

#saving the cleaned dataset
write.csv(data, "cleaned_gapminder.csv", row.names = FALSE)
print("cleaned dataset saved as 'cleaned_gapminder.csv'.")

#data cleaning completion confirmation
print("Data cleaning complete, woohooo!")
