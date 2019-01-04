# #######################################################################
#       File-Name:      9-PanelData.R
#       Version:        R 3.4.3
#       Date:           Nov 19, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Using panel data to test the theory that alcohol
#                       consumption increases fatalities while driving
#       Machine:        macOS  10.14
# #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

# set working directory
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# load and install required packages
if (!require("pacman")) install.packages("pacman")
pacman::p_load(readstata13, multiwayvcov, stargazer)

# (from Marc Meredith)

# download data file fatalities.dta from this repository and save it in the Data/Raw folder

# read in data
fatality <- read.dta13("Data/Raw/fatality.dta")
mydata <- subset(fatality, select = c(state, year, spircons, beertax, vmiles, mrall, unus))

# display the first few observations in the dataset
head(mydata)
# highway fatalities is stored in the variable "mrall"

# put variables on a scale to make coefficients easier to interpret
mydata$mrall <- mydata$mrall * 1000000
mydata$vmiles<- mydata$vmiles / 1000
stargazer(mydata, type = "text")

# show Spirit Consumption by state over time
plot(mydata$year, mydata$spircons, type="n", xlab = "Year", ylab = "Spirit Consumption")
text(mydata$year, mydata$spircons, labels=as.character(mydata$state)) # text
# observe correlations within state over time (observations over time not independent)

# shows beer tax by state over time
plot(mydata$year, mydata$beertax, type="n", xlab = "Year", ylab = "Tax Rate on Beer")
text(mydata$year, mydata$beertax, labels=as.character(mydata$state)) # text


# regress highway fatalities on spirit consumption
bivariate1 <- lm(mydata$mrall ~ mydata$spircons)
bivariate1.variance <- vcov(bivariate1)
bivariate1.stderrors <- sqrt(diag(bivariate1.variance))

# cluster standard errors by state
bivariate1.rvariance <- cluster.vcov(bivariate1 , mydata$state)
bivariate1.rstderrors <- sqrt(diag(bivariate1.rvariance))

temp <- mydata$year - 1900
mydata$stateyear <- paste(as.character(mydata$state), as.character(temp), sep = "")

# plot bivariate with OLS line
plot(mydata$spircons, mydata$mrall, type="n", xlab = "Spirit Consumption", ylab = "# Highway Fatalities per Million")
text(mydata$spircons, mydata$mrall, labels=as.character(mydata$stateyear)) # text
abline(bivariate1, col="red")

# regress highway fatalities on beer tax
bivariate2 <- lm(mydata$mrall ~ mydata$beertax)
bivariate2.variance <- vcov(bivariate2)
bivariate2.stderrors <- sqrt(diag(bivariate2.variance))

# cluster SE by state
bivariate2.rvariance <- cluster.vcov(bivariate2 , mydata$state)
bivariate2.rstderrors <- sqrt(diag(bivariate2.rvariance))

# plot bivariate with OLS line
plot(mydata$beertax, mydata$mrall, type="n", xlab = "Beer Tax", ylab = "# Highway Fatalities per Million")
text(mydata$beertax, mydata$mrall, labels=as.character(mydata$stateyear)) # text
abline(bivariate2, col="red")

stargazer(bivariate1, bivariate1, bivariate2, bivariate2,
          se  = list(bivariate1.stderrors, bivariate1.rstderrors, 
                     bivariate2.stderrors, bivariate2.rstderrors), digits = 2, omit.stat = c("f"),
          dep.var.labels=c("Driving fatalities per million"),
          covariate.labels = c("Spirits Consumption",
                               "Beer Tax"),      
          column.labels = c("OLS", "Clustered", "OLS", "Clustered"), type = "text")


# fixed effects model with 2 time periods
beforeafter <- subset(mydata, year == 1982 | year == 1988)

# add year fixed effects
beforeafter$year <- as.factor(beforeafter$year)
oneway <- lm(mrall ~ spircons + year, data = beforeafter) 

# add state fixed effects too: two way fixed effects
beforeafter$state <- as.factor(beforeafter$state)
twoway <- lm(mrall ~ spircons + year + state, data = beforeafter) 

# create comprehensive stargazer table of output
output1 <- lm(mrall ~ beertax + state + year, data = mydata)
output1.variance <- vcov(output1)
output1.stderrors <- sqrt(diag(output1.variance))
output1.rvariance <- cluster.vcov(output1 , cbind(mydata$state, mydata$year))
output1.rstderrors <- sqrt(diag(output1.rvariance))

output2 <- lm(mrall ~ beertax + vmiles + unus + state + year, data = mydata)
summary(output2)
output2.variance <- vcov(output2)
output2.stderrors <- sqrt(diag(output2.variance))
output2.rvariance <- cluster.vcov(output2 , cbind(mydata$state, mydata$year))
output2.rstderrors <- sqrt(diag(output2.rvariance))

stargazer(output1, output1, output2, output2,
          se  = list(output1.stderrors, output1.rstderrors, 
                     output2.stderrors, output2.rstderrors), digits = 2, 
          omit = c("state", "year"), omit.stat = c("f"),
          dep.var.labels=c("Driving fatalities per million"),
          covariate.labels = c("Beer Tax", "Miles Driven (thousands)", "Nat. Unemployment Rate"),      
          column.labels = c("OLS", "Clustered", "OLS", "Clustered"), 
          notes = "All regressions include state and year fixed effects", 
          notes.append = FALSE, notes.align = "l", type = "text")
