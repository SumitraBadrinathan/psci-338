# #######################################################################
#       File-Name:      4-Looping.R
#       Version:        R 3.4.3
#       Date:           Sep 27, 2018
#       Author:         Sumitra Badrinathan <sumitra@sas.upenn.edu>
#       Purpose:        For loop syntax and examples
#       Machine:        macOS  10.14
# #######################################################################

set.seed(1229)
rm(list=ls()) # remove objects from R workspace

# set working directory
setwd("~/Dropbox/PSCI338") #macs
#setwd("C:/Users/name/Dropbox/PSCI338") #windows

# 'for loops' let us repeat (loop) through the elements in a vector and run the same code on each element

# general loop syntax:

# for(index variable in vector){
#  commands / condititons
#  }

# loop through the sequence 1 to 5 printing the square of each number
for(a in 1:5)
{
  print(a^2)
}

# vector in loop does not have to be sequential
for(i in c(-3,6,2,5,9)){
  print(i^2)
}

# vector can also be specified before hand
x <- c(-3,6,2,5,9)
for(i in x){
  print(i^2)
}

# loops reduce tedious coding to a few lines

print(paste("The year is", 2010))
print(paste("The year is", 2011))
print(paste("The year is", 2012))
print(paste("The year is", 2013))
print(paste("The year is", 2014))
print(paste("The year is", 2015))
print(paste("The year is", 2016))

for (i in 2010:2050){
  print(paste("The year is", i))
}

# print the asterisk as many times as you want
for(i in 1:10) {
  print(rep("*",i)) }


for(i in 10:1) {
  print(rep("*",i)) }

# notice that you can't use loop output to do anything eg mean, median
# let's fix this

storage <- numeric(5) # create an empty vector to store loop results
for(i in 1:5){
  storage[i] = i^2 # i'th element of empty storage vec is going to be filled with i^2
}
storage # now we can use these numbers!
mean(storage)

# you always wanted to know the sum of the first 100 squares!!!
y = numeric(100)
for (i in 1:100)
{
  y[i] = i^2
}
sum(y)

# a more applied example: convert deg celcius to farenheit
degrees <- c(0, 5, 10, 15, 20)

for(DegC in degrees){
   DegF = DegC*(9/5)+32
  print(c(DegC, DegF))
}

degrees <- c(0, 5, 10, 15, 20)
begin = Sys.time()
for(DegC in degrees){
  DegF = DegC*(9/5)+32
  print(c(DegC, DegF))
}

# fun for loop example (from Andreas Buja)

 dev.new()   # Create an external plot window; plotting inside RStudio is inefficient.
a <- seq(0, 20*pi, length=1000) # Angles for traversing a spiral
r <- 1.1^a                      # Radii that increase as a function of angle
lim <- c(-1,1)*max(r)/2         # To fix the x- and y-ranges so they don't jump
for(j in 1:10000) { # Keep looping, stop by typing ESC in the console.
  a <- a - 0.1
  plot(r*cos(a), r*sin(a), xlim=lim, ylim=lim,
       type="l", xaxt="n", yaxt="n", xlab="", ylab="")
  dev.flush();  Sys.sleep(0.05)
}

