?mtcars
mtcars_data <- mtcars
str(mtcars_data)
# question1 - We would like to examine '
# whether there is a link between the weight of cars and
# their fuel efficiency as measured by MPG.
# H0 - the mean value of weight does not affect fuel efficiency 
# H1 - the mean value of weight affects fuel efficiency 
head(mtcars_data,2)
# whether there is a link between the weight of cars and 
# their fuel efficiency as measured by MPG. 
# H0 - car weight has no effect on fuel efficiency
# H1 - car weight has an effect on fuel efficiency 
attach(mtcars_data)
str(mtcars_data)
table(mpg, wt)
library(FSA)
library("lattice")
plot(wt, mpg, pch=9,col='lightblue', 
     main = "mpg vs weight")
# it looks a negative correlation between them
str(mtcars_data)
library(VIM) 
missing_values <- aggr(mtcars_data, prop = FALSE, numbers = TRUE)
summary(missing_values)
# check missing values
incomplete_data <- mtcars_data[!complete.cases(mtcars_data), ]
incomplete_data
str(mtcars_data)
# check if the dependent variable is normally distributed
# qqnorm qqline
qqnorm(mpg)
qqline(mpg, col = "red")
# if p>0.05 = normality distributed
normality_test_wt <- shapiro.test(wt)
normality_test_wt$p.value
# wt is normally distribtued
normality_test_mpg <- shapiro.test(mpg)
normality_test_mpg$p.value
# mpg is normally distribtued
# 
library(psych)
pairs.panels(subset(mtcars_data, select = c(wt, mpg)), 
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

# check linearity
attact(mtcars_data)
plot(wt, mpg, pch = "19", col = "lightblue", 
     xlab = "weight", 
     ylab = "efficiency",
     main = "comparison of car wright and efficiency")

# check if the dependent variable is normally distributed
# qqnorm qqline
qqnorm(mpg)
qqline(mpg, col = "red")

qqnorm(wt)
qqline(wt, col = "red")

with(mtcars_data,
     qqnorm(mpg,
            main = "normal of mpg",
            xlab = "",
            ylab = ""),
     qqline(mpg, col = "red")
)
with(mtcars_data,
     qqnorm(wt,
            main = "normal of wt",
            xlab = "",
            ylab = ""),
     qqline(wt, col = "red")
)
# examine the correlation between both variables
with(mtcars_data,
     qqplot(wt, mpg, main = "comparing weight and mpg", 
     xlab = "weight",
     ylab = "mpg"))

# 
# if p>0.05 = normality distributed
normality_test <- shapiro.test(mtcars_data$mpg)
normality_test$p.value
# mpg is nor normally distributed

normality_test <- shapiro.test(mtcars_data$wt)
normality_test$p.value
# weight is not normally distributed


cor(mtcars_data,method="pearson")
print(corr.test(mtcars_data,method = "pearson"),short = FALSE)

#################
# H0 - no correlation
# h1 - correlation
plot(wt, mpg, pch = "19", col = "lightblue", 
     xlab = "weight", 
     ylab = "efficiency",
     main = "comparison of car wright and efficiency")

# visualize the normality of the variabels
opar = par(no.readonly = TRUE)
par(mfrow = c(1,2))
hist(wt, col="red", main = "distribution of car weight")
hist(mpg, col="red", main = "distribution of car weight")

# create a normal QQ-plot of weight and mpg values
# and we can add the normality line
qqnorm(mpg)
qqline(mpg, col = "red")

# both variables are normally distributed
# both continuous 
# dependent variable = mpg
# independent variable = wt
cor.test(wt, mpg, method = "pearson")
# this above test correlation = -0.8676594
# p-value = 1.294e-10
# therefore we reject null and accept alternative 


cor(bmi, age, method = c("pearson", "kendall", "spearman"))
cor.test(bmi, age, method=c("pearson", "kendall", "spearman"))

cor.test(mtcars$mpg, mtcars$hp,
         method = "spearman")
