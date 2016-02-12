---
title: "A common misapplication of statistical inference: nuisance parameter control with null-hypothesis rejection tests"
author: Jona Sassenhagen; Phillip Alday
date: February 2016
---

# Abstract
Much experimental research on behavior and cognition rests on stimulus or subject selection where not all parameters can be fully controlled, even when attempting strict matching.
For example, when contrasting patients to controls, factors such as intelligence or socioeconomic status are often correlated with patient status; when presenting word stimuli, factors such as word frequency are often correlated with primary variables of interest.
One procedure very commonly employed to control for such nuisance parameter effects is conducting inferential tests on confounding stimulus or subject characteristics.
For example, if word length is not significantly different for two stimulus sets, they are considered as matched for word length.
Such a test has extremely high failure rates and is conceptually misguided.
We show this procedure to be misguided both pragmatically and philosophically, present a survey showing its high prevalence, and briefly discuss an alternative in the form of regression including nuisance parameters.

# Introduction
A common problem in brain and behavioral research, where the experimenter cannot freely determine every stimulus and participant parameter, is the control of confounding/nuisance parameters.
This is especially common in studies of language.
Typically, stimuli cannot be constructed out of whole cloth, but have to be chosen from existing words (which differ in many parameters); stimuli are processed by subjects in the context of a rich vocabulary; and subject populations have usually been exposed to very diverse environments and events in their acquisition of language.
The basic question researchers are faced with is then to prevent reporting e.g. an effect of word length, or bilingualism, when the effect truly stems from differences in word frequency, or socioeconomic status, which may be highly correlated with the parameters of interest.
A very prevalent method we find in the literature highlights common statistical misconceptions and fails to perform the necessary control.

## NHST and nuisance control
Often, researchers will attempt to demonstrate that stimuli are selected so as to concentrate their differences on the parameter of interest, i.e. reduce confounds, by conducting null-hypothesis testing such as $t$-tests or ANOVA on the potentially confounding parameter in addition or even instead of showing descriptive statistics in the form of measures of location and scale.
The underlying intuition is that these tests establish if two conditions differ in a given parameter and serve as proof that the conditions are "equal" on that parameter.

In practice, we find insignificant tests are used as a necessary (and sometimes even sufficient) condition for accepting a stimulus set as "controlled".
This approach fails dramatically on multiple levels.

* Philosophically, these tests are inferential tests being performed on closed populations and not random samples of larger populations. Statistical testing attempts to make inferences about the larger population based on randomly selected samples, but here the "samples" are not taken randomly and we are not interested in a population.
For example, in a study on the effects of animacy in language processing, we do not care whether the class of animate nouns in the language is on average more frequent than the class of animate nouns.
Instead, we care whether the selection of animate nouns *in our stimuli* are on average more frequent than the selection of inanimate nouns *in our stimuli*.
But inferential tests answer the former question, not the latter.   

* Pragmatically, this procedure does not test a hypothesis of interest.
This procedure tests the null hypothesis of "the populations that these stimuli were sampled from do not differ in this feature", but what we are actually interested in is "the differences in this feature between conditions is not responsible for any observed effects".
In other words (assuming that it is valid to perform tests on closed, constructed populations), this procedure tests whether the conditions differ in a certain respect, but not whether that difference actually has any meaningful influence on the result.  

* Additionally, these tests carry all the usual problems of Null Hypothesis Significance Testing (cf. **REF**), including its inability to accept the null hypothesis directly.
This means that even if the conditions do not differ significantly, we cannot accept the hypothesis that they do not differ; we can only say that there is not evidence to exclude this hypothesis (which, again, is not the one we are actually interested in). 

In other words, these tests are incapable of actually informing us about influence of potential confounds, but may however give researchers a false sense of security. 
A simple solution is to examine the descriptive measures of location and scale (e.g. mean and variance[^bessel]) and see if the stimuli groups are "similar enough".
For perceptual experiments, there may even be established discrimination thresholds below which the differences are considered indistinguishable. 
The preferred solution is directly examining whether these potential confounds have an influence on the results. 
This is accomplished by including these nuisance parameters in the statistical model and is readily implemented with increasingly popular multilevel regression models [@gelman.hill:2006;@fox:2016], whether Bayesian or frequentist.

