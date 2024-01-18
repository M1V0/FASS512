# From the handout --------------------------------------------------------

library(tidyverse)

install.packages("rmarkdown")

# Loading and inspecting data ---------------------------------------------

library(MASS)

data(Cars93)

help(Cars93)

summary(Cars93)

# Scatterplot -------------------------------------------------------------

plot(
  Cars93$Horsepower,
  Cars93$Max.Price,
  pch = 18,
  cex = 2,
  col = "turquoise",
  xlab = "Horsepower",
  ylab = "Max. Price",
  main = "Horsepower against Max. Price for 93 Cars in 1993"
)

# Performing correlation tests in R ---------------------------------------

cor.test(Cars93$Horsepower,
         Cars93$Max.Price,
         method = "spearman",
         exact = FALSE)

cor.test(Cars93$Horsepower, Cars93$Max.Price, method = "kendall")

cor.test(Cars93$Horsepower, Cars93$Max.Price, method = "pearson")

rho <- 0.8215706
n <- 93
z <- 0.5 * log((1 + rho) / (1 - rho))
lci <- z - (1.96 / sqrt(n - 3))
uci <- z + (1.96 / sqrt(n - 3))
c((exp(2 * lci) - 1) / (exp(2 * lci) + 1), (exp(2 * uci) - 1) / (exp(2 *
                                                                       uci) + 1))

# Simple Linear Regression  -----------------------------------------------

our_model <- lm(Max.Price ~ Horsepower, data = Cars93)

summary(our_model)

confint(our_model)

predict(our_model)

our_model$resid

Cars93$Max.Price - predict(our_model)

#### Plot

plot(
  Cars93$Horsepower,
  Cars93$Max.Price,
  pch = 18,
  cex = 2,
  col = "darkorchid4",
  xlab = "Horsepower",
  ylab = "Max. Price",
  main = "Horsepower against Max. Price for 93 Cars in 1993"
)

abline(our_model, lwd = 2)

# Assumptions of linear regression ----------------------------------------

qqnorm(our_model$resid)

qqline(our_model$resid)


# Practice task correlation and linear regression -------------------------

# Scatterplot -------------------------------------------------------------

plot(
  Cars93$EngineSize,
  Cars93$Horsepower,
  pch = 18,
  cex = 2,
  col = "blue",
  xlab = "EngineSize",
  ylab = "Horsepower",
  main = "Engine Size against Horsepower for 93 Cars in 1993"
)

# Performing correlation tests in R ---------------------------------------

cor.test(Cars93$EngineSize,
         Cars93$Horsepower,
         method = "spearman",
         exact = FALSE)

rho <- 0.8141756
n <- 93
z <- 0.5 * log((1 + rho) / (1 - rho))
lci <- z - (1.96 / sqrt(n - 3))
uci <- z + (1.96 / sqrt(n - 3))
c((exp(2 * lci) - 1) / (exp(2 * lci) + 1), (exp(2 * uci) - 1) / (exp(2 *
                                                                       uci) + 1))

# Simple Linear Regression  -----------------------------------------------

practice_task_model <- lm(Horsepower ~ EngineSize, data = Cars93)

lm(Horsepower ~ EngineSize, data = Cars93)

summary(practice_task_model)

#### Plot

plot(
  Cars93$EngineSize,
  Cars93$Horsepower,
  pch = 18,
  cex = 2,
  col = "green",
  xlab = "EngineSize",
  ylab = "Horsepower",
  main = "EngineSize against Horsepower for 93 Cars in 1993"
)

abline(practice_task_model, lwd = 2)

qqnorm(practice_task_model$resid)

qqline(practice_task_model$resid)

# Tests for categorical variables -----------------------------------------

#### Creating our matrix

our_data <- matrix(c(9, 46, 19, 141, 104, 131), ncol = 2)

our_data

#### Labels for the matrix

# Set names for rows and columns

rownames(our_data) <- c("UK", "Poland", "France")

colnames(our_data) <- c("Smoker", "Non-smoker")

our_data

#### Chi-squared test and Fisher test

x.test <- chisq.test(our_data, correct = FALSE)

f.test <- fisher.test(our_data)

x.test

f.test

#### Fisher for 2 x 2

#Smoker	Non­smoker
#Undergraduate	20	80
#Postgraduate	30	70

two_by_two <- matrix(c(20, 30, 80, 70), ncol = 2)

two_by_two

fisher.test(two_by_two)

#### Likelihood-ratio test

library(MASS)

lr_test <- loglm(~ 1 + 2, our_data)

lr_test

#### Effect sizes

sqrt(x.test$stat / sum(our_data))

sqrt(x.test$stat / (sum(our_data) * (min(dim(
  our_data
)) - 1)))

#### Analysing the Residuals

x.test$residuals

x.test$expected


# Task categoricals -------------------------------------------------------

hesa_data <-
  matrix(
    c(
      3120,
      13490,
      8675,
      1760,
      800,
      2355,
      5410,
      3670,
      1085,
      385,
      1440,
      1860,
      1455,
      590,
      155,
      2740,
      15115,
      9785,
      1755,
      1150,
      795,
      7255,
      5200,
      920,
      480,
      3095,
      16830,
      15595,
      4240,
      2685,
      2635,
      11675,
      4955,
      645,
      280,
      2010,
      9325,
      3725,
      505,
      240
    ),
    ncol = 5,
    byrow = T
  )

rownames(hesa_data) <-
  c(
    'Biological sciences',
    'Physical sciences',
    'Mathematical sciences',
    'Social studies',
    'Law',
    'Business studies',
    'Languages',
    'Historical & philosophical studies'
  )

colnames(hesa_data) <-
  c('1st',  '2.1',  '2.2',  '3rd / Pass',  'Unclassified')

View(hesa_data)


