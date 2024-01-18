# Session 8: Confidence intervals. Effect sizes. NHST. --------------------

library(tidyverse)

# Task 1: Confidence intervals --------------------------------------------

####### Our data set

View(MASS::nlschools)

####### Classic way

all_IQ_scores <- MASS::nlschools$IQ

mean(all_IQ_scores)

mean <- mean(all_IQ_scores) 	# M = 11.83406

sd <- sd(all_IQ_scores) 	# SD = 2.06889

sample_size <- length(all_IQ_scores) 	# N = 2,287

standard_error <- (sd / sqrt(sample_size)) 	# SE = 0.04326177

standard_error

t_value <- abs(qt(p = .05 / 2, df = 2286))

t_value <- abs(qt(.05 / 2, 2286))

t_value

lower_limit <- mean - (t_value * standard_error)

upper_limit <- mean + (t_value * standard_error)

intervals_95 <- c(lower_limit, upper_limit)

intervals_95

####### Example 2: Using the ESCI for R tools

## Example 2a

install.packages("devtools")

devtools::install_github("rcalinjageman/esci")

library(esci)

estimate <- estimateMean(MASS::nlschools,
                         IQ,
                         conf.level = .95)

View(estimate$summary_data)

## Examaple 2b

languages <- read.csv('nettle_1999_climate.csv')

View(languages)

estimate <- estimateMean(languages,
                         Langs,
                         conf.level = .95)

View(estimate$summary_data)

plotEstimatedMean(estimate)

langs_CI <- plotEstimatedMean(estimate)

langs_CI <- langs_CI + ggtitle("Our title goes here")

langs_CI


# Hypothesis tests for continuous variables: two groups -------------------

language_scores <- read.table(
  'language_scores.csv',
  header = T,
  row.names = 1,
  sep = ","
)

head(language_scores)

exam_1.ug <- subset(language_scores, study_level == 1)$exam_1

exam_1.pg <- subset(language_scores, study_level == 2)$exam_1

var(exam_1.ug)

var(exam_1.pg)

var(exam_1.pg) / var(exam_1.ug)

## Standard t-test

t.test(exam_1.ug, exam_1.pg, var.equal = T)

## Welch test

t.test(exam_1.ug, exam_1.pg, var.equal = F)

## Wilcoxon-Mann-Whitney test

wilcox.test(exam_1.ug, exam_1.pg, conf.int = 0.95)

## Getting ready for more tests

exam_1 <- subset(language_scores)$exam_1

exam_2 <- subset(language_scores)$exam_2

## Paired test

t.test(exam_1, exam_2, paired = T)

## Wilcoxon signed rank test

wilcox.test(
  exam_1,
  exam_2,
  paired = T,
  correct = F,
  conf.int = 0.95
)

#### Testing directional versus non-directional hypotheses

t.test(exam_1.ug,
       exam_1.pg,
       var.equal = T,
       alternative = "less")


# Task 3: Effect sizes: Cohen’s d  ----------------------------------------

#### Easy option

library(effsize)

cohen.d(exam_1, exam_2)

cohen.d(exam_1.ug, exam_1.pg)

#### Classic option

our_effect_size <-
  (mean(exam_1.ug) - mean(exam_1.pg)) / 
  sqrt(((sd(exam_1.ug) ^ 2) + (sd(exam_1.pg) ^ 2)) / 2)

our_effect_size

