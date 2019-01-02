# #######################################################################
#       File-Name:      3-Graphics.R
#       Version:        R 3.4.3
#       Date:           Sep 20, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Simple graphics & data visualization with ANES 2016 
#                       feeling thermometer data on the police and Black Lives Matter
#       Machine:        macOS  10.14
# #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

# set working directory
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# Download data file ANES2016.csv from this repository and save it in the Data/Raw folder

# read in the csv file
# ANES 2016 feeling thermometer data on people's opinions on the police and Black Lives Matter
# (scale of 1:100, higher = more favourable)
anes <- read.csv("Data/Raw/ANES2016.csv")
head(anes)

# let's see what the police variable looks like
summary(anes$police)

# create a histogram of the police variable
hist(anes$police) # notice values higher than 100

# clean police & BLM variables
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

# similarly make a histogram of Black Lives Matter
hist(anes2$BLM)

# how do Democrats and Republicans view Black Lives Matter?
# 1 = strong democrat, 7 = strong republican, 4 = independent
dems <- subset(anes2, anes2$partyID>=1 & anes2$partyID<=3)
reps <- subset(anes2, anes2$partyID>=5 & anes2$partyID<=7)

hist(dems$BLM)
hist(reps$BLM)

# visualize both plots side by side
par(mfrow=c(1,2))
hist(dems$BLM)
hist(reps$BLM)

# let's see how different party ID values view BLM

# create a subset of only strong democrats
a <- subset(anes2, anes2$partyID==1)

# find their mean BLM score
avg1 <- mean(a$BLM)
avg1
# you can similarly find the median
median(a$BLM)
# or other percentiles
quantile(a$BLM, 0.75)

# create subsets for other party IDs (we'll see a more efficient way to do this below)
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

#let's create a vector of means for police variable too
means2 <- c(mean(a$police), mean(b$police), mean(c$police), mean(d$police), 
                 mean(e$police), mean(f$police), mean(g$police))

# do the same thing with a loop - fewer lines of code!
meansPolice <- numeric(7)
for(i in 1:7){
  idx = which(anes2$partyID==i)
  meansPolice[i] = mean(anes2$police[idx])
}

# easiest way to do this: use the aggregate function
aggregate(anes2$police, by=anes2["partyID"], FUN=mean)

# barplots
par(mfrow=c(1,1)) #reset plotting window

# create barplot
barplot(meansBLM, col = "coral")
barplot(meansPolice, col = "darkcyan", border=F) # remove border

# plot means of both variables side by side
combined <- rbind(meansBLM, meansPolice)

barplot(combined) # this doesn't really give us what we want!

dev.off()
# barplot with colors and no  border
bp <- barplot(combined, beside=T, col=c("coral", "darkcyan"), border=F)

# add labels, change y axis limits, add main title
bp <- barplot(combined, beside=T, col=c("coral", "darkcyan"), border=F, ylim=c(0,100),
              names.arg=c("Strong dem.", "Dem.", "Weak dem.", "Indep.", "Weak Rep.", "Rep.", "Strong Rep."),
              main=("Average feeling thermometer score by party ID"))
# add text
text(bp, combined, round(combined,1), pos=3, cex=0.8)
# add legend
legend("topleft",legend=c("Black Lives Matter", "Police"), 
       cex=0.8, fill=c("coral", "darkcyan"), bty='n')

# boxplots
par(mfrow=c(1,2))
boxplot(anes2$police)
boxplot(anes2$BLM)

# density 
par(mfrow=c(1,1))
# density of police
plot(density(anes2$police), col="red")
# dencity of both together
lines(density(anes$BLM), col="blue")

# density - a ggplot example
library(ggplot2)
ggplot(anes2, aes(x=police)) + geom_density() 
# increase transparency, add color
ggplot(anes2, aes(x=police)) + geom_density(fill="gold1", color="goldenrod2", alpha=0.4) 
# plot both densities together
ggplot() +
  geom_density(aes(x=police), fill="coral", color="red", data=anes2, alpha=0.4) + 
  geom_density(aes(x=BLM), fill="blue", color="blue", data=anes2, alpha=0.4)

# check out this link for all the cool R color options:
# http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# close and clear plotting window
dev.off()
