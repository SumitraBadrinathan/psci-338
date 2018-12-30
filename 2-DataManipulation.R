#  #######################################################################
#       File-Name:      2-DataManipulation.R
#       Version:        R 3.4.3
#       Date:           Sep 07, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Reading in and manipulating data on Amnesty's
#                       assessment of state terror in 1994
#       Machine:        macOS  10.14
#  #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

# set working directory
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# Download data file pts1994.csv from this repository and save it in the Data/Raw folder
# Read in the data : use read.csv for csv files or read.table for txt files

# reads in .csv with data on assessment of state terror in 1994
democracy94 <- read.csv("Data/Raw/pts1994.csv")
#democracy94 <- read.table("Data/Raw/pts1994.csv", header=TRUE, na="NA", sep=",")

# see type of data
class(democracy94) #this is a dataframe, like a spreadsheet

# see a snippet of the full data
head(democracy94) # first few rows

# data contains 6 variables and 179 rows, each row a country. Variables are country name,
# COW country code, world bank country code, 
# and amnesty & state departement's assessment of terror in 1994 on a scale of 1 to 5 (higher=more terror)

head(democracy94,15) # specify first 15 rows
names(democracy94) # see names of variables in datsaet

# see the data for one country
democracy94[1,] # with a dataframe, have to specify rows AND columns to be displayed
democracy94[1:10] # will this work?

# see the data for one variable, say Amnesty score (there are two ways to do this)
democracy94[,5] # notice missing data!
democracy94$Amnesty.1994

# summary of a variable
summary(democracy94$Amnesty.1994)

# tabulate the amnesty variable, ignoring missings
table(democracy94$Amnesty.1994)

# tabulate amnesty var, including missings
table(democracy94$Amnesty.1994, useNA = "ifany")

# create a table w proportions 
prop.table(table(democracy94$Amnesty.1994))

# basic numerical stats
max(democracy94$Amnesty.1994) #notice NA! how to remove?
mean(democracy94$Amnesty.1994, na.rm = T)
var()
sd()

# subsetting! 
head(democracy94)
#subset to only certain variables
reduced <- subset(democracy94, select=c(Country, Amnesty.1994))
head(reduced)
dim(reduced) # see dimensions of subsetted data

# subset to certain rows: display cases where amnesty score is <=2
lowterror <- subset(democracy94, democracy94$Amnesty.1994 <= 2)
head(lowterror,10)
table(lowterror$Amnesty.1994)
dim(lowterror)

# logical operators in R: evaluated to TRUE or FALSE
is.data.frame(democracy94)
is.matrix(democracy94)

# subset with missings
lowterror2 <- subset(democracy94, democracy94$Amnesty.1994 <= 2 | is.na(democracy94$Amnesty.1994))
dim(lowterror2)

# display cases where the two sources differ by more than one unit
disagree <- subset(democracy94, abs(Amnesty.1994 - StateDept.1994) >= 2)
dim(disagree)
disagree

# create a new variable to display which countries have an amnesty score of 5 AND state dep score of 5
democracy94$highterror <- as.numeric(democracy94$Amnesty.1994==5 & democracy94$StateDept.1994==5)
head(democracy94,10) #we created a new variable!
table(democracy94$highterror)
# which are those countries?
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
