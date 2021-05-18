# MTcars -predict car stopping distance from speed

# first step - check model assumptions
# for linear models:
# Linearity - linear relationship?
# Normality - residuals are normally distributed
# Homoscedasticity - residuals have a constant variance
# No collinearity - not linear combinations of each other
# Independence - residuals are independent and not correlated

# independent variable - x axix - speed
# dependent variable - y axix - stop distances
# Check linearity
attach(cars)
str(cars)
scatter.smooth(x = speed, 
               y = dist, 
               main = "Distance ~ Speed", 
               xlab = "Car speed (mph)",
               ylab = "stop instance (feet)")
# data points along the linear line
# there is a positive linear

# check correlation between the variables
cor(speed, dist)
# 0.8068949= high correlation

# check for outliers
# outliers = 1.5 * IQR
opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2)) # 1 row 2 cols
boxplot(speed, main = "Speed", 
        sub = paste("outlier rows: "), boxplot.stats(speed)$out)
boxplot(dist, main = "Distance", 
        sub = paste("outlier rows: "), boxplot.stats(dist)$out)
par <- opar

# remove 1 outlier where dist = 120
cars <- subset(cars, cars$dist != 120)
nrow(cars)

# check normality
install.packages("e1070")
library(e1070)

# skewness <-1 or >1 = highly skewed
# moderately skewed = -1 to -0.5 and 0.5 to 1
# highly skewed = <-1 or >1
# -0.5 to 0.5 = approx symetrical

opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2)) # 1 row 2 cols
plot(density(speed),
     main = "Density plot: Speed",
     ylab = "Frequency",
     sub = paste("skewness:") +
       round(e1071::skewness(speed), 2))

plot(density(dist),
     main = "Density plot: Distance",
     ylab = "Frequency",
     sub = paste("skewness:") +
       round(e1071::skewness(dist), 2))
# fill in the area under the plot with red
polygon(density(dist), col = "red", main = "Distance")

polygon(density(speed), col = "red", main = "Speed")

par <- opar 

# using qqnorm
opar <- par(no.readonly = TRUE)
par(mfrow = c(1, 2))
hist(dist)
qqline(dist)
par <- opar

# Create traianing and testing datasets
set.seed(1)
no_rows_data <- nrow(cars)
data_sample <- sample(1:no_rows_data, 
                      size = round(0.7 * no_rows_data),
                      replace = FALSE)
# 70%
training_data <- cars[data_sample,] 
# 30%
testing_data <- cars[-data_sample,]

linear_mod <- lm(dist ~ speed, data = training_data)
summary(linear_mod)

# variable p-value  3.22e-08
# model p-value 3.216e-08
# std / error = t value

# Prediction
predicted_distance <- predict(linear_mod, testing_data)
# 
actual_predictions <- data.frame(cbind(actuals = testing_data$dist,
                                     predicted = predicted_distance))
head(actual_predictions, 10)

correlation_accuracy <- cor(actual_predictions)
correlation_accuracy

