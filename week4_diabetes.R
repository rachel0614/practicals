# this is a test
diabetes_data <- read.csv("Diabetes-md.csv", 
                          na = "", stringsAsFactors=FALSE)
# what's the data type
class(diabetes_data)
# what's the structure
str(diabetes_data)
# what's the dimension
dim(diabetes_data)
#row(diabetes_data)

#install.packages("VIM")
library(VIM)
missing_values <- aggr(diabetes_data, prop = FALSE, numbers = TRUE)
# Show summary of the contents of missing_values
summary(missing_values)


# -------------------------------------------------------------------------------
# Dealing with missing data 
# -------------------------------------------------------------------------------

# There are several methods we can use to extract out 
# missing data before we decide whether to delete it

# We can remove all missing data with this code.
# Removes any rows that contains NA - listwise deletion
new_diabetes_data <- na.omit(diabetes_data)
new_diabetes_data

# We can use complete.cases to show rows where data is available
# Here's an example of how to do this
complete_diabetes_data <- complete.cases(diabetes_data)
complete_diabetes_data
# Show sum of missing rows
sum(complete_diabetes_data)
# missing details
diabetes_data[!complete.cases(diabetes_data), ]

# install mice
# install.packages("mice)
library("mice")
md.pattern(diabetes_data)

