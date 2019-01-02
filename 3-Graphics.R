# #######################################################################
#       File-Name:      2-Graphics.R
#       Version:        R 3.4.3
#       Date:           Sep 07, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Simple data visualization with ANES 2016 data on 
#                       people's opinions on the police and Black Lives Matter
#       Machine:        macOS  10.14
# #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

# Set your own working directory (where the relevant files are)
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# read in the csv file
# ANES 2016 data on people's opinions on the police and black lives matter
# (higher = more favourable)
anes <- read.csv("Data/Raw/ANES2016.csv")
head(anes)

# let's see what the police variable looks like
summary(anes$police)

# create a histogram of the police variable
hist(anes$police) # notice values higher than 100

# clean police data & BLM data
anes2 <- subset(anes, anes$police >=0 & anes$police <=100 & anes$BLM >=0 & anes$BLM<=100)
summary(anes2$police)

# histogram of cleaned police variable
hist(anes2$police)

# change number of bins
hist(anes2$police, breaks=20)

# change color
hist(anes2$police, col="aquamarine2")

# add main title to plot
hist(anes2$police, col="lightpink", main="Feeling Thermometer Scores")

# add subtitle to plot
hist(anes2$police, col="lightpink", main="Feeling Thermometer Scores", 
     sub="ANES 2016")

# change x axis name
hist(anes2$police, col="lightpink", main="Feeling Thermometer Scores", 
     sub="ANES 2016", xlab="Feelings Towards the Police")

# plot probability instead of frequency
hist(anes2$police, col="lightpink", main="Feeling Thermometer Scores", 
     sub="ANES 2016", xlab="Feelings Towards the Police", freq=FALSE)

# similarly make a hist of Black Lives Matter
hist(anes2$BLM)

# how do dems and reps view BLM?
# 1 = strong democrat, 7 = strong republican, 4 = independent
dems <- subset(anes2, anes2$partyID>=1 & anes2$partyID<=3)
reps <- subset(anes2, anes2$partyID>=5 & anes2$partyID<=7)

hist(dems$BLM)
hist(reps$BLM)

# visualize both plots side by side
par(mfrow=c(1,2))
hist(dems$BLM)
hist(reps$BLM)

# let's see how different party id values view BLM

# create a subset of only strong democrats
a <- subset(anes2, anes2$partyID==1)

# find their mean BLM score
avg1 <- mean(a$BLM)
avg1
# you can similarly find the median
median(a$BLM)
# or other percentiles
quantile(a$BLM, 0.75)

# create subsets for other party IDs (we'll see a more efficient way to do this later)
b <- subset(anes2, anes2$partyID==2)
avg2 <- mean(b$BLM)
c <- subset(anes2, anes2$partyID==3)
avg3 <- mean(c$BLM)
d <- subset(anes2, anes2$partyID==4)
avg4 <- mean(d$BLM)
e <- subset(anes2, anes2$partyID==5)
avg5 <- mean(e$BLM)
f <- subset(anes2, anes2$partyID==6)
avg6 <- mean(f$BLM)
g <- subset(anes2, anes2$partyID==7)
avg7 <- mean(g$BLM)

# combine all the mean values into one vector
means <- c(avg1, avg2, avg3, avg4, avg5, avg6, avg7)

# plot the newly created vector of means

par(mfrow=c(1,1))
plot(means)
plot(means, type="o")
plot(means, type="o", pch=16, cex=1.2)
abline(v=4, col="red", lty=2)

# we can also visualize this through a barplot
dev.off()
barplot(means)

# check out this link for all  the cool R color options:
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# close and clear plotting window
dev.off()
