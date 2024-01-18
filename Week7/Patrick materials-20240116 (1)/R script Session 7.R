

# Session 7: Statistical estimation ---------------------------------------

# Task 2: Calculating standard score --------------------------------------

library(tidyverse)

View(MASS::nlschools)

summary(MASS::nlschools)

hist(MASS::nlschools$IQ)

all_IQ_scores <- MASS::nlschools$IQ

raw_scores <- c(4.0, 6.5, 9.5, 12.5, 13.5)

z_scores <- (raw_scores - mean(all_IQ_scores)) / sd(all_IQ_scores)

z_scores

library(dplyr)

our_data <-
  tibble(
    raw_scores = raw_scores,
    z_scores = ((raw_scores - mean(all_IQ_scores)) / sd(all_IQ_scores)),
    percentile = pnorm(z_scores)
  )

View(our_data)