[^bessel]: We note that the correct variance calculation here would be the true population variance (with $n$ in the denominator) and not the usual Bessel's corrected estimate (with $n-1$ in the denominator) because we are not estimating the variance of a population from a sample, but rather calculating the variance of a closed, fully sampled population.
Practically, as long as we are consistent between groups, it makes no difference.
(The mean does not have this problem as the usual, maximum-likelihood estimator for the population mean is simply the sample mean, i.e. we use the same formula both for estimating the population mean from a sample and for computing the population mean.)

<!-- While this is a nice rant against NHST, I'm not sure it actually contributes anything to the ideas presented in the bullet points. I'm thinking this whole thing might be more widely read if we keep it short and knackig. Moreoever, a lot of the content here assumes that these tests are valid and testing the hypothesis in question, but the whole point is that neither assumption is true!

A fundamental pragmatic problem stems from the set-up of null hypothesis significance tests (NHST).>--
Such tests can only ever reject hypotheses, and the parameters with which they are typically performed (e.g., alpha, the probability  of rejecting true hypotheses, is set to 5%) entail conservative tests, that is, tests which fail to reject many false hypotheses so as to not falsely reject correct hypotheses.
Conversely, if alpha is set to such a value, beta (the probability of failing to reject false hypotheses) practically becomes low (because it is the one statistical parameter, out of effect size, sample size, alpha and beta, that is left to float) for linguistics, psychology and neuroscience [e.g. @buttonioannidismokrysz2013a]; for typical effect and sample sizes, it is rarely above 50%, meaning that truly false nulls are rejected at a rate no better than if researchers were to flip a coin.
Thus, nothing is gained from not rejecting a hypothesis in this context - not rejecting the hypothesis that the difference in word length is zero is of very little relevance as the chance of detecting this difference, even where it exists, is low in typical samples, and strongly depends on sample size.

If a researcher wishes to compare two sets of stimuli on a parameter, such as word length, the sample size results from the number of words (and further depends on e.g. pairing), and alpha is typically set to .05.
If a researcher wishes to be able to detect large deviations from equal word length for both groups with for example a $t$-test, the power of the test - that is, the chance of the test to detect a real group difference - depends both on what "large" means, and the sample size.
Large samples (i.e., a stimulus set of 2000 words) easily reject the hypothesis even when the difference is small, but small samples (i.e. 20 pairs of supposedly well-controlled words) reject even small differences only rarely.
A difference of exactly the same magnitude is detected much more readily in a large than in a small sample - and for small stimulus sets, this detection rate is extremely poor.

Furthermore, the hypothesis tested in this process is completely irrelevant. $p$ values in NHST reflect the probability of observing evidence as or more extreme as the one given, assuming a given true effect.
This "true effect" is a statement about a population, evidence a statement about the sample.
For example, in an fMRI study with n = 20, observing an effect of 3 standard deviations in magnitude in the sample can reasonably give researchers some confidence in the assumption that within the assumed, but unobserved population, there is also some non-zero effect of the same sign.
Thus, $p$ values in NHST allow researchers to infer from known quantities - the sample values - to unknown quantities - the population values.
However, this framework is incompatible with the aims of controlling stimulus parameters, where it is precisely the sample, not the population, that is of interest.

We assume when a researcher performs a $t$-test on the word length of his stimuli, he hopes to answer a question such as "is there a *meaningful difference* in the length of the stimuli?".
However, the question actually investigated is much more subtle, and mostly orthogonal to the question at hand: "given the known difference in samples, is there no difference in the population from which was sampled?".
For the context of word stimuli, this can be rephrased as "is there a bias in the procedure that selected the members of the stimulus classes so that it somehow selects words of different lengths?".
While detecting a biased mechanism for stimulus selection or generation can be interesting, it is inconsequential for the analysis of an already selected or generated set of stimuli; the rare occurrence of a balanced sample resulting from a biased sampler would be unproblematic, whereas an unbalanced sample resulting from an unbiased sampler would be problematic.

