### Lab 4: Graphics II ###

# Set your own working directory (where the relevant files are)
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# Clears the workspace
rm(list = ls())

# read in the csv file
anes <- read.csv("Data/Raw/ANES2016.csv")

# clean police data & BLM data
anes2 <- subset(anes, anes$police >=0 & anes$police <=100 & anes$BLM >=0 & anes$BLM<=100)

# recall from last lab that we created party ID subsets
a <- subset(anes2, anes2$partyID==1)
avg1 <- mean(a$BLM)
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

# combine all the mean values of BLM into one vector
meansBLM <- c(avg1, avg2, avg3, avg4, avg5, avg6, avg7)

# let's create a vec of means for police too
means2 <- c(mean(a$police), mean(b$police), mean(c$police), mean(d$police), 
                 mean(e$police), mean(f$police), mean(g$police))

# do the same thing with a loop - fewer lines of code!
meansPolice <- numeric(7)
for(i in 1:7){
  idx = which(anes2$partyID==i)
  meansPolice[i] = mean(anes2$police[idx])
}

# barplots
par(mfrow=c(1,1)) #reset plotting window

# create barplot
barplot(meansBLM, col = "coral")
barplot(meansPolice, col = "darkcyan", border=F) # remove border?


# plot means of both variables side by side
combined <- rbind(meansBLM, meansPolice)

barplot(combined) # this doesnt really give us what we want!

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

# density plots : like a smooth historgram 
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

# If youre interested in more ggplot stuff, I particularly like this tutorial:
# http://t-redactyl.io/tag/ggplot2.html

