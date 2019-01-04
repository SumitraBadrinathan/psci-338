## Statistics for Political Science (Penn PSCI 338)

Instructor: [Marc Meredith](https://www.sas.upenn.edu/~marcmere/)

The goal of this class is to expose students to the process by which quantitative political science research is conducted. The class has three separate, but related tracks. Track one will teach some basic tools necessary to conduct quantitative political science research. Topics covered will include descriptive statistics, sampling, probability and statistical theory, and regression analysis. Track two will teach how to implement some of these basic tools using the computer program R. Track three will teach some basics in research design. Topics will include independent and dependent variables, generating testable hypotheses, and issues in causality.

This repository contains R code from lab sessions I taught for the class. Topics by week are as follows:

* Introduction to R: Basics of R including arithmetic, naming objects, indexing, creating lists & vectors

* Reading in data and data manipulation: Reading in and manipulating data on Amnesty's International's assessment of state terror in 1994; clean, subset, create new variables

* Graphics and data visualization: Simple graphics & data visualization with ANES 2016 feeling thermometer data on the police and Black Lives Matter

* Repeated iterations: For loop syntax and examples

* Distributions & Monte Carlo simulations: Normal and Uniform distributions + simulate the rolling of a die 

Bonus: see how to simulate 100,000 trials of the fun game Orchard. View success probability over varied N and strategy of play [here](https://sumitrabadrinathan.shinyapps.io/Orchard-Simulation/). Code in repository "Orchard.R" 

* Tables: Make descriptive statistics tables using the Stargazer package

* Linear models: Run bivariate and multivariate OLS models + visualize regression results using FiveThirtyEight's hate crime data

* Merging and reshaping data: Stack, bind, merge and reshape data

* Panel data: Using panel data to test the theory that alcohol consumption increases fatalities while driving

* Generalized linear models: Logit & probit regressions to model admit success probability + predicted probability plots + marginal effects


Run FileStructure.R from this repository before running other files. This will reproduce the folder structure used throughout.

R version 3.4.3 (2017-11-30)
<br>Platform: x86_64-apple-darwin15.6.0 (64-bit)
<br>Running under: macOS  10.14