This inference of the population value is performed based on effect (and sample) size, and effect size size is close to the value of interest - "meaningful difference".
However, the *true* difference is already known, and $p$ values say nothing about to which degree this difference within the sample is meaningful - only to which degree it is generalizable to the (uninteresting) population.
For the purpose of controlling confounding, no information in the $p$ value goes beyond the values it is based on - typically, one of central tendency and one of spread.
Thus, the inferential (population-focused) procedure adds nothing to the descriptive (sample-focused) procedure.
It may however give researchers a false sense of security.
-->

## Randomization checks in clinical research
In the context of baseline differences between treatment and control groups in clinical trials, a similar debate has been waged [e.g. @senn:1994sm].
The procedure is called "randomization check" as it refers to checking if assignment of subjects to treatments has truly been performed randomly.
This is philosophically somewhat less misguided, but has also been determined to be pragmatically pointless.
In truly experimental research such as clinical trials, the effect of treatment is the variable of interest, and true randomization can be performed with regards to the multitude of other factors that might influence results.
But in the case of non-medical, quasi-experimental research (i.e. research where full control is not possible and thus confounds are unavoidable), stimuli or subjects are typically *known* to not have been selected randomly, but by specific criteria (e.g., animate vs. inanimate nouns, or patients with vs. without a particular lesion[^clinic]).
That is, in the case of medical studies with randomization checks, experimental validity is achieved by selecting subjects from a given population and randomizing their assignment to treatment.
In our quasi-experimental case, stimuli are constructed so as to differ on one parameter which we highly expect to be correlated with other parameters, e.g. word frequency and word length, and the worry of researchers is not if assignment was random (in fact, it is known to not have been random), but if stimuli differ systematically on variables expected to impact the dependent variable of interest.
<!-- I'm not sure what the next two sentences contribute to our point. I think you could probably leave them out. After all, we're not discussing the problems with randomization checks in clinical work, but rather stating there is parallel Problematik in clinical work. -->
Notably, randomization checks have been repeatedly shown to fail at identifying covariates that should be included into multiple regression models [@imai.king.etal:2008jrss].
Nonetheless, the clinical trial literature provides important considerations for experimental design choices e.g. by discussing the proper way of blocking and matching [@imai.king.etal:2008jrss].


[^clinic]: One could pose the question of whether or not the patients in clinical trials have been selected randomly -- after all, a patient must have a particular condition in order to take part in a particular trial.
The key factor here is that the population of interest in clinical trials are "patients with condition X" and thus we often do not care if condition X correlates with condition Y because that correlation only makes sense in the context of a larger population that we are not interested in.
When comparing between subgroups of a larger population, e.g. patients with or without a lesion in the larger population of speakers of a given language, we do care if condition X correlates with condition Y (e.g. having a lesion correlates with age) because these form systematic differences between subgroups within a population.
<!-- I'm not sure I did a good job explaining this-->   

<!-- "quasi-experimental" seems provocative. We are doing experimental research, but the issue is that confounds are very hard to eliminate in complex systems with unbalanced covariances like language. 
But the cool thing about language is that we can often measure these confounds, unlike many fields where they simply fall into the category of "noise".
-->

We assume that these issues in quasi-experimental research has been discussed some of the better statistical or ecological textbooks, but are not aware of similar discussions in the psychological, linguistic or neurocognitive literature.


# Prevalence
We performed a literature survey of neurolinguistic studies to estimate the prevalence of inferential tests of nuisance parameters.

## Qualitative impressions
Instances of the error can be easily found not only in recent, but also in older publications, such as this example from the 1980s:

