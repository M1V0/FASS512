
# Script for homework task 2 ----------------------------------------------

# First, I install the tidyverse package

install.packages('tidyverse')
library(tidyverse)

# Here, I load the data, which I previously downloaded from our Moodle page.
# I then view the table, just to make sure all imported well.

language_exams <- read.csv('language_exams.csv')
View(language_exams)

# Question 1: How many observations and columns does the data file contain?
# To answer this, I can check the Environment tab, or use the following command.
# Answers: 474 obs. of  5 variables

str(language_exams)

# Question 2: Run commands to display the first and the last six lines of the table

head(language_exams)
tail(language_exams)

# Question 3: What is the average age of participants?
# Answer: 21.5865

mean(language_exams$age)

# Question 4: What type of variable is student_id?
# Answer: "integer"

class(language_exams$student_id)

# Question 5: What is the rounded mean score on exam 3?
# Answer: 61

round(mean(language_exams$exam_3))

# Question 6: What is the difference between the mean scores on exams 1 and 2?

mean(language_exams$exam_2) - mean(language_exams$exam_1)

# Last but not least, we need to save the script.
# Answer: I have just clicked the Save icon in the script editor. :-)
