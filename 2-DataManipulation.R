### Lab 2: Data Manipulation ###

# See your current working directory
getwd()

# Set your own working directory (where the relevant files are)
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# Clears the workspace
rm(list = ls())

# Read your data file (use read.csv for csv files or read.table for txt files)
# Reads in .csv with data on assessment of state terror in 1994
democracy94 <- read.csv("Data/Raw/pts1994.csv")
#democracy94 <- read.table("Data/Raw/pts1994.csv", header=TRUE, na="NA", sep=",")

# see type of data
class(democracy94) #this is a dataframe, like a spreadsheet

# see a snippet of the full data
head(democracy94)
head(democracy94,15)
names(democracy94)

# See the data for one country
democracy94[1,]
democracy94[1:10] #will this work?

# See the data for one variable, say COW (there are two ways to do this)
democracy94[,5] # notice missing data!
democracy94$Amnesty.1994

#summary of a variable
summary(democracy94$Amnesty.1994)

#tabulate the amnesty variable, ignoring missings
table(democracy94$Amnesty.1994)

#tabulate amnesty var, including missings
table(democracy94$Amnesty.1994, useNA = "ifany")

#create a table w proportions 
prop.table(table(democracy94$Amnesty.1994))

#basic numerical stats
max(democracy94$Amnesty.1994) #notice NA! how to remove?
mean(democracy94$Amnesty.1994, na.rm = T)
var()
sd()

#subsetting! 
head(democracy94)
#subset to only certain variables
reduced <- subset(democracy94, select=c(Country, Amnesty.1994))
head(reduced)
dim(reduced)

#subset to values: display cases where amnesty score is <=2
lowterror <- subset(democracy94, democracy94$Amnesty.1994 <= 2)
head(lowterror,10)
table(lowterror$Amnesty.1994)
dim(lowterror)

#logical operators in R: evaluated to TRUE or FALSE
letters <- "abcdef"
letters=="abc"

is.data.frame(democracy94)
is.matrix(democracy94)
class(letters)

#subset with missings
lowterror2 <- subset(democracy94, democracy94$Amnesty.1994 <= 2 | is.na(democracy94$Amnesty.1994))
dim(lowterror2)

# Display cases where the two sources differ by more than one unit
disagree <- subset(democracy94, abs(Amnesty.1994 - StateDept.1994) >= 2)
dim(disagree)
disagree

#create a new variable to display which countries have an amnesty score of 5 AND state dep score of 5
democracy94$highterror <- as.numeric(democracy94$Amnesty.1994==5 & democracy94$StateDept.1994==5)
head(democracy94,10) #we created a new variable!
table(democracy94$highterror)
democracy94$Country[democracy94$highterror==1]

# exercise in spurious correlations

# what is the correlation b/w the divorce rate in maine & per capita consumption of margerine?
# 1. go to http://tylervigen.com/old-version.html
# 2. create a variable "divorce" which is a vector of divorce rates in maine from 2000-09
# 3. create a variable "margerine" which is a vector of margerine consumption from 00-09
# 4. find the correlation b/w "divorce" and "margerine"
# 5. come up with a causal theory to relate these two :)

# read stata 13 and 14 files in R
install.packages("readstata13")
library(readstata13)
data <- read.dta13("myStataFile.dta")

# read spss .sas and .por files in R
install.packages("memisc")
library(memisc)
data <- as.data.set(spss.system.file("filename.sav"))
data <- as.data.set(spss.portable.file("filename.por"))
