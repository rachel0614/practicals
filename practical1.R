# First step
# Assign number 2 to variable x
x <- 2
# same as x = 2
y <- 5
y
# remove y from memory
rm(y)
# check data type of variable 1
class(x)
# check data type of variable 2
is.numeric(x)
a <- -4
class(a)
# integer type ends up with L
a <-4L
class(a)
b <- 2.8
class(b)
c <- a*b
class(4L)
x <- "a"
# factor
y <- factor("data")
y
# check the length of a string
nchar("https://github.com/rachel0614/practicals")

# date type
date1 <- as.Date("2021-03-12")
date1
class(date1)
# days since 1970-01-01
as.numeric(date1)

# vectors
p <- c(3,5,6,8)
q <- c(3, 1)
p+q

# vector arithmetic
# create a vector contain all of 
# x, 0, all of x
# y <-x, 0, x
x <- c(10.4, 5.6, 3.1, 6.4, 21.7)
y <- c(x,0,x)

z <- 2*x + y + 1
min(z)
max(z)
range(z)
mean_of_z <- mean(z)
mean_of_z
# sort array
sorted_z <- sort(z)
sorted_z

seq3 <- seq(-100, 100, by=0.6)
seq3
sort(seq3, decreasing = TRUE)

# practical demo
vec1 <- c('Hockey','Football','Baseball','Curling', 
          'Rugby','Hurling','Basketball','Tennis',
          'Cricket','Lacrosse')
vec2 <- c(vec1,'Hockey','Lacrosse','Hockey','Water Polo',
          'Hockey','Lacrosse')
vec2
vec2_factor = as.factor(vec2)
vec2_factor
# add 1,3,6 element of vec2 to vec3
vec3 <- vec2[c(1,3,6)]
vec3

