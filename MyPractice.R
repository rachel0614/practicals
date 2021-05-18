# generate a matrix values from x:y with 5 rows and 6 columns
m1 <- matrix(C<-(2:2),nrow=5, ncol=6)
m1
# 列汇总
a_m1 <- apply(m1, 2, sum)
a_m1
# 行汇总
b_m1 <- apply(m1, 1, sum)
b_m1
m2 <- matrix(c("A", "B"), nrow = 3, ncol = 4)
m2[1:2,1:2]


movies <- c("SPYDERMAN","BATMAN","VERTIGO","CHINATOWN")
movies_lower <-lapply(movies, tolower)
str(movies_lower)
# convert list to vector
movies_lower <- unlist(lapply(movies,tolower))
str(movies_lower)
class(movies_lower)

data <- cars
lmn_cars <- lapply(data, min)
lmn_cars
smn_cars <- sapply(data, min)
smn_cars
# 平均函数
avg <- function(x) {  
  ( min(x) + max(x) ) / 2
  }
fcars <- sapply(data, avg)
fcars

below_ave <- function(x) {  
  ave <- mean(x) 
  print(x > ave)
  # 只筛出大于平均值的
  return(x[x > ave])
}
dt_s<- sapply(data, below_ave)
dt_l<- lapply(data, below_ave)
dt_s
dt_l
identical(dt_s, dt_l)
# iris数据集，compute the median of the length for each species
data(iris)
str(iris)
# 相当于分组汇总
tapply(iris$Sepal.Width, iris$Species, median)
#
m1 = matrix(c("a","b","c"), nrow = 4, ncol = 3)
df1 <- as.data.frame(m1)
df1
names(df1) <- c("col1", "col2", "col3")
df1
cols <- names(df1) %in% c("col1","col2")
new_df1 <- df1[(cols)]
new_df1

# subset rows that col1 equals 'a' or 'b'
attach(new_df1)
head(new_df1,2)
subset(new_df1, col1=='a' | col1 == 'b', select = c(col1, col2))
detach(new_df1)
# random sample
nrow(new_df1)
ncol(new_df1)
tail(df1,2)
df1

new_df1[sample(1:nrow(new_df1), 200, replace = FALSE), ]
new_df1[sample(1:nrow(new_df1), 200, replace = TRUE), ]

# merge
m1 = matrix(c("a","b","c"), nrow = 4, ncol = 3)
m2 = matrix(c("c","b","a"), nrow = 4, ncol = 3)
df1 <- as.data.frame(m1)
df2 <- as.data.frame(m2)
df1
df2
df1$V1 <- as.character(df1$V1)
df1$V2 <- as.character(df1$V2)
df1$V3 <- as.character(df1$V3)
str(df1)
merge(df1, df2, by = "V1")
cbind(df1, df2)
rbind(df1,df2)
