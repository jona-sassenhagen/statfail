# Basic Structure
Two groups / experimental levels are simulated, e.g. *control* and *manipulation*.
For each group, a confounding variable is simulated, e.g. *word frequency* in language experiments.
Each of the these simulated variables is sampled from a normal distribution, with the sample size given by the number of items.

For simplicity, we assume that the standard deviation is the same across groups.
The assumption of a uniform standard deviation is in line with the assumption of homogeneity of variance (homoskedacity, sphericity) present in many traditional statistical tests. 
Of course, as Rand Wilcox has pointed out on many occasions, this is a rather large assumption that may be violated in many interesting cases, but that is a discussion for another time.


# Simulation of effects
Effect sizes are generally given in the simulation as Cohen's $d$.
As we assume that the standard deviation $\sigma=1$ (see above), Cohen's $d$  reduces to the difference in means.

## Difference in outcome variable
For each of the two groups, an outcome variable is simulated following a normal distribution.
For the *control* group, this has mean $\mu=0$.
For the *manipulation* group, this has mean $\mu=d_\text{manipulation}$.
If you desire a negative effect of the manipulation, then you just need to set $d_\text{manipulation} < 0$

## Difference in feature variable
For each of the two groups, a feature variable is simulated following a normal distribution.
For the *control* group, this has mean $\mu=0$.
For the *manipulation* group, this has mean $\mu=d_\text{feature}$.
If you desire a negative effect of the manipulation, then you just need to set $d_\text{feature} < 0$

The feature variable is **not** the effect of the feature, but rather the difference in the raw measured feature. 
For example, the difference in word frequency between stimuli groups is not equal to the difference in reaction time, EEG response, etc. between stimuli groups in language experiments. For that we, need the strength of the correlation between the difference in feature variable and the difference in outcome variable.

## Impact of confounding feature
The actual impact of the confounding feature is determined by the difference in the feature variable between groups and the correlation between that difference and the difference in the outcome variable. 
(This is one of the reasons for assuming a uniform standard deviation $\sigma=1$ -- everything is on the same scale and there is thus no need to adjust the scaling.)
For this, we start with a "seed" vector (the feature variable for a given group) and a randomly "noise" vector (unit scale centered at 0) and [use the geometric interpretation of correlation to compute a new vector](http://stats.stackexchange.com/a/15040/26743) that has the necessary correlation with the seed vector.
The output is thus the confounding effect of the feature on the outcome variable.
This confounding effect is added to the outcome variable to produce the confounded outcome. 

In the case of zero correlation, this procedure essentially just adds noise to the outcome variable, i.e. the same thing as controlling for the wrong variable in an experimental setting.
In the case of perfect correlation, this procedure just uses the feature variable vector as the confound (multiplied by -1 in the case of negative correlation), which is an idealized case of perfect correlation that avoids some numerical issues.

# Statistical testing
Statistical testing is performed via 
1. $t$-tests
  a. either two-tailed independent (without the Welsh correction, as the true variance of each group is equal)  or
  b. Wald tests on the coefficients in a linear model
2. $F$-tests in an ANOVA procedure

The presentation is done in such a way to be similar to typical presentations in the literature, e.g. $t$-test for the comparison of features across two groups, ANOVA for the effect of the experimental manipulation, and an $F$-test for overall fit in the continuous linear regression for the effect of feature.
In the latter two cases, the actual computation is performed via an explicit call to R's `lm()` function for fitting a linear model, and the  estimates and Wald $t$-tests for the coefficients are available via tool-tip.

For the multiple regression, the full table of coefficients as well as an ANOVA table are presented.

For the feature-based testing, the dependent variable is the feature variable. 
For all other tests and models, the dependent variable is the confounded outcome, i.e. the outcome variable summed with the confounding feature as derived from the feature variable.

# Graphics
Graphics are done via the `ggplot2` interface to [Plot.ly](https://plot.ly/), which allows for more dynamic interaction than the static output from `ggplot2` itself.
The regression lines and associated confidence intervals are, for simplicity, calculated (again) by `ggplot2` internally with `method=lm`, i.e. they should be exactly equivalent to the linear models used in the statistics. 
This is slightly inefficient computationally, but much allows for much greater code simplicity, especially given that the average user is not expected to view the graphical output from several hundred iterations.

There is one slight "lie" here -- for the multiple regression, `ggplot2` actually calculates separate linear models for each of the groups. 
This means that the plot does may have slightly biased estimates due to the reduction in pooling. 
Nonetheless, this should give a decent overall graphical presentation. 
The main effect for group is evident as the distance between lines, while the main effect for feature is evident as the slope of the individual lines.
Interaction effects are visible as the difference in slope between the lines. 
In other words, an interaction is present when the lines are **not** parallel.
