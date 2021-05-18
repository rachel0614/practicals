managers_data <- read.csv("managers.csv", na="", stringsAsFactors = FALSE)
managers_data
dim(managers_data)
# 两位年
managers_data$Date1 <- as.Date(managers_data$Date, "%m/%d/%y")
attach(managers_data)
#??????????????????????
new_managers_data <- managers_data[Date1>as.Date("2018-10-15") & Date1 < as.Date('2018-11-01'), ]
detach(managers_data)
dim(new_managers_data)
dim(managers_data)
nrow(new_managers_data)
nrow(managers_data)
str(managers_data)
keep_columns <- names(new_managers_data)[!names(new_managers_data) %in% c("Q3","Q4")]
new_managers_data <- new_managers_data[keep_columns]
new_managers_data
dim(new_managers_data)
new_managers_data[c("Q1","Q4"),new_managers_data$Age>23 & new_managers_data$Age<35]
attach(managers_data)
subset(managers_data, Age>23 & Age<35, select = c("Q1","Q4") )
subset(managers_data, Gender=='M' & Age>25, select = c("Gender","Q4") )
detach(managers_data)
managers_data[sample(1:nrow(managers_data), 10, replace = TRUE), ]
managers_data

attach(managers_data)
managers_data[order(Gender, Age), ]
sorted_data <- managers_data[order(Gender, Age),]
detach(managers_data)

new_managers_data <- managers_data[order(managers_data$Gender, managers_data$Age), ]
dim(new_managers_data)
write.csv(new_managers_data, "test1.csv")
