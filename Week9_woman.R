# user dataset called woman contains height & weight data 
# for 15 women between 30 ~39
# dependent variable = weight - after knowing input, we can guess
# independent = height - input 
# if we know a person's height, we're gonna try to 
attach(women)
simple_linear_model <- lm(weight ~ height, data = women)
simple_linear_model
plot(height, weight, 
     main = "scatter plot showing regresion line for weight predicted from height",
     xaxix = "height (inches)",
     ylab = "weight (lbs)")
# whether this model has any type of __ fit with the correlation between 2 vars
abline(simple_linear_model)
summary(simple_linear_model)
# result analysis
# Residuals - distribution of the data 
# median should not be far away from zero
# max values should be roughly five
# coefficient - regression ..statistical significance
# signif code