> the two prime categories were equivalent in text frequency ([...] et al., 1971), and in length (both $t$'s < 1.1

Here, the authors demonstrate in one sentence many of the fallacies underlying this procedure: both estimating a known quantity, and deducing equivalence (acceptance of the null) from a failed test (in this case, a test that leads the authors to accept the null hypothesis).
To estimate how common the problem is in neurolinguistics, a high-quality neurolinguistic journal, *Brain & Language*, was investigated.

## Quantitative prevalence of the problem in recent issues of *Brain & Language*
In total, 86 articles where found where researchers reported known quantities in their stimulus/materials section, and 58 (**67%**) of these reported inferential statistics of these known values.
Of these, 47 (**81%**) "accepted" the null hypothesis (i.e., implicitly assumed that stimuli or subjects were matched following a nonsignificant test).
We conclude that in a large fraction of those cases where researchers published in *B&L* are concerned about nuisance parameters of experimental stimuli, they conduct meaningless tests and misinterpret the results of these tests in a potentially dangerous manner.

# Discussion and recommendation
In sum, NHST control of nuisance parameters is prevalent and meaningless, based on a flawed application of statistics to an irrelevant hypothesis. 
Luckily, proper nuisance control (of known and measurable variables) is not complex, although it can require more effort and computer time.

Researchers should still use descriptive statistics to demonstrate the success of balancing, but beyond that $p$ values from statistical tests on the stimulus properties offer no reliable, objective guideline.
To directly and objectively estimate the influence of a set of stimuli on the dependent variables of interest, researchers should include stimulus properties in their statistical model for the data.
For traditional $t$-tests, ANOVAs and regression models, this corresponds to using multiple regression with the stimuli properties as additional nuisance parameters.
In multiple regression, all parameters are jointly estimated and the total variance is allocated over all parameters depending on their independent impact.
Thus, a condition effect estimated by a model also containing nuisance parameters corresponds to the effect of condition after having controlled for nuisance parameter influence.
(An additional advantage of regression models is that is possible to include continuous covariates thus avoiding issues with dichotomization. **do we need a ref here? I have one**)
Importantly, to prevent $p$ value fishing, the choice of selecting covariates to include must be made on principled grounds, and either a priori, or via unbiased model selection procedures.

Hierarchical/multilevel modeling [a.k.a mixed-effects modeling; see also @pinheirobates2000a;@gelman.hill:2006; @fox:2016] provides the necessary extension to the regression procedure for repeated-measures designs. 
Multilevel regression models have the additional advantage over regression of accounting for the combined variance of subjects and items in one model, which can 
significantly impact the pattern of observed effects [@clark1973a; @baayendavidsonbates2008a; @judd.westfall.etal:2012pp].

One problem in this context is that these stimulus confounds can be assumed to be correlated not only with one another and the dependent variables, but often also with the independent variables of interest (e.g., word frequency and word length correlate).
This leads to model collinearity -- the problem that models become hard to estimate and have biased variance estimates due to strongly correlated parameters.
As such, we recommend that researchers check the correlation of model parameters; popular software for mixed-effects models such as lme4 automatically provides a summary of correlation between fixed effects  [@bates.maechler.etal:2015].

The main technique for dealing with collinearity is one that researchers traditionally already employ: attempting to balance stimulus/subject selection so that differences in nuisance parameters are minimised, e.g. via matching or blocking.
That is, matching should generally still be performed in addition to multivariate estimation.
However, often, they can not be entirely abolished, and significant correlations remain.
Even in these cases, multiple regression is still the preferred solution if the present collinearity is dealt with appropriately.

Two solutions that go beyond the scope of this article are regularization and residualization.
Regularization (whether frequentist or Bayesian) can be thought of building the additional assumption into the model that most parameter estimates should be small (close to zero) unless there is strong evidence otherwise. 
As such, estimates are shrunk towards zero and variables shrunk sufficiently close to zero can be thought of as not contributing towards the explanatory power of the model. 
In the case of highly correlated variables, one them will be shrunk towards zero as it contributes little towards the model beyond the other one.
Residualization refers to regressing two correlated variables against each other and using the residuals from this regression to replace one of the variables. 
As the residuals are by definition the variance not explained by the correlation, the new variable is not correlated with the remaining original variable.

Calculating such complex regression models will of course require more data, as power is lost with each additional parameter being estimated. 
We view this as a good thing because studies in the brain and behavioral sciences are chronically underpowered [@buttonioannidismokrysz2013a].

Thus, our recommendations for the control of nuisance parameters are:

* attempt to control stimulus parameters to a reasonable degree
* use descriptive, but not inferential statistics to guide stimulus selection
* add confounding parameters as covariates into the final data analysis process
* use high-powered samples

Each step in this list is (hopefully) uncontroversial and helpful, unlike null-hypothesis testing of stimulus balance.

# Acknowledgements
We thank Sarah Tune for helpful discussion and Tal Linzen for bringing to our attention the randomization check literature. This work was supported in part by the German Research Foundation (BO 2471/3-2) and by the ERC grant (....).

# References

