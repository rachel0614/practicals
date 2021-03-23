# file downloaded from BB and inserted into data frame
managers_data <- read.csv("managers.csv", na = "")

# view the structure of the data frame
str(managers_data)

# convert date from mm/dd/yy to 
converted_date <- as.Date(managers_data$Date, "%m/%d/%y")
converted_date
str(converted_date)

# replace the date field in the data frame
managers_data$Date <- converted_date
str(managers_data)

# convert age variable to int

managers_data$Age <- as.integer(managers_data$Age)
str(managers_data)

# select record between 2018-10-15 and 2018-11-01
start_date <- as.Date("2018-10-15")
end_date <- as.Date("2018-11-01")
# comma is very important
new_date <- managers_data[managers_data$Date >= start_date & 
                            managers_data$Date <= end_date,]
new_date

# show columns names
#names(managers_data)

# drop attributes from data
include_list <- names(managers_data) %in% c("Q3", "Q4")

# This data frame only contains Q3 and Q4
new_managers <- managers_data[(include_list)]

# all columns except Q3 and Q4 
#new_managers <- managers_data[!(include_list)]

new_managers
# use the subtract function to extract all records where age >35 and age < 24
# only select Q1-Q4
#managers_data[managers_data$Age <24 | managers_data$Age >35][c("Q1", "Q2", "Q3", "Q4")]
# omit this data frame's name when reference the column
attach(managers_data)
new_data <- subset(managers_data, Age > 35 | Age < 24, 
                   select = c("Q1", "Q2", "Q3", "Q4"))
new_data

gender_data <- subset(managers_data, Gender == "M" & Age > 2, 
                   select = Gender:Q4)
gender_data
detach(managers_data)
