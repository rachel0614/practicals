# this is a test
diabetes_data <- read.csv("Diabetes-md.csv", 
                          na = "", stringsAsFactors=FALSE)
# what's the data type
class(diabetes_data)
class(diabetes_data$Age)
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
md.pattern(diabetes_data )

# We can remove all missing data with this code.
# Removes any rows that contains NA - listwise deletion
new_diabetes_data <- na.omit(diabetes_data)
new_diabetes_data
# keep only data with missing type and status
keep_this_data <- diabetes_data[!complete.cases(diabetes_data$Daibetes.type, 
                                          diabetes_data$status), ]

keep_this_data
dim(keep_this_data)
diabetes_data <- keep_this_data
head(diabetes_data, 3)
# column names
column_names <- c("Patient Name","NI Address","Type","Age",
                  "Health Status")
colnames(diabetes_data) <- column_names
# 
diabetes_data$Type <- factor(diabetes_data$Type, order = FALSE, levels = c("Type 1","Type2"))
diabetes_data$`Health Status` <- factor(diabetes_data$`Health Status`, 
                                        order = FALSE, levels = c("Poor","Improved", "Excellent"))

# class list
class_list <- lapply(diabetes_data, class)
length(class_list)
class_list <- sapply(diabetes_data, class)
class(class_list)
length(class_list)
#####################chart#######################
dose <- c(20, 30, 40, 50, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
drugs <- data.frame(dose, drugA, drugB)
str(drugs)
class(drugs)
sapply(drugs, class)
# plot
# correlation
plot(drugs)
attach(drugs)
plot(dose, type = "o", col = "blue")
plot(dose, drugA, type = "b")
detach(drugs)

# par - chart settings
# par means parameters
# store default par before changing them
old_par <- par(no.readonly = TRUE)
# lty - line type 
# lwd - line width
# lty - 2 dash line
# pch - 17 solid triangle
par(lty = 2, pch = 17)
plot(dose, drugA, type = "b")
par = old_par
plot(dose, drugA, type = "b", lty = 2, pch = 17)
graph_range <- range(0, drugA, drugB)
graph_range
plot(drugA, type = "o", col = "blue", 
     ylim = graph_range, axes = FALSE,
     ann = FALSE)
lines(drugB, type = "o", pch = 22, lty = 2, col = "red")

# make the axis labels
axis(1, at = 1:5, 
     label = c("20 ml","40 ml","60 ml","80 ml","100 ml"))
# make the y axis that displays ticks 
axis(2, las = 1, at = 5 * 0:graph_range[2])

