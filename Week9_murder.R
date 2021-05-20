# Multiple Regression
# http://www.simonqueenborough.info/R/statistics/multiple-regression
data(state)
states <- as.data.frame(state.x77)
class(states)
str(states)

# convert columns names 
# Life exp and HS grad 
# variables to Life_exp and HS_grade
colnames(murders_data)[4] <- "Life_exp"
colnames(murders_data)[6] <- "HS_grade"
str(murders_data)

# check linearity
pairs(murders_data)
# plot(murders_data)

# calculate density
murders_data$Density <- murders_data$Population * 1000 / murders_data$Area    

cor(murders_data)

m.full <- lm(Life_exp ~ 
               Population + Income + 
               Illiteracy + Murder + 
               HS_grade + Frost + 
               Area + Density, 
             data = murders_data)
summary(m.full)
m0 <- lm(Life_exp ~ Population, data = murders_data)
summary(m0)

res <- as.data.frame(summary(m.full)$coef[-1, ])
names(res) <- c('Estimate', 'Std.Error', 't.value', 'P')
plot(res$Estimate)

# ensure that y-margins are large enough for labels
par(mar = c(4,7, 2, 2), lwd = 2)

# plot data in order
plot(1:8 ~ res$Estimate, 
     xlim = c(-0.5, 0.5), xlab = 'Estimate',
     yaxt = 'n', ylab = '')

# add zero line
abline(v = 0, lty = 3, col = 'grey')


# add axis to side 2
axis(side = 2, at = 1:8, labels = rownames(res), las = 1)

# Then we can add the error bars, using ```segments()``` as before.
# standard error
segments(x0 = res$Estimate - res$Std.Error, x1 = res$Estimate + res$Std.Error,
         y0 = 1:8, y1 = 1:8)


# Finally, we can color each point depending on whether is has a significant p-value.
COL <- c('white', 'black')
points(x = res$Estimate, y = 1:8, pch = 21, cex = 2,
       bg = COL[(res$P < 0.05)+1])
# Now we can easily see which variables are significant and how they compare.

# -----------------------------
# Multiple Linear regression (MLR)
