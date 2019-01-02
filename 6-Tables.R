# #######################################################################
#       File-Name:      6-Tables.R
#       Version:        R 3.4.3
#       Date:           Oct 15, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Learn to make tables using the Stargazer package
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

# install package to read stata files
install.packages("readstata13")
library(readstata13)

dataJan <- read.dta13("Data/Raw/31114820.dta")
names(dataJan)

# see a table summary of some relevant variables
table(dataJan$Q15)  # do you think Trump's twitter performance helps or hurts him?
table(dataJan$Q901) # ideology
table(dataJan$Q921) # sex
table(dataJan$Q910) # age

# subset out relevant variables
new <- subset(dataJan, select=c("Q15", "Q921", "Q901", "Q910"))
colnames(new) <- c("Twitter", "Sex", "Ideology", "Age")
head(new)
 
# making tables with stargazer
install.packages("stargazer")
library(stargazer) 

# create a summary statistics table for all the variables in "new"
stargazer(new, type="text")

# notice that only age is in the table. we have to convert the rest to numeric
#recode ideology to numerical
# recode such that dems = 1, indep = 2, reps = 3
new$PID <- NA
new$PID[new$Ideology=="A Democrat"] <- 1
new$PID[new$Ideology=="An Independent"] <- 2
new$PID[new$Ideology=="A Republican"] <- 3
table(new$PID)

# change title of table 
stargazer(new, type="text", title = "Descriptive Stats Table")

# save output in external file
stargazer(new, type="text", title = "Descriptive Stats Table",
          out="Table/Lab6Table.txt")

# show all the descriptive stats you can output
stargazer(new, type="text", title = "Descriptive Stats Table", 
          summary.stat = c("n", "mean", "sd", "min", "p25", "median", "p75", "max"))

# output just a subset of descriptive stats
stargazer(new, type="text", title = "Descriptive Stats Table", 
          summary.stat = c("n", "mean", "sd","median"))

# output only some variables
stargazer(new[c("Age")], type="text")

# change # of digits, flip rows and cols
stargazer(new, type="text", digits=2, flip=T)

# change variable names: tables / graphs need to be stand alone
stargazer(new, type="text", title="table with new lables",
          covariate.labels = c("Age", "PartyID (Higher=more conservative)"))

# subset within stargazer
stargazer(subset(new, new$Age<60), type="text")

# remove type="text" to output latex code
stargazer(new, title = "Descriptive Stats Table")
