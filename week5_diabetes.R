diabetes_data <- read.csv("dataset/diabetes.csv", 
                          na = "", stringsAsFactors=FALSE)
# check missing and delete
#install.packages("VIM")
library(VIM)
missing_values <- aggr(diabetes_data, prop = FALSE, numbers = TRUE)
# Show summary of the contents of missing_values
summary(missing_values)
# We can remove all missing data with this code.
# Removes any rows that contains NA - listwise deletion
new_diabetes_data <- na.omit(diabetes_data)
new_diabetes_data
str(new_diabetes_data)
convert_date <- paste('01',
  new_diabetes_data$Month,new_diabetes_data$Year,sep='/')
# 
new_diabetes_data$Date <- as.Date(convert_date,"%d/%m/%Y")
new_diabetes_data$Status <- as.factor(new_diabetes_data$Status)
str(new_diabetes_data)
# group summary
summary(new_diabetes_data$Status)
# settings
display_settings <- par(no.readonly = TRUE)
# add titles and relevant numbers to the chart
plot(new_diabetes_data$Status, main='patients by recovery status',
     xlab = 'status',
     ylab = 'number of people')
# save the modified dataframe to new csv file
write.csv(new_diabetes_data, 
          file = 'dataset/new_diabetes_data.csv')
