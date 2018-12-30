# Lab 7 Code : OLS

setwd("~/Dropbox/PSCI338/")

rm(list=ls())
dev.off()
library(readstata13)
dataJan <- read.dta13("Data/Raw/31114820.dta")

new <- subset(dataJan, select=c("Q15", "Q921", "Q901", "Q910", "income", "weight"))
colnames(new) <- c("Twitter", "Sex", "Ideology", "Age", "Income", "Weight")
head(new)
summary(new$Sex)

#recode ideology to numerical
# recode such that dems = 1, indep = 2, reps = 3
table(new$Ideology)
new$PID <- NA
new$PID[new$Ideology=="A Democrat"] <- 1
new$PID[new$Ideology=="An Independent"] <- 2
new$PID[new$Ideology=="A Republican"] <- 3
table(new$PID)

# difference in means
# do dems and reps view trump's twitter performance differently?
table(new$Twitter, new$PID)

# recode twitter variable to numeric
new$Tscore <- NA
new$Tscore[new$Twitter=="Hurt"] <- 0
new$Tscore[new$Twitter=="Help"] <- 1

# recode democrat in orgininal dataset
new$Dems <- 0
new$Dems[new$PID==1] <- 1

# recall from last class we did a t-test for diff in means
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
summary(model3) # hard to interpret


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

# relevel income
new$IncomeCat <- relevel(new$IncomeCat, ref = 2)
table(new$IncomeCat)

model5 <- lm(Tscore~ Dems + IncomeCat,  data=new)
summary(model5)

# five thirty eight hate crime data
install.packages("fivethirtyeight")
library(fivethirtyeight)
 View(hate_crimes)
hate_crimes
names(hate_crimes)

# is income inequality related to hate crimes? 
# write code for bivariate ols
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
summary(reg2) #not significant anymore.. 

# what else could theoretically predict hate crimes?
# share in trump vote. what is your theory?
reg3 <-lm(hate_crimes_per_100k_splc ~ share_vote_trump, data=hate_crimes) 
summary(reg3)

# theorize why we have the relationship we do in the data

# what variables could we add as controls? recall omitted variable bias:

# omitted-variable bias occurs when a statistical model leaves out relevant variables. 
# the bias results in the model attributing the effect of the missing variables to the estimated effects of the included variables.
# specifically: omitted vars are those that are correlated with both the DV and one or more of the independent variables.




# new regression with possible omitted variables
reg4 <-lm(hate_crimes_per_100k_splc ~ share_vote_trump + share_pop_metro + share_non_white, data=hate_crimes)
summary(reg4)

hate_crimes$trump100 <- (hate_crimes$share_vote_trump)*100
reg5 <-lm(hate_crimes_per_100k_splc ~ trump100 + share_pop_metro + share_non_white, data=hate_crimes)
summary(reg5)

# regression output using stargazer
library(stargazer)
stargazer(reg4)
stargazer(reg3, reg4, type="text")

#plot best fit line
plot(hate_crimes$share_vote_trump,hate_crimes$hate_crimes_per_100k_splc)
abline(reg3, col="red", lty=2)

# plot regression coefficients
install.packages("ggplot2")
library(ggplot2)
library(dotwhisker)

dwplot(reg4)
dwplot(list(reg3,reg4), show_intercept = TRUE)

# some useful functions with regression output
# model coefficients
coefficients(reg4) 

# predicted values (y-hats)
fitted(reg4) 

# residuals
residuals(reg4)