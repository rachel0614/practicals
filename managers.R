# enter data into vectors before constructing a dataframe

date_col <- c("10/15/18","01/11/18","10/21/18","10/28/18","05/01/18")
country_col <-c("US","US","IRL","IRL","IRL")
gender_col <-c("M","F","F"," M","F")
age_col <-c(32,45,25,39,99)
q1_col <- c(5,3,3,3,2)
q2_col <- c(4,5,5,3,2)
q3_col <- c(5,2,5,4,1)
q4_col <- c(5,5,5,NA ,2)
q5_col <- c(5,5,5,NA ,1)
# create data frame using the above vectors
managers_data <- data.frame(date_col, 
                            country_col, 
                            gender_col, 
                            age_col,
                            q1_col, q2_col, 
                            q3_col, q4_col, 
                            q5_col)
managers_data
column_names <- c("date","country","gender","age",
                  "q1","q2","q3","q4","q5")
# add columns to the managers_data data frame
colnames(managers_data) <- column_names

# replace incorrect age value to NA
managers_data$age[managers_data$age == 99] <- NA

# 2 ways to create a new variable
# - create a new vector and store the logical check in it
# - create a new variable when doing the logical check
managers_data$age_cat[managers_data$age<=25] <- "Young"                   
managers_data$age_cat[managers_data$age>=26 & managers_data$age<=44] <- "Middle Aged"                   
managers_data$age_cat[managers_data$age>=45 | is.na(managers_data$age) ] <- "Elder"                   
managers_data
