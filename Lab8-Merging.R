### Lab 8 - Merging and reshaping ###

rm(list=ls())

# sometimes we want to combine data
# three ways to do this: (1) stack on top of each other, (2) place side-by-side,
# or (3) merge together based on common variables.

# Stacking 

# Let's generate some fake data to illustrate combining data frames by stacking.

first <- data.frame(x0=1:5, x1=rnorm(5),x2=c("M","F","M","F","F"))
first

second <- data.frame(x0=10:14, x1=rnorm(5), x2=c("M","F","M","F","F"))
second

third <- data.frame(x4=c(3,3,1,3,2), x5=c("e","g","v","b","z"))
third

# We can use the rbind() function to stack data frames. Make sure the number of 
# columns match. Also, the names and classes of values being joined must match.
# Here we stack the first, the second and then the first again:
rbind(first, second, first)

class(rbind(first, second, first)) # still a data frame

# Use the cbind function to combine data frames side-by-side:
cbind(first,third)

class(cbind(first,third))

# note: cbind does not require matching heights; if one data frame is shorter
# it will recycle it. Notice below the third data frame is recycled.
cbind(rbind(first,second),third)

# However, if the number of rows of the shorter data frame does not evenly 
# divide into the number of rows of the taller data frame, then R throws an 
# error.

cbind(rbind(first,second),third[-1,])

# Merging

# Let's create some more fake data to illustrate:
left <- data.frame(id=c(2:7), y2=rnorm(6,100,5))
left

right <- data.frame(id=rep(1:4,each=2), z2=sample(letters,8, replace=TRUE))
right

# Data frames left and right have columns "id" in common. Let's merge them 
# together based on id:
merge(left, right)

# Notice y2 from the left data frame is recycled to match up with multiple id in
# the right data frame. Also notice only rows with matching ids in both data
# frames are retained. this is known as an INNER JOIN.
# Only those records with matching "by" variables are joined.

# If we wanted to merge all rows regardless of match, we use the argument
# all=TRUE. It is FALSE by default. This creates an OUTER JOIN.
merge(left, right, all=TRUE)

# If we want to retain everything in the left data frame and merge only what 
# matches in the right data frame, we specify all.x=TRUE. This is known as a
# LEFT JOIN.
merge(left, right, all.x=TRUE)

# If we want to retain everything in the right data frame and merge only what 
# matches in the left data frame, we specify all.y=TRUE. This is known as a
# RIGHT JOIN.
merge(left, right, all.y=TRUE)

# When merging two data frames that do not have matching column names, we can
# use the by.x and by.y arguments to specify columns to merge on.

# Let's say we want to merge the first and left data frames by x0 and id. The
# by.x and by.y arguments specify which columns to use for merging.

merge(first, left, by.x="x0", by.y="id")

#What if we don't specify columns to merge on?
merge(second, left)

# Reshaping Data 

# Examples:
wide <- data.frame(name=c("Clay","Garrett","Addison"), 
                   test1=c(78, 93, 90), 
                   test2=c(87, 91, 97),
                   test3=c(88, 99, 91))

long <- data.frame(name=rep(c("Clay","Garrett","Addison"),each=3),
                   test=rep(1:3, 3),
                   score=c(78, 87, 88, 93, 91, 99, 90, 97, 91))

# wide to long
install.packages("reshape2")
library(reshape2)

# The star function of the reshape2 package is melt(). It basically "melts" wide
# data into long format.
wide
melt(wide, id.vars = "name", measure.vars = c("test1","test2","test3"))
wide
# melt and change col names
melt(wide, id.vars = "name", measure.vars = c("test1","test2","test3"),
     variable.name = "test", value.name="score")

# long to wide
# The dcast() function can reshape a long data frame to wide.


