# 1. load dataset
brexit_data <- read.csv("dataset/data_brexit_referendum.csv", 
                          na = "", stringsAsFactors=FALSE)
# 2. check structure
str(brexit_data)
class(brexit_data)
head(brexit_data,2)
# 3. count rows
leave_count <- nrow(brexit_data[brexit_data$Leave == -1, ])
leave_count <- sum(brexit_data$Leave[brexit_data$Leave == -1])
leave_count <- sum(brexit_data$Leave == -1)

leave_count
brexit_data$Leave[brexit_data$Leave == -1] <- NA
# 4. count leave variable is -1 and replace it with NA
# and recheck NA count
leave_count <- sum(brexit_data$Leave == -1)
leave_count
nrow(brexit_data[brexit_data$Leave == NA,])
sum(is.na(brexit_data$Leave))
sum(!complete.cases(brexit_data))

nrow(brexit_data[!complete.cases(brexit_data),])
sum(is.na(brexit_data$Leave)) 
# 5.
#install.packages("mice")
library(mice)
md.pattern(brexit_data)
# vim - missing values
library(VIM)
missing_values <- aggr(brexit_data, prop = FALSE, numbers = TRUE)
summary(missing_values)

# create a variable proportion
proportion_col <- brexit_data$Leave / brexit_data$NVotes
brexit_data$proportion <- proportion_col

# Proportion variable is less than or equal to 0.5 then we will 
# assume that voters decided to remain 
brexit_data$Vote[brexit_data$proportion <= 0.5] <- "Remain"
brexit_data$Vote[brexit_data$proportion > 0.5] <- "Leave"
brexit_data$Vote

# 8.
region_data <- data.frame(
  RegionName=c("London",
               "North West",
               "North East",
               "South West",
               "South East",
               "East Midlands",
               "West Midlands",
               "East of England",
               "Yorkshire and the Humber") ,  
  short_name=c("L",
               "NW",
               "NE",
               "SW",
               "SE",
               "EM",
               "WM",
               "EE",
               "Y")
)
region_data
# merge 
brexit_data_modified <- merge(x = brexit_data, y = region_data
      , by = "RegionName"
      , all.x = TRUE)
brexit_data_modified
brexit_data_modified$RegionName <- brexit_data_modified$short_name
drop_col <- c("short_name")
brexit_data_modified = 
  brexit_data_modified[,!(names(brexit_data_modified) %in% drop_col)]
# data summary
# show min, max... info of each column
summary(brexit_data_modified)
str(brexit_data_modified)
names(brexit_data_modified)

is.numeric(brexit_data_modified$proportion)
is.factor(brexit_data_modified$RegionName)
summary(brexit_data_modified)
#
numeric_list <- sapply(brexit_data_modified, is.numeric)
numeric_list
class(numeric_list)
# subset
numeric_data <- brexit_data_modified[numeric_list]
head(numeric_data, 3)

# 
lapply(numeric_data, summary)

names(brexit_data_modified)
