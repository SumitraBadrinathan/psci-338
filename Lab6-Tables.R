setwd("~/Dropbox/PSCI338/")

options(scipen = 999)

rm(list=ls())
getwd()
install.packages("readstata13")
library(readstata13)

dataJan <- read.dta13("Data/Raw/31114820.dta")
names(dataJan)

table(dataJan$Q15) #trump and twitter
table(dataJan$Q901) # ideology
table(dataJan$Q921) #sex
table(dataJan$Q910) #age

new <- subset(dataJan, select=c("Q15", "Q921", "Q901", "Q910"))
colnames(new) <- c("Twitter", "Sex", "Ideology", "Age")
head(new)
 

# making tables with stargazer
install.packages("stargazer")
library(stargazer) 
stargazer(new, type="text")
# notice that only age is in the table. any guesses why?


#recode ideology to numerical
# recode such that dems = 1, indep = 2, reps = 3
table(new$Ideology)
new$PID <- NA
# fill in this code
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

# difference in means
# do dems and reps view trump's twitter performance differently?
table(new$Twitter, new$PID)

# recode twitter variable to numeric

new$Tscore <- NA
new$Tscore[new$Twitter=="Hurt"] <- 0
new$Tscore[new$Twitter=="Help"] <- 1

# recode democrat in orgininal dataset
new$dems <- 0
new$dems[new$PID==1] <- 1

t.test(new$Tscore ~ new$dems)

# run ols regression
reg <- lm(Tscore~dems,  data=new)
summary(reg)

# output to table
stargazer(reg)
