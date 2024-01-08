# These are the commands we used in Session 2 (handout).

# Executing R code in scripts ---------------------------------------------

2 + 3

scores <- c(145, 234, 653, 876, 456)
round(mean(scores))
round(sd(scores))

# Multiline commands ------------------------------------------------------

df <- data.frame(name = c('jane', 'michaela', 'laurel', 'jaques'), 	age = c(23, 25, 46, 19), occupation = c('doctor', 'director', 	'student', 'spy'))

df <- data.frame(name = c('jane', 'michaela', 'laurel', 'jaques'),
age = c(23, 25, 46, 19),
occupation = c('doctor', 'director', 'student', 'spy'))

# Comments ----------------------------------------------------------------

# Here is data frame with three variables.
# The variables refer to the names, ages, and occupations of the 	participants.

df <- data.frame(name = c('jane', 'michaela', 'laurel', 'jaques'),
age = c(23, 25, 46, 19),
occupation = c('doctor', 'director', 'student', 		'spy'))

2 + 3 	# This is addition in R.
2 / 1	# This is division.

# Code sections -----------------------------------------------------------

# Create vectors ---------------
scores_test1 <- c(1, 5, 6, 8, 10) # These are the scores on the pre-test.
scores_test2 <- c(25, 23, 52, 63) # These are the scores on the post-test.

# A few calculations ---------------
mean(scores_test1)
mean(scores_test2)
round(mean(scores_test2) - mean(scores_test1)) # The difference btw 	pre and post-tests.

# Installing and loading a package ----------------------------------------

install.packages('tidyverse')
library(tidyverse)

# Citing R and package developers -----------------------------------------

citation("tidyverse")
citation("lme4")
citation()
R.Version() $version.string

# Working directories and clean workspaces --------------------------------

getwd()
list.files()

# Loading data ------------------------------------------------------------

languages <- read.csv('nettle_1999_climate.csv')

text_file <- read.table('example_file.txt', sep = "\t", header = TRUE)

library(readxl)
spreadsheet_exl <- read_excel('simd.xlsx', sheet = 'simd')

# Examining datasets ------------------------------------------------------

View(spreadsheet_exl)
View(languages)
str(languages)
head(languages)		# This displays the first six rows.
tail(languages)		# This displays the last six rows.

summary(languages)
str(languages)

str(languages$Population)

class(languages$Population)
head(languages$Population)
tail(languages$Population)
summary(languages$Population)