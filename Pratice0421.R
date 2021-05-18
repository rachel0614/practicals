# read 
df <- read.csv("managers.csv", na = "", stringsAsFactors = FALSE)
dim(df)
names(df)
# Create data
data <- data.frame(
  name=c("A","B","C","D","E") ,  
  value1=c(3,12,5,18,45),
  value2=c(13,122,25,118,445),
  status=c("on","off","on","on","on")
)
data
old_par <- par(no.readonly = TRUE)
# Calculate range from 0 to max value of cars and trucks
g_range <- range(0, data$value1, data$value2)
png(filename="tmp1.png", 
    height=600, width=600, 
    bg="white")
plot(data$value1, main = "title",
     type = "o", col = "red", 
     font.main = 2, ylim =g_range,
     axes = FALSE, ann = FALSE)

lines(data$value2, type = "o", pch = 22, lty = 2, col = "blue")
# 横纵轴显示及步长设置
axis(1, at=1*1:5, lab=c("Mon","Tue","Wed","Thu","Fri"))
axis(2, las=1, at=100*0:g_range[2])

# box
box()
# Label the x and y axes with dark green text
title(xlab="Days", col.lab=rgb(0,0.5,0))
title(ylab="Total", col.lab=rgb(0,0.5,0))

legend(1, g_range[2], c("value1","value2"), cex=0.9, 
       col=c("blue","red"), pch=21:22, lty=1:2)
dev.off()

# observations = rows
df[df$Country=='US', ]
with(df, data.frame(Country, Gender))
df

# Start PNG device driver to save output to figure.png

