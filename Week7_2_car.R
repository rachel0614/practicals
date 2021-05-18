?mtcars
mtcars_data <- mtcars
str(mtcars_data)
# question1 - We would like to examine '
# whether there is a link between the weight of cars and
# their fuel efficiency as measured by MPG.
# H0 - the mean value of weight does not affect fuel efficiency 
# H1 - the mean value of weight affects fuel efficiency 
head(mtcars_data,2)

#检查完整性
# incomplete_data <- 


# mpg - continuous variable 
# wt - continuous variable
library(psych)

# question2
# the variables you are using for the hypothesis test are normally
# distributed or not.
# Do this visually and using a relevant statistical analysis test.
# Then decide on which statistical test you will use.
attach(mtcars_data)

plot(wt, mpg, 
     pch=19, 
     col='lightblue', 
     main = 'caparion', 
     xlab = 'weight', 
     ylab = 'mpg')
#tapply(mpg, wt, median)
# if mpg is normally distribtued
qqnorm(mpg)
qqline(mpg, col = "red")

qqnorm(wt)
qqline(wt, col = "red")

# if p>0.05 = normality distributed
normality_test_wt <- shapiro.test(wt)
normality_test_wt$p.value
# p-value of weight (wt) is normally distributed

normality_test_mpg <- shapiro.test(mpg)
normality_test_mpg$p.value
# p-value of fuel efficiency (mpg) is normally distributed

# for relationship between 2 continuous variables
# if independent - Pearson’s Correlation Co-efficient 
pairs.panels(mtcars_data,
             smooth = TRUE,# If TRUE, draws loess smooths    
             scale = FALSE, # If TRUE, scales the correlation text font    
             density = TRUE, # If TRUE, adds density plots and histograms    
             ellipses = TRUE, # If TRUE, draws ellipses    
             method = "spearman", # Correlation method (also "pearson" or "kendall")    
             pch = 21, # pch symbol    
             lm = FALSE, # If TRUE, plots linear fit rather than the LOESS (smoothed) fit    
             cor = TRUE, # If TRUE, reports correlations    
             jiggle = FALSE, # If TRUE, data points are jittered    
             factor = 2, # Jittering factor    
             hist.col = 4, # Histograms color  # stars = TRUE, # If TRUE, adds significance level with stars    
             stars = TRUE, 
             ci = TRUE) 
# question3
# Examine the results of the statistical test
# decide on whether there is a statistical
# correlation between car weight and mpg.
# Present your findings.

# 
histogram(~wt | mpg,
          data = cars,
          main = "Distributation of fuel efficiency wrt weight",
          xlab = "Weight of cars (1000 lbs)" ,
          ylab = "fuel efficiency")

with(mtcars_data, qqplot(wt,mpg,xlab="weight",ylab="mpg"),
     qqline(wt))

hist(mtcars_data$weight)
hist(mtcars_data$mpg)
