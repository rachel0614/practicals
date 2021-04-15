# merging dataset
# load data
managers_data <- read.csv("managers.csv", 
                          stringsAsFactors=FALSE)
new_managers_data <- read.csv("MoreData.csv", na = "", stringsAsFactors=FALSE)
new_managers_data
# show structure
str(new_managers_data)
# show headers
names(managers_data)
names(new_managers_data)

include_list <- new_managers_data[c("Date", "Country", "Gender", 
                                    "Age", "Q1", "Q2", "Q3",
                                    "Q4", "Q5")]
include_list
# combine two dataframe
# but it doesn't work because their columns don't match
rbind(managers_data, include_list)
# create a new variable and calculate containing values
attach(include_list)
include_list$AgeCat[Age >= 45] <- "Elder"
include_list$AgeCat[Age >= 26 & Age <= 44] <- "Middle Aged"
include_list$AgeCat[Age <= 25] <- "Young"

# if NA is found, categorise as "Elder"
include_list$AgeCat[is.na(Age)] <- "Elder"
detach

names(managers_data)
modified_managers <- managers_data[2:11]
modified_managers
str(modified_managers)

# update the date fields on  both data frames 
# so that they're in the correct format
modified_managers$Date <- as.Date(modified_managers$Date, "%d/%m/%y")
include_list$Date <- as.Date(include_list$Date, "%m/%d/%Y")
# combine both data frames
combined_managers <- rbind(modified_managers, include_list)

# set AgeCat with ordered factor
# so that young < middle aged < elder

combined_managers$AgeCat <- factor(combined_managers$AgeCat, 
                                   levels = c("Young",  "Middle Aged", "Elder"),
                                   ordered = TRUE)
str(combined_managers)
