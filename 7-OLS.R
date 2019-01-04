# #######################################################################
#       File-Name:      7-OLS.R
#       Version:        R 3.4.3
#       Date:           Oct 30, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Run bivariate and multivariate OLS models + visualize 
#                       regression results using FiveThirtyEight's hate crime data
#       Machine:        macOS  10.14
# #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

# set working directory
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# Download data file 31114820.dta from this repository and save it in the Data/Raw folder
# The file has ABC/Washington Post public opinion data from Jan 2018
# Codebook in repository ("Codebook31114820.pdf")

# load and install required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(stargazer, fivethirtyeight, ggplot2, dotwhisker)

# read in the file
dataJan <- read.dta13("Data/Raw/31114820.dta")

# create subset of relevant variables (same as last lab)
new <- subset(dataJan, select=c("Q15", "Q921", "Q901", "Q910", "income", "weight"))
colnames(new) <- c("Twitter", "Sex", "PartyID", "Age", "Income", "Weight")

# do democrats and republicans view Trump's twitter performance differently?
# recall that "Twitter" variable asks respondents whether Trump's twitter performance is hurting or helping him

# we can use a t-test or run a bivariate OLS model to test this

# first recode PartyID to numeric
# recode such that dems = 1, indep = 2, reps = 3
table(new$PartyID)
new$PID <- NA
new$PID[new$PartyID=="A Democrat"] <- 1
new$PID[new$PartyID=="An Independent"] <- 2
new$PID[new$PartyID=="A Republican"] <- 3
table(new$PID)

# recode twitter variable to numeric
new$Tscore <- NA
new$Tscore[new$Twitter=="Hurt"] <- 0
new$Tscore[new$Twitter=="Help"] <- 1

# recode democrat in orgininal dataset
new$Dems <- 0
new$Dems[new$PID==1] <- 1

# t test for difference in means
t.test(new$Tscore ~ new$Dems)

# bivariate OLS: produces the same result
model1 <- lm(Tscore~Dems, data=new)
summary(model1)

# put in weights
model2 <- lm(Tscore~Dems, weight=Weight, data=new)
summary(model2)

# multivariate OLS
table(new$Income)
model3 <- lm(Tscore ~ Dems + Income,  data=new)
summary(model3) # income coefficients hard to interpret


# reconstruct income to 3 categories: low, med, high (under 50, 50-75, 75-100)
new$IncomeCat <- NA
new$IncomeCat[new$Income=="Under 20 thousand dollars" | 
              new$Income=="20 to under 35 thousand" |
              new$Income=="35 to under 50 thousand"] <- "Low"

new$IncomeCat[new$Income=="50 to under 75 thousand"] <- "Medium"

new$IncomeCat[new$Income=="75 to under 100 thousand" |
              new$Income=="100 thousand or more" ] <- "High"

table(new$IncomeCat)

# redo model 3
model4 <- lm(Tscore ~ Dems + IncomeCat,  data=new)
summary(model4)

class(new$IncomeCat)
new$IncomeCat <- as.factor(new$IncomeCat)
levels(new$IncomeCat)

# can relevel income if required
new$IncomeCat <- relevel(new$IncomeCat, ref = 2)
table(new$IncomeCat)

model5 <- lm(Tscore~ Dems + IncomeCat,  data=new)
summary(model5)

# five thirty eight hate crime data from the "fivethirtyeight" package
# this is the data used for 538 article linking hate crimes to income inequality 
# https://fivethirtyeight.com/features/higher-rates-of-hate-crimes-are-tied-to-income-inequality/

# within the package, hate crime data is stored in "hate_crimes"
names(hate_crimes)

# is income inequality related to hate crimes, as the article says?

reg1 <- lm(hate_crimes_per_100k_splc ~ gini_index, data=hate_crimes)
summary(reg1)

# see scatterplot
plot(hate_crimes$gini_index , hate_crimes$hate_crimes_per_100k_splc)

#identify outlier
identify(hate_crimes$gini_index , hate_crimes$hate_crimes_per_100k_splc, n=1)
# or
which(hate_crimes$gini_index>0.52)
hate_crimes[9,]

# remove outlier and reshow regression
noDC <- hate_crimes[-c(9), ] 
dim(hate_crimes)
dim(noDC)

plot(noDC$gini_index, noDC$hate_crimes_per_100k_splc)

reg2 <- lm(hate_crimes_per_100k_splc ~ gini_index, data=noDC) 
summary(reg2) # not significant anymore

# what else could theoretically predict hate crimes?
# share in trump vote? what is your theory?
reg3 <-lm(hate_crimes_per_100k_splc ~ share_vote_trump, data=hate_crimes) 
summary(reg3)

# theorize why we have the inverse relationship in the data
# what variables could we add as controls? recall omitted variable bias

# new regression with possible omitted variables
reg4 <-lm(hate_crimes_per_100k_splc ~ share_vote_trump + share_pop_metro + share_non_white, data=hate_crimes)
summary(reg4)

# regression output using stargazer
stargazer(reg4)
# put two models together
stargazer(reg3, reg4, type="text")

# plot best fit line
plot(hate_crimes$share_vote_trump,hate_crimes$hate_crimes_per_100k_splc)
abline(reg3, col="red", lty=2)

# plot regression coefficients using a dot-whisker plot
dwplot(reg4)
dwplot(list(reg3,reg4), show_intercept = TRUE)

# some useful functions with regression output
# model coefficients
coefficients(reg4) 

# predicted values (y-hats)
fitted(reg4) 

# residuals
residuals(reg4)
