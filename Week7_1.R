# load and have a look on the distribution
# use statistical methods to examine the relationship 
# between our variables of interest

# beavers dataset
# contains the body temperature of 4 beavers captured every 10 minutes over a day
# we want to examine difference in average body temperature
# to evaluate whether body temperature is affected by activity
# Hypothesis test

?beavers
str(beaver2)
# activ - is measurement, is categorical dichotomous
# temp - beaver temperature is continuous
# we'll evaluate temp & activ
# Question 1
# h0 - mean beaver temperature is not affected by activity
# h1 - mean beaver temperature is affected by activity
# continuous & categorical dichotomous
beavers_data <- beaver2
# convert activ variable from numeric to factor type
#beavers_data$activ <- as.factor(beavers_data$activ)
beavers_data$activ <- 
  factor(beavers_data$activ, 
         order = FALSE
      ,labels = c("No", "Yes"))

str(beavers_data)

#install.packages("psych")
library(psych)
pairs.panels(beavers_data,
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
# If TRUE, adds confidence intervals  

# Question2
attach(beavers_data)
# 这里没看出来什么有价值的信息，能看到outliers
# 如果是两个都是continuous variables的话会看到
plot(activ, temp, pch=9,col='lightblue')

# we can split the dichotomous variable into 2
# and then examine the data
library("lattice")
# 
histogram(~temp | activ, data = beavers_data,
          main = "distribution of beaver activity data",
          xlab = "tempreture (degrees)",
          ylab = "Activity")

# visual analysis seems to indicate that the data
# is normally distributed (无法从这个图得到肯定答案)
# we look at the median of the data so we can see if it's normally distributed
# summarize the medium of the data
tapply(temp, activ, median)
# it seems to be the same median of both variables
# 上面的图无法准确表明是正态分布的
# 下面用分位数图visualize to see if it's normally distributed
# quantile-quantile plot (Q-Q plot) allows us 
# to check if the data is normally distributed or not
# is the tempreture normally distributed
qqnorm(temp)
# add line that represents normal distribution
qqline(temp, col = "red")
# from the above chart, if it's normally distributed, the data point will be along the red line
# so, temp appears not  to be normally distributed
attach(beavers_data)
# 在with里可以做好几件事  

with(beavers_data, 
     qqplot(temp[activ == 'Yes'],
            temp[activ == 'No'],
            main = "comparing 2 samples of activity data",
            xlab = "Active temp = Yes",
            ylab = "Active temp = No") )
str(beavers_data)
# 上图看起来两个variable呈线性关系
# we can add normality line to the plot
# to help to evaluate normality
with(beavers_data, { 
  qqnorm(temp[activ == 'No'], main = 'Inactive data')  
  qqline(temp[activ == 'No']) 
})
# Inactive 数据看起来基本正态分布
# it's generally normally distributed
with(beavers_data, { 
  qqnorm(temp[activ == 'Yes'], main = 'Inactive data')  
  qqline(temp[activ == 'Yes']) 
})
# formal test of normality
# shapiro-wilks test is a famous test for the test of normally distributed data
# but it's not suitable for categorical test!!!!!!
# p-value tells us the chances that the sample
# comes from a normal distribution, which means that 
# if p>0.05 = normality distributed
normality_test <- shapiro.test(beavers_data$temp)
normality_test$p.value
# p-value = 7.763623e-05
# 注意 this test does not work on a dichotomous variables!!!!!!
with(beavers_data, tapply(temp, activ, shapiro.test))
# Results show
# p-value of No = 0.1231 - normally distributed
# p-value of Yes = 0.5583 - normally distributed
# p-value of temp is not normally distributed
# 可以证明 因为不是正态分布的数据
# 在这个case中，continuous + categorical适合做nonparamatic test(看对照表)
# after consulting the chart, I'm examine
# a dependent variable temp
# with an independent categorical variable activ
#  format wilcox.test(dependent ~ independent) 
# we run Mann-Whitney test
wilcox.test(temp ~ activ)
# p-value is less than 0.05 so this indicates the Null hypothesis (H0)
# is rejected and therefore this indicates that beaver body temperature
# is affected by activity (p = 2.2e-16)
# 
