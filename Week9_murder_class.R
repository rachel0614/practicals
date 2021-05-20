# Multiple Linear regression (MLR)
# check model assumptions
# Linearity - there is a linear relation among the vars
# Normality - residuals are normally distributed
# Homoscedasticity - residuals have constant variance
# No collinearity - variables are not linear combinations of each other
# Independence - residuals are independ or at least not correlated
help("state.x77")
head(state.x77, 4)
class(state.x77)

states <- as.data.frame(state.x77)
class(states)
str(states)
mice
# change column names
colnames(states)[colnames(states) == "Life Exp"] <- "Life_exp"
colnames(states)[colnames(states) == "HS Grad"] <- "HS_Grad"

# colnames(murders_data)[4] <- "Life_exp"
# colnames(murders_data)[6] <- "HS_grade"

# check for NA's
# using VIM or 
library(mice)
md.pattern(managers_data)

# check for linearity
# variables chosen that will be used for model
names(states)
# could remove a subset of the data first
# or choose the vars and then show them in the pair function
# if we have lots of variables
variables_of_interest <- c("Murder", 
                           "Population", 
                           "HS_Grad", 
                           "Illiteracy", 
                           "Income",
                           "Life_exp",
                           "Area",
                           "Frost")
pairs(states[variables_of_interest])
# or we use pairs.panel
# so far we don't know the nature of the data
library(psych)
# this is much better than pairs function
pairs.panels(states,
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
# red lines in the chart gives us the correlation

# murder is one of the variables
# the murder rate - independent variable - x axis
# independent var = x-axis
# dependent var = y-axis (depend on input)
attach(states)
scatter.smooth(x = Murder, 
               y = Population, 
               main = "Murder ~ Population",
               xlab = "Murder (per 100,1000)",
               ylab = "Population (estimate)")
# the line is very flat, it's not high correlation
# check correlation 下面这种文字描述写在文档里
# -0.2 < x < 0.2, low correlation
# --------------, medium correlation
cor(Murder, Population) 
# 在文档里按如下格式评价correlation
# the correlation test shows that the correlation between the murder and 
# Population variables = 0.3436428 indicating a medium correlation.

scatter.smooth(x = Murder, 
               y = Frost, 
               main = "Murder ~ Population",
               xlab = "Murder (per 100,1000)",
               ylab = "Frost (mean min temp below freezing)")
cor(Murder, Frost)

paste("correlation for murder and frost:", 
      cor(Murder, Frost))
## Kendall's tau doesn't change much:
# symnum(Rc <- cor(swM, method = "kendall", use = "complete"))
# symnum(Rp <- cor(swM, method = "kendall", use = "pairwise"))

# do the same with other variables

paste("correlation for murder and Income:", 
      cor(Murder, Income))
paste("correlation for murder and Illiteracy:", 
      cor(Murder, Illiteracy))
paste("correlation for murder and Life_exp:", 
      cor(Murder, Life_exp))
# HS_Grad has negative 
paste("correlation for murder and HS_Grad:", 
      cor(Murder, HS_Grad))
# area doesn't really matter much
paste("correlation for murder and Area:", 
      cor(Murder, Area))

# decided to remove area, and keep the rest

states <- subset(states, select = -c(Area))
head(states,3)

# check for outliers
opar <- par(no.readonly = TRUE)
# 4 rows 2 columns
par(mfrow = c(2, 4))
boxplot(Murder, main = "Murder", 
        sub = paste("Outlier rows:",
                    boxplot.stats(Murder)$out))

boxplot(Population, main = "Population", 
        sub = paste("Outlier rows:",
                    boxplot.stats(Population)$out))

boxplot(Income, main = "Income", 
        sub = paste("Outlier rows:",
                    boxplot.stats(Income)$out))

boxplot(Illiteracy, main = "Illiteracy", 
        sub = paste("Outlier rows:",
                    boxplot.stats(Illiteracy)$out))

boxplot(Life_exp, main = "Life expentancy", 
        sub = paste("Outlier rows:",
                    boxplot.stats(Life_exp)$out))

boxplot(Life_exp, main = "Life_exp", 
        sub = paste("Outlier rows:",
                    boxplot.stats(Life_exp)$out))

boxplot(HS_Grad, main = "HS_Grad", 
        sub = paste("Outlier rows:",
                    boxplot.stats(HS_Grad)$out))

boxplot(Frost, main = "Frost", 
        sub = paste("Outlier rows:",
                    boxplot.stats(Frost)$out))
# reset
par(opar)
# the boxplot shows population
# outlier in outcome
# influential observation?
# sometime outlier because of error of the data

# use boxplot .stats(0 function to extract the outliers)
outlier_values <- boxplot.stats(Population)$out
paste("Population outliers:", paste(outlier_values, collapse = ","))
out_ind <- which(states$Population %in% c(outlier_values))
states_modified <- states[-out_ind, ]

outlier_values <- boxplot.stats(Income)$out
paste("Income outliers:", paste(outlier_values, collapse = ","))


# remove outliers


# remove outliers, don't remove too much
# decide whether to delete a few more outliers and what this result in 
# check normality
library(e1071)
opar <- par(no.readonly = TRUE)
par(mfrow = c(3, 3))
plot(density(speed),
     main = "Population plot",
     ylab = "Frequency",
     sub = paste("skewness:") +
       round(e1071::skewness(speed), 2))
polygon(density(Frost), col = "red")
# 以上重复多列得到红色多个指标的分布图

# create a table of the values with a decision alongside 

# skewness of <-1 or >1 = highly skewed 
# -1 to -0.5  and 0.5 to 1 = moderately skewed
# Skewness of -0.5 to 0.5 = approx symetrical

# check normality using qqnorm function
# the distribution sames like it doesn't normally distributed
opar <- par(no.readonly = TRUE)
par(mfrow = c(1,2))
hist(Murder, main = "distribution proportion of Murder",
     xlab = "Murder rate")

qqnorm(Murder)
qqline(Murder)
par <- opar
# these are the independent variables 
mlr_model <- lm(Murder ~ Illiteracy + Population + HS_Grad + 
                  Income + Frost, data = states)

summary(mlr_model)
# so far the variables don't seem to be great
# this is the very first step

# try and evaluate these
# see population row
# Estimate value = 1% increase of Murder, the corresponding values 
# of the variable increase

# Pr 0.8,0.9  value 

# 首先看所有variables
# correlation
# 选择 variables subset
# boxplot check outliers & remove them
# check it again
# check normality skewness
# 挑选variable,下周再继续
# 先不要建模