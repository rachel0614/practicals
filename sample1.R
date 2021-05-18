install.packages(truncnorm)
library(truncnorm)
mydata <- rnorm(n=1000, mean = 90, sd = 4)
par(mfrow=c(1,1))
hist(mydata)
truncate_data <- rtruncnorm(n = 1000, a = 85, b = 100, mean = 90, sd = 4)
par(mfrow=c(1,2))
hist(mydata)
hist(truncate_data)


library(sm)
attach(mtcars)

# Compare MPG distributions for cars with
# 4,6, or 8 cylinders

attach(mtcars)

# create value labels
cyl.f <- factor(cyl, levels= c(4,6,8),
                labels = c("4 cylinder", "6 cylinder", "8 cylinder"))

# plot densities
sm.density.compare(mpg, cyl, xlab="Miles Per Gallon")
title(main="MPG Distribution by Car Cylinders")

# add legend via mouse click
colfill<-c(2:(2+length(levels(cyl.f))))
legend(locator(1), levels(cyl.f), fill=colfill)