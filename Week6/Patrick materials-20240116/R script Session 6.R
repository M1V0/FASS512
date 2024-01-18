
# Script for Handout Session 6 --------------------------------------------

# Installing and loading packages -----------------------------------------

install.packages("tidyverse")
library(tidyverse)

install.packages('reshape')
library(reshape)

# Task from Winter: Playing around with normal distribution ---------------

# Generate 50 random uniformly distributed numbers:

x <- runif(50)

# Check:

x

# Specify min and max:

y <- runif(50, min = 2, max = 6)

# Check:

head(y)

# Create a quick-and-dirty base R plot:

hist(y, col = 'mediumspringgreen')
abline(v = mean(y), lty = 2, lwd = 2)


# Generate random normally distributed numbers & plot 'em:

z <- rnorm(50)
hist(z, col = 'mistyrose')
abline(v = mean(z), lty = 2, lwd = 2)

# Create random data with mean = 5 and SD = 2:

a <- rnorm(50, mean = 5, sd = 2)
hist(a, col = 'turquoise')
abline(v = mean(a), lty = 2, lwd = 2)

# Check mean and SD:

mean(a)
sd(a)

# Check the percentiles:

quantile(a)

# Check the values that span the 68% interval:

quantile(a, 0.16)
quantile(a, 0.84)

# This should correspond to +/- 1 SD around the mean:

mean(a) - sd(a)
mean(a) + sd(a)

# The values of the 95% interval:

quantile(a, 0.025)
quantile(a, 0.975)

# This should correspond to +/- 2 SD around the mean:

mean(a) - 2 * sd(a)
mean(a) + 2 * sd(a)

# Execture repeatedly to get a feel for the normal:

hist(rnorm(n = 20))

hist(rnorm(n = 20))

hist(rnorm(n = 20))

hist(rnorm(n = 20))

hist(rnorm(n = 20))

# How sample size affects distribution:

hist(rnorm(n = 5))

hist(rnorm(n = 10))

hist(rnorm(n = 20))

hist(rnorm(n = 30))

hist(rnorm(n = 40))

hist(rnorm(n = 50))

hist(rnorm(n = 100))

hist(rnorm(n = 500))

hist(rnorm(n = 1000))

# Task Brown: LLN in action -----------------------------------------------

set.seed(3376)
mu=100; sigma=10; n=10

xbar1=rep(0,5)
for (i in 1:5) {xbar1[i]= mean(rnorm(n, mean=mu, sd=sigma))}

xbar2=rep(0,10)
for (i in 1:10) {xbar2[i]=mean(rnorm(n, mean=mu, sd=sigma))}

xbar3=rep(0,100)
for (i in 1:100) {xbar3[i]=mean(rnorm(n, mean=mu, sd=sigma))}

# Figure 8-2

x <- list(v1=xbar1,v2=xbar2,v3=xbar3)
data <- melt(x)

xb1 <- mean(xbar1)
xb2 <- mean(xbar2)
xb3 <- mean(xbar3)

xb1 # 98.89503
xb2 # 100.4808
xb3 # 100.071

ggplot(data, aes(x = value, fill = L1)) +
  geom_density(alpha = .50) +
  ggtitle("Brown (2021, Figure 8-2): Increased Draws, Increased Accuracy") +
  xlab("Value") +
  ylab("Density") +
  theme_minimal() +
  theme(plot.title = element_text(size = 8, face = "bold")) +
  theme(axis.title = element_text(size = 8, face = "bold")) +
  geom_vline(xintercept = xb1, col = "#bf0000") +
  geom_vline(xintercept = xb2, col = "#008b00") +
  geom_vline(xintercept = xb3, col = "#0000ff") +
  annotate(
    "text",
    x = 95,
    y = .15,
    label =
      "Mean with 5 draws = 98.895",
    col = "#bf0000"
  ) +
  annotate(
    "text",
    x = 95,
    y = .175,
    label =
      "Mean with 10 draws = 100.481",
    col = "#008b00"
  ) +
  annotate(
    "text",
    x = 95,
    y = .20,
    label =
      "Mean with 100 draws = 100.071",
    col = "#0000ff"
  ) +
  theme(legend.position = "none")


# Task Brown: CLT in action -----------------------------------------------

set.seed(3376)

mu=100; sigma=10; n=5
xbar1=rep(0,10)
for (i in 1:10) {xbar1[i]=mean(rnorm(n, mean=mu, sd=sigma))}

mu=100; sigma=10; n=10
xbar2=rep(0,10)
for (i in 1:10) {xbar2[i]=mean(rnorm(n, mean=mu, sd=sigma))}

mu=100; sigma=10; n=100
xbar3=rep(0,10)
for (i in 1:10) {xbar3[i]=mean(rnorm(n, mean=mu, sd=sigma))}

# Figure 8-3
x <- list(v1=xbar1,v2=xbar2,v3=xbar3)
data <- melt(x)

xb1 <- sd(xbar1)
xb2 <- sd(xbar2)
xb3 <- sd(xbar3)

xb1 <- mean(xbar1)
xb2 <- mean(xbar2)
xb3 <- mean(xbar3)

xb1
xb2
xb3

ggplot(data, aes(x = value, fill = L1)) +
  geom_density(alpha = .70) +
  theme_minimal() +
  theme(plot.title = element_text(size = 8, face = "bold")) +
  theme(axis.title = element_text(size = 8, face = "bold")) +
  ggtitle("Brown (2021, Figure 8-3): Increasing Observations Increases Normality") +
  annotate(
    "text",
    x = 95,
    y = .15,
    label =
      "5 Observations per Draw",
    col = "#bf0000"
  ) +
  annotate(
    "text",
    x = 95,
    y = .175,
    label =
      "10 Observations per Draw",
    col = "#008b00"
  ) +
  annotate(
    "text",
    x = 95,
    y = .20,
    label =
      "100 Observations per Draw",
    col = "#0000ff"
  ) +
  theme(legend.position = "none") +
  xlab("Mean of Sample Means") +
  ylab("Density")

