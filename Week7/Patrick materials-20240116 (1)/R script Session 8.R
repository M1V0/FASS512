

# Session 8: Confidence intervals. Effect sizes. NHST. --------------------



# Confidence intervals ----------------------------------------------------

View(MASS::nlschools)

summary(MASS::nlschools)

all_IQ_scores <- MASS::nlschools$IQ

mean <- mean(all_IQ_scores)

sd <- sd(all_IQ_scores)

sample_size <- length(all_IQ_scores)

standard_error <- (sd / sqrt(sample_size))

standard_error

sample_size


t_value <- abs(qt(p = .05 / 2, df = 2286))

t_value <- abs(qt(.05 / 2, 2286))

t_value

# qt(p, df, ncp, lower.tail = TRUE, log.p = FALSE)

lower_limit <- mean - (t_value * standard_error)

upper_limit <- mean + (t_value * standard_error)

intervals_95 <- c(lower_limit, upper_limit)

intervals_95


# CIs with ESCI R ---------------------------------------------------------

# Installing esci for R

# Bob Calin-Jageman, 2020 workshop materials, retrieved here:

# https://osf.io/d89xg/wiki/tools:%20esci%20for%20R/


# Installing esci for R ---------------------------------------------------

install.packages("devtools")
devtools::install_github("rcalinjageman/esci")

library(esci)

# Example 1: NL Schools IQ

estimate <- estimateMean(MASS::nlschools,
                         IQ,
                         conf.level = .95)

View(estimate$summary_data)

# Example 2: Nettle (1999)

library(esci)

languages <- read.csv('nettle_1999_climate.csv')	

View(languages)

head(languages)

estimate <- estimateMean(languages, 
                         Langs, 
                         conf.level = .95
)
View(estimate$summary_data)

plotEstimatedMean(estimate)

langs_CI  <- plotEstimatedMean(estimate)
langs_CI  <- langs_CI  + ggtitle("Our title goes here")

langs_CI

# Other ESCI R things, but not for class ----------------------------------


# Estimate an independent mean difference ---------------------------------

library(esci)
data <- mtcars
data$am <- as.factor(data$am)
levels(data$am) <- c("automatic", "manual")
estimate <- estimateMeanDifference.default(data, 
                                           am, 
                                           mpg, 
                                           paired = FALSE, 
                                           var.equal = TRUE, 
                                           conf.level = .95,
                                           reference.group = 1
)
estimate$summary_data
plotEstimatedDifference(estimate)


# Estimate an independent mean difference ---------------------------------

# esci can estimate the difference between two independent means. This is the estimation replacement for an independent-samples t-test. In this example we estimate the difference in mpg for automatic vs. manual cars in the mtcars population.

library(esci)
data <- mtcars
data$am <- as.factor(data$am)
levels(data$am) <- c("automatic", "manual")
estimate <- estimateMeanDifference.default(data, 
                                           am, 
                                           mpg, 
                                           paired = FALSE, 
                                           var.equal = TRUE, 
                                           conf.level = .95,
                                           reference.group = 1
)
estimate$summary_data
plotEstimatedDifference(estimate)

# This function can also be called using summary data rather than raw data:

estimate <- estimateMeanDifference.numeric(m1 = 12,
                                           m2 = 10,
                                           s1 = 2,
                                           s2 = 2.1,
                                           n1 = 10,
                                           n2 = 20,
                                           labels = c("Treated", "Control"),
                                           paired = FALSE,
                                           var.equal = TRUE,
                                           conf.level = 0.95
)

estimate$summary_data
plotEstimatedDifference(estimate)
plotEstimatedDifference(estimate,
                        ylims = c(0, 20),
                        ylab = "My dependent variable",
                        xlab = "Treated vs. Control",
                        rope = c(-1, 1),
                        grouplabels = c("MyTreated", "MyControl"),
)


# Estimate a paired mean difference ---------------------------------------


# esci can estimate the difference between two paired means.


library(esci)
data <- mtcars
estimate <- estimateMeanDifference.default(data, gear, carb, 
                                           paired = TRUE, 
                                           conf.level = .95,
                                           reference.group = 2)
estimate$summary_data
plotEstimatedDifference(estimate)    


estimate <- estimateMeanDifference.numeric(m1 = 12,
                                           m2 = 10,
                                           s1 = 2,
                                           s2 = 2.1,
                                           n1 = 15,
                                           r = 0.7,
                                           paired = TRUE,
                                           labels = c("Post", "Pre"),
                                           conf.level = 0.95
)
estimate$summary_data
plotEstimatedDifference(estimate)


# Estimate a proportion ---------------------------------------------------



library(esci)
data <- mtcars
data$am <- as.factor(data$am)
levels(data$am) <- c("automatic", "manual")
estimate <- estimateProportion.default(data, am, 
                                       case.level = "automatic"
)
estimate$summary_data
plotEstimatedProportion(estimate)


estimate <- estimateProportion.numeric(cases = 20,
                                       n = 100,
                                       caselabels = c("Depressed", "Not Depressed"),
                                       conf.level = 0.95
)
estimate$summary_data
plotEstimatedProportion(estimate)


# Estimate a proportion difference ----------------------------------------


library(esci)
data <- mtcars
data$am <- as.factor(data$am)
levels(data$am) <- c("automatic", "manual")
data$vs <- as.factor(data$vs)
levels(data$vs) <- c("zero", "one")
estimate <- estimateProportionDifference.default(data, am, vs,
                                                 case.level = "one",
                                                 group.level = "manual"
)
estimate$summary_data
plotEstimatedProportionDifference(estimate)




estimate <- estimateProportionDifference.numeric(cases1 = 20,
                                                 n1 = 100,
                                                 cases2 = 10,
                                                 n2 = 101,
                                                 caselabels = c("Depressed", "Not Depressed"),
                                                 grouplabels = c("Females", "Males"),
                                                 conf.level = 0.95
)
estimate$summary_data
plotEstimatedProportionDifference(estimate)



# Estimate a correlation --------------------------------------------------


library(esci)
estimate <- estimateCorrelation(mtcars, hp, mpg)
estimate
plotEstimatedCorrelation(estimate)
plotScatterPlot(estimate, 
                show.line = TRUE, 
                show.meanCI = TRUE, 
                show.PI = TRUE, 
                predictx = 200
)


# Task 2: Calculating standard score --------------------------------------

library(tidyverse)

View(MASS::nlschools)

summary(MASS::nlschools)

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


