#  #######################################################################
#       File-Name:      1-Intro.R
#       Version:        R 3.4.3
#       Date:           Dec 03, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        Introduction to the basics of R, including
#                       naming objects, indexing, creating lists & vectors
#       Dependencies:   FileStructure.R
#       Machine:        macOS  10.14
#  #######################################################################

set.seed(1221)
rm(list=ls()) # remove objects from R workspace

getwd() # get current working directory 

# save FileStructure.R in current working directory and run to reproduce folder structure
source("/Users/sumitra/FileStructure.R")

# set working directory
setwd("~/Dropbox/PSCI338/Code") # for macs
# setwd("C:/Users/name/Dropbox/PSCI338") # for windows

# arithmetic and math operations
2+2 # addition
1-1 # subtraction
6/2 # division

pi^2 # raise things
sqrt(9) #square root

# assigning objects / making variables
# give objects in R a name with the arrow <- assignment operator
age <- (21+22+23+24)/4
WhyDoWeHaveRecitation <- "I dont know"
# print object name to see contents
WhyDoWeHaveRecitation

# can also use equal to sign to assign objects
WhyDoWeHaveRecitation = "I don't know"
WhyDoWeHaveRecitation
# can also assign from left to right, though less common
"I don't know" -> WhyDoWeHaveRecitation 
WhyDoWeHaveRecitation

# displaying functions of variables
var1 <- pi
var1
var1^2

# making vectors
# vector: sequence of items that uses the same data type
vec1 <- c(1,2,3) 
vec1
vec2 <- 51:100 #by indexing
vec2
vec3 <- rep(4, 7) #by repeating
vec3
vec4 <- seq(1,12,1.33) #by sequencing
vec4
vec5 <- seq(1,12,length.out=10) #sequencing, forces to length10
vec5

# indexing vectors, access
vec4[3] # access third element of vec4
vec4[1:3] # access 1st thru 3rd elements of vec4
vec4[23:24] # what if there's nothing to access?

vec4[c(1,3,7)] # access specific elements not in a cont. set
vec4[c(1,1,1,3)] # access same element multiple times; careful!
vec4[-4] # all elements except 4th

# what if you want to access all but 1:3 of vec4?
vec4[-1:3] # will this work?
# fix it by wrapping in ()
vec4[-(1:3)] 
vec4[-c(1:3)] # negate using concatonate
vec4[9:1] # access in reverse

# vector equivalence, relational operators
vec5 <- c(2,2,2)
all.equal(vec5, c(2,2,2)) #all.equal for complete equivalence

vec5==c(2,2,2) # equivalence, does it element wise
vec5>c(2,2,2) # greater than
vec5<c(1,2,3) # less than
vec5<=c(1,2,3) # less than or eq
vec5!=c(1,2,3) # not equal, tricky logic!

# creating lists
list1 <- list(vec1, vec2, vec3) # this is a list of vectors
list2 <- list(newname=vec1, justnumbers=vec2, boring=vec3) # name elements

list2$boring # access elements
listvar <- list2$boring # access elements and put them into new variables
list2$boring[1:3] # access elements within elements

# looking at data : a snippet

faithful #inbuilt dataset in r
head(faithful) #head of the data
plot(faithful,col="green",pch=16,cex=0.7) #see what the data looks like
lines(lowess(faithful$eruptions, faithful$waiting, f = 2/3, iter = 3), col = "red")
head(faithful$eruptions)

# exercise: can you find the number of rows in faithful?

