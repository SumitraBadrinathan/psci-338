
# #######################################################################
#       File-Name:      5-Simulations.R
#       Version:        R 3.4.3
#       Date:           Oct 03, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Normal and Uniform distributions + 
#                       simulate the rolling of a die
#       Machine:        macOS  10.14
# #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

# set working directory
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# R Functions for Probability Distributions  

# every distribution that R handles has four functions. 
# there is a root name, for example, the root name for the normal distribution is "norm" 
# this root is prefixed by one of the letters

# p for "probability", the cumulative distribution function (cdf)
# q for "quantile", the inverse cdf
# d for "density", the density function (pdf)
# r for "random", a random variable having the specified distribution


# THE NORMAL DISTRIBUTION
# pnorm is the function that calculates cdf

pnorm(27.4, mean=50, sd=20)
pnorm(27.4, 50, 20)
# they look up P(X < 27.4) when X is normal with mean 50 and standard deviation 20

# Example 1: suppose a Democrat in PA gets daily donations in $$ that are normally distributed with mean $17.46 and
# standard deviation $19.39. what is the probability that randomly chosen day has a donation
# of less than $19?
pnorm(19,17.46,19.39)

# Example 2: what is the probability that randomly day has a donation
# of more than than $21?
1-pnorm(21,17.46,19.39)

# Example 3: Assume that the mean 2-party vote share of an incumbent is distributed normal with mean=0.62,var=0.0036
# what is the probability that the incumbent loses?
pnorm(0.5,0.62,sqrt(0.0036))

# qnorm is the function that calculates the inverse cdf
# so given a number p between zero and one, qnorm looks up the p-th quantile of the normal distribution

# Example 1: Suppose IQ scores are normally distributed with mean 100 and standard deviation 15. 
# what is the 90th percentile of the distribution of IQ scores?
qnorm(0.9,100,15)

# Example 2: Assume the mean 2-party vote share of incumbent is normal with mean=0.62,var=0.0036
# what vote share should the incumbent in the 95th percentile receive?
qnorm(0.95,0.62,sqrt(0.0036))

## generate random values from the normal 
rnorm(1,0,1)
rnorm(5,0,1)
rnorm(5,5,2)

# the ecdf function applied to a data sample returns a function representing the '
# empirical cumulative distribution function. For example:

X = rnorm(100) # X is a sample of 100 normally distributed random variables
P = ecdf(X)    # P is a function giving the empirical CDF of X
P(0.0)         # this returns the empirical CDF at zero : what should it be?
plot(P)        # draws a plot of the empirical CDF


# plotting random draws from normal dists : an example of monte carlo simulations
# notice:random draws differ on each trial!
dev.off()
temp1 <- rnorm(500000)
plot(density(temp1))
temp2 <- rnorm(500000) # what happens if we change N?
lines(density(temp2), col="blue",lty=2)
temp3 <- rnorm(500000)
lines(density(temp3), col="red",lty=3)

# normal distributions have a similar shape, but their central tendency and spread can differ
vals1 <- rnorm(10000,0,1)
plot(density(vals1), col="red",lwd=1.5)

# create a vector of 10000 draws not centered at 0 but with sd=1
vals2<- rnorm(10000,1,1)
lines(density(vals2), col="blue")
# create a vector of 10000 draws centered at 0 but with larger sd
vals3 <- rnorm(10000,0,3)
lines(density(vals3))

## THE UNIFORM DISTRIBUTION
## the probability that a random variable takes on any value in a range is the same 

# draws 1 random number between 0 and 1
temp <- runif(1, min = 0, max = 1)
print(temp)

# draws 5 random numbers between 0 and 1
temp <- runif(5, min = 0, max = 1)
print(temp)

# draws 1 random number between 0 and 3
temp <- runif(5, min = 0, max = 3)
print(temp)

# simulates an event that has a 30% chance of happening, 70% chance of not happening
temp <- runif(1, min = 0, max = 1)
print(temp)
event <- NA
# Numbers between 0 and 7/10 signify that the event didn't happe
if (temp >= 0 & temp <= 7/10) {
  event <- 0
}
if (temp > 7/10 & temp <= 1) {
  event <- 1
}
print(event)

# (from Marc Meredith)
# Simulates the rolling of a die 
temp <- runif(1, min = 0, max = 1)
print(temp)
die <- NA
# Numbers between 0 and 1/6 signify that you rolled a 1
if (temp >= 0 & temp <= 1/6) {
  die <- 1
}
# Numbers between 1/6 and 2/6 signify that you rolled a 2
if (temp > 1/6 & temp <= 2/6) {
  die <- 2
}
# Numbers between 2/6 and 3/6 signify that you rolled a 3
if (temp > 2/6 & temp <= 3/6) {
  die <- 3
}
# Numbers between 3/6 and 4/6 signify that you rolled a 4
if (temp > 3/6 & temp <= 4/6) {
  die <- 4
}
# Numbers between 4/6 and 5/6 signify that you rolled a 5
if (temp > 4/6 & temp <= 5/6) {
  die <- 5
}
# Numbers between 5/6 and 1 signify that you rolled a 6
if (temp > 5/6 & temp <= 1) {
  die <- 6
}
print(die)

