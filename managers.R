# Enter data into vectors before constructing the data frame
date_col <- c("10/15/18", "01/11/18", "10/21/18", "10/28/18", "05/01/18")
country_col <- c("US", "US", "IRL", "IRL", "IRL")
gender_col <- c("M", "F", "F", "M", "F")
age_col <- c(32, 45, 25, 39, 99)
q1_col <- c(5, 3, 3, 3, 2)
q2_col <- c(4, 5, 5, 3, 2)
q3_col <- c(5, 2, 5, 4, 1)
q4_col <- c(5, 5, 5, NA, 2) # NA is inserted in place of the missing data for this attribute
q5_col <- c(5, 5, 2, NA, 1)

# Construct a data frame using the data from all the vectors
managers_data <- data.frame(date_col, 
                            country_col, 
                            gender_col, 
                            age_col, 
                            q1_col, 
                            q2_col, 
                            q3_col, 
                            q4_col, 
                            q5_col)

managers_data

column_names <- c("Date", 
                  "Country", 
                  "Gender", 
                  "Age", 
                  "Q1", 
                  "Q2", 
                  "Q3", 
                  "Q4", 
                  "Q5")

# Add column names to the managers_data dataframe
colnames(managers_data) <- column_names

managers_data

# Recode the incorrect 'age' to NA
managers_data$Age[managers_data$Age == 99] <- NA
managers_data

# 2 options to create a new variable
# 1 - create a new vector and store the logical check in it
# 2 - create the new var when doing the logical check

managers_data$AgeCat[managers_data$Age >= 45] <- "Elder"
managers_data$AgeCat[managers_data$Age >= 26 & managers_data$Age <= 44] <- "Middle Aged"
managers_data$AgeCat[managers_data$Age <= 25] <- "Young"
managers_data$AgeCat[is.na(managers_data$Age)] <- "Elder"
managers_data

# recode age_cat so that it is ordinal and factored
# with the order young, middle aged, elder
age_cat <- factor(managers_data$AgeCat, order = TRUE, levels = c("Young", "Middle Aged", "Elder"))
age_cat

# replace mnager_data age_cat variable with
# the factored variable

managers_data$AgeCat <-age_cat
managers_data

# Look at the structure of the data frame
str(managers_data)

# create a summary column of each row
summary_col <- managers_data$Q1 + managers_data$Q2 + 
  managers_data$Q3 + managers_data$Q4 +
  managers_data$Q5
summary_col

# append summary_col to managers dataframe

managers_data <- data.frame(managers_data, summary_col)
managers_data

# calculate mean value for each row

mean_col <- rowMeans(managers_data[5:9])
mean_col
managers_data <- data.frame(managers_data, mean_col)
managers_data

# change titles of the new added columns to make it more readable
names(managers_data)[11] <- "Summary"
names(managers_data)[12] <- "Mean value"

# show structure of the data frame
str(managers_data)

# convert Date column from char to date
converted_date <- as.Date(managers_data$Date, "%m/%d/%y")
managers_data$Date = converted_date
managers_data

# dealing with na data
new_managers_data <- na.omit(managers_data)
new_managers_data

# use complete.cases to check the integrity of the columns
complete_managers_data <- complete.cases(managers_data)
complete_managers_data

# list rows that do not have missing values
complete_managers_data <- managers_data[complete.cases(managers_data),]
complete_managers_data
# show rows that have missing values
complete_managers_data <- managers_data[!complete.cases(managers_data),]
complete_managers_data
# show summary of all missing in a variable
sum(is.na(managers_data$Age))
sum(is.na(managers_data$`Mean value`))

# for showing missing value
install.packages("mice")
library(mice)       
# visualization
md.pattern(managers_data)

# vim package can also show missing values
install.packages("VIM")
library(VIM)
missing_values <- aggr(managers_data, 
                       prop = FALSE,
                       numbers = TRUE)
# typeof(missing_values)
# show summary of the content of missing values
summary(missing_values)
# summary(managers_data)
