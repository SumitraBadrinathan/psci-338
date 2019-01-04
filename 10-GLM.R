# #######################################################################
#       File-Name:      10-GLM.R
#       Version:        R 3.4.3
#       Date:           Dec 10, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Logit & probit regressions to model admit success probability
#                       + predicted probability plots + marginal effects
#       Machine:        macOS  10.14
# #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

# set working directory
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# load and install required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readstata13, margins, effects)

# Download data file Binary.dta from this repository and save it in the Data/Raw folder
# File contains data on whether or not students were admitted to grad school. 
# We will model admit success as a function of GRE, GPA, and rank of undergrad school

# load in data
binarydata <- read.dta13("Data/Raw/Binary.dta")
stargazer(binarydata, type = "text")

# run OLS regressing admit on GRE + GPA + rank of school
binarydata$rank.f <- factor(binarydata$rank)
reg1 <- lm(admit ~ gre + gpa + rank.f, data = binarydata)
summary(reg1)

# save predicted values in separate variable
binarydata$predictedvalues <- predict(reg1)  

# are there values below 0?
summary(binarydata$predictedvalues)
belowzero <- subset(binarydata, predictedvalues < 0)
print(belowzero)

# use a logit model on the same data
output <- glm(admit ~ gre + gpa + rank.f, family=binomial(logit), data = binarydata)
summary(output)
# interpret constant: -3.98 is the log odds of getting into a school when everything else is 0

# predicted prob of Y for the first row
# calculates predicted probability of acceptenace for someone with a GRE of 380, 
# GPA of 3.61, and from undergraduate school in the third quartile
binarydata[1,]
exp(-3.989979 + 0.002264*380+0.804038*3.61+-0.675443*0+-1.340204*1+-1.551464*0) / 
        (1 + exp(-3.989979 + 0.002264*380+0.804038*3.61+-0.675443*0+-1.340204*1+-1.551464*0))

# plot predicted probabilities for all ranks

# give the values that you want to set the variable to
inputs <- cbind(1, 380, 3.61, 1:4)
# specify the names of the variables that you want to apply these values to
colnames(inputs) <- c("constant", "gre", "gpa", "rank.f")
# turn into a data frame
inputs <- as.data.frame(inputs)
# because rank.f is a factor, need to turn into a factor within the dataframe
inputs$rank.f <- as.factor(inputs$rank.f)
# gets the predicted probability of voting for every combination of covariates included in inputs and puts into vector forecast
forecast <- predict(output, newdata = inputs, type = "response")
print(forecast)

# plot it 
dev.off()
par(mfrow=c(1,1))
plot(y = forecast, x = 1:4, xaxt="n", ylim = c(0, 1), type = "o", 
     xlab = "Rank of School", ylab = "Predicted Probabilty of Admitance", col = "black", lty=1) 
axis(side=1, at=c(1, 2, 3, 4), labels = TRUE)
title(main="Rank of Undergraduate School and Probability of Grad School Acceptance", 
      sub="Applicant with 380 GRE and 3.61 GPA")

# plotting predicted probabilities (from the "margins" package))

# prediced prob of being admitted given rank
cplot(output, "rank.f", what = "prediction", 
      main = "Predicted Admit Probability, Given Rank")

# prediced prob of being admitted given gpa
cplot(output, "gpa", what = "prediction", main = "Predicted Admit Probability, Given GPA",
      col = "navyblue", se.type = "shade", se.fill = "lightblue")

# marginal effect of gpa
m <- margins(output) 
summary(m)

# marginal effect
# predicted increment of the response variable 
# associated with a unit increase in one of the covariates keeping the others constant.
cplot(output, "gpa", what = "effect", main = "Marginal Effect of GPA")


# if you want a predicted probability plot for each predictor variable
# use the plot(allEffects()) command from the "effects" package
plot(allEffects(output))

# probit example
output2 <- glm(admit ~ gre + gpa + rank.f, family=binomial(probit), data = binarydata)
summary(output2)

# similar results for logit and probit
stargazer(output, output2, type="text")

# interpreting probit coefficeints
print(binarydata[1,])
print(pnorm(-2.386836 + 0.001376*380+0.477730*3.61+-0.415399*0+-0.812138*1+-0.935899*0))
