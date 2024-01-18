# From the handout --------------------------------------------------------

library(tidyverse)

# Loading inspecting data -------------------------------------------------

language_exams <- read.table(
  'language_exams_data.csv',
  header = T,
  row.names = 1,
  sep = ","
)

View(language_exams)

summary(language_exams)


# Checking for normailty --------------------------------------------------


#### Visual inspection

qq_exam_1 <- language_exams$lang_exam_1

qqnorm(qq_exam_1)
qqline(qq_exam_1)

sample_80 <- rnorm(80)
qqnorm(sample_80)
qqline(sample_80)

sample_20 <- rnorm(20)
qqnorm(sample_20)
qqline(sample_20)

sample_50 <- rnorm(50)
qqnorm(sample_50)
qqline(sample_50)

sample_200 <- rnorm(200)
qqnorm(sample_200)
qqline(sample_200)

#### Statistical tests for normality

shapiro.test(language_exams$lang_exam_2)

normality_data = subset(language_exams,
                        select = c(lang_exam_1, lang_exam_2, lang_exam_3, maths_exam))

apply(normality_data, 2, shapiro.test)

# Significance testing for continuous data: Testing variances and  --------

exam_2.ug <-
  subset(language_exams, study_level == 'Undergrad')$lang_exam_2

exam_2.pg <-
  subset(language_exams, study_level == 'Postgrad')$lang_exam_2

var(exam_2.ug)

var(exam_2.pg)

var(exam_2.ug) / var(exam_2.pg)

var_test <- var.test(lang_exam_2 ~ study_level, data = language_exams)

var_test

bart_test <-
  bartlett.test(lang_exam_2 ~ first_lang, data = language_exams)

bart_test


# Significance testing for continuous data: Tests for two independ --------


exam_2.ug <-
  subset(language_exams, study_level == 'Undergrad')$lang_exam_2

exam_2.pg <-
  subset(language_exams, study_level == 'Postgrad')$lang_exam_2

#### Standard t-test

t.test(exam_2.ug, exam_2.pg, var.equal = T)

#### Welch t-test

t.test(exam_2.ug, exam_2.pg, var.equal = F)

#### Wilcoxon-Mann-Whitney test

wilcox.test(exam_2.ug, exam_2.pg, conf.int = 0.95)

# Significance testing for continuous data: Two paired groups -------------

#### Creating subsets

exam_1 <- subset(language_exams)$lang_exam_1

exam_2 <- subset(language_exams)$lang_exam_2

#### Paired t-test

t.test(exam_2, exam_1, paired = T)

#### Wilcoxon signed rank test

wilcox.test(
  exam_2,
  exam_1,
  paired = T,
  correct = F,
  conf.int = 0.95
)

#### Testing directional versus non-directional hypotheses

t.test(exam_2.ug,
       exam_2.pg,
       var.equal = T,
       alternative = "less")



# The perils of multiple testing ------------------------------------------

#### Type I error

set.seed(42) # set random number seed

t.test(rnorm(10), rnorm(10)) # output not shown

t.test(rnorm(10), rnorm(10)) # output not shown

t.test(rnorm(10), rnorm(10)) # output not shown

t.test(rnorm(10), rnorm(10)) # p < 0.05

#### Type II error

set.seed(42)

t.test(rnorm(10, mean = 1), rnorm(10, mean = 0))

t.test(rnorm(10, mean = 1), rnorm(10, mean = 0))

t.test(rnorm(10, mean = 1), rnorm(10, mean = 0))


# Significance testing for continuous data: Two or more groups ------------

#### Visualize our data

boxplot(
  maths_exam ~ first_lang,
  data = language_exams,
  xlab = "Native languages",
  ylab = "Maths scores",
  frame = FALSE,
  col = c("mistyrose", "turquoise", "darkseagreen")
)

install.packages('gplots')
library(gplots)


plotmeans(
  maths_exam ~ first_lang,
  data = language_exams,
  frame = FALSE,
  xlab = "Native languages",
  ylab = "Maths scores",
  main = "Mean Plot with 95% CI"
)

#### One-way ANOVA

result_aov <- aov(maths_exam ~ first_lang, data = language_exams)

summary(result_aov)

#### Multiple pairwise-comparison between the means of groups: Tukey’s HSD test

TukeyHSD(result_aov)

#### Checking the ANOVA assumptions: Normality

bart_all <-
  bartlett.test(maths_exam ~ first_lang, data = language_exams)

bart_all

#### One-way ANOVA with unequal variances

oneway.test(maths_exam ~ first_lang, data = language_exams)

#### Pairwise t-tests with no assumption of equal variances

pairwise.t.test(
  language_exams$maths_exam,
  language_exams$first_lang,
  p.adjust.method = "BH",
  pool.sd = FALSE
)

#### Non-parametric alternative to the one-way ANOVA test

kruskal.test(maths_exam ~ first_lang, data = language_exams)

#### Dunn post-hoc test

install.packages('FSA')
library(FSA)

dunn <- dunnTest(maths_exam ~ as.factor(first_lang),
                 data = language_exams,
                 method = "bonferroni")

head(dunn)




