% Insufficient nuisance parameter control resulting from a confusion of *practical* and *statistical* significance
% Jona Sassenhagen and Phillip M. Alday
% Summer and Fall 2013

# Abstract
Out of those published in the last 3 years in *B&L*, in at least 85 articles, statistical tests are used to test nuisance parameters in a meaningless and dangerous manner.
Specifically, completely known populations (such as word length of preselected, closed stimulus lists) are subjected to parameter estimation tests such as the *t*-test; thus, tests in principle set up to *estimate* a population parameter based on values sampled under error are used on an exhaustively and error-free *measured* quantity that did not have to be estimated since it is precisely known.  
Such usage of inference tests indicates that researchers use them to quantify the practical relevance, or (common-language) significance, of a finding via *p*-value calculation - a crass, although common and understandable, misunderstanding.
We present survey results of the prevalence and simulations of the implications of this problem.
Researchers, including editors, reviewers and authors, must go beyond ritualistic statistics.

# Introduction
The mistake we addressing here is using inference tests for a qualitative purpose.
Suppose the authors of this manuscript wish to learn who amongst us is able to eat the most. 
Over 5 days, we conduct 10 experiments where we attempt to eat as many bread rolls as possible. 
A repeated-measures one-way ANOVA of the number of rolls eaten per day, with the factor AUTHOR (levels: first author, second author) results in a 'significant $p$-value'. We conclude that the author who ate the most bread is likely able to eat more than the other (because if we all had equal capacity, finding such a large discrepancy in consumed bread rolls would be rare). 
This endeavour may be silly (and unhealthy), but statistically, it is not fully unsound.  

Now, we wish to know which of us has the largest feet.
Consequently, we measure our feet; whoever provides the largest value has the biggest feet.
We subject these measures (40, 40 and 52, 52) to another repeated-measures ANOVA. According to the results of the ANOVA, we can not reject the hypothesis that our feet are of equal size. In the future, should we assume that if a shoe fits one of us, it will also fit the other? Surely not. But if a *t*-test on the word length of our stimulus list is  not significant, should we conclude that word length will not influence our results?

Investigating multiple volumes of *Brain & Language* (see below), we have find that in many articles, researchers wrongly apply inferential statistics where they are neither licensed nor meaningful. 
Specifically, we find that when aiming to control for possible cofounds resulting from undesired non-equivalences in stimulus materials or subject properties, researchers often apply inferential tests where this procedure is meaningless. Moreover, they misrepresent these tests: they understand a *statistically* significant difference to imply an *important* or *large* difference, and they conversely interpret the absence of a statistically significant difference to imply a small or unimportant difference.

Consider a real example (published under one of our names):

> critical stimuli did not differ in frequency, F(2,237) = 1.43, p > .24, or word length, F(2,237) = 1.70, p>.18.

Researchers often perform tests of a similar sort, such as comparing the length of two fixed lists of words, those making up condition one and those in condition two, using a *t*-test, i.e. estimating a known value.
Often, researchers further claim that stimuli were “matched”/equal/equivalent regarding such parameters based on the non-significant result of such inferential tests (as we did in the example).
Editors and reviewers often do not disallow such behavior.
The same mistake occurs when two randomly assigned participant groups are compared in aspects that are not generalized beyond the group, e.g. age or lesion extent as covariates, using statistical inference.
If researchers wish to investigate if populations assigned based on one value, such as diagnosis, differ on another, such as age, statistical inference of the second parameter is meaningful. If researchers test randomly assigned subjects to different treatments, and wish to establish if (often precisely measured) nuisance parameters such as age or reading span confound the results, inference of group differences in these nuisance parameters is meaningless (see Table 1 for further examples).

------------------------------------------------------------
Inference meaningful		Inference not meaningful
---------------------------	--------------------------------	
Length, F0, amplitude, ...	Length, F0, amplitude, ...
of utterances in speech		of utterances in preselected
production experiment		stimuli for listening study

VBM estimate of lesion		VBM estimate of lesion
extent of subjects chosen	extent of subjects randomly
by criterion under test,	assigned to groups and subjected
such as clinical diagnosis	to experimental treatment

Subject's reaction times 	Memory span, age, ... of 
or accuracies to			subjects randomly assigned 
specific stimuli			to groups

Word relatedness ratings 	Grammatical function or animacy 
from experimental pre-		of stimulus words preselected
test of stimulus material 	by experimenter
------------------------------------------------------------
Table 1: Examples of meaningful and meaningless inference

We wish not to single out and ridicule other researchers, especially given our own previous failings, but show that this problem is common, even in high-quality journals like *Brain & Language*, and address the underlying misunderstandings.
In the following, we discuss the appropriate interpretation of such tests, attempt to explain what they are (wrongly) used for instead, present alternatives, present a computer simulation of the possible false inferences resulting from these practices, and show how prevalent such mistakes are by demonstrating their proportion in past issues of *B&L*.

# When all you have is a hammer: Statistical rituals and beyond in nuisance parameter control
It has been shown repeatedly that researchers misunderstand statistical concepts such as the meaning of *p*-values [@Haller:2002vo; @Lecoutre:2003vz; @Oakes:1986tn; @Falk:1995vc], showing that many essential statistical concepts are counterintuitive. This leads to ritualistic [@Gigerenzer2004] application of these concepts.

## Inference versus description
Descriptive statistics include values characterizing the sample at hand, such as sample size, sample variance, and non-standardized (raw means) or standardized (Cohen's *d*) effect sizes. 
Inferential statistics *estimate* the *population parameters*, the "true" numbers corresponding to such values beyond the sample.
Sampling is used because it is usually impractical or impossible to measure an entire population, and is usually incomplete and imprecise.
Inference estimates population parameters under sampling error. 
Consequently, exhaustive and error-free sampling does not require, license or benefit from inferential tests.

Essentially, what may be measured without error in the current sample is descriptive, including correlation and regression coefficients, mean differences, and means. 
Inferential procedures include the calculation of *p*-values and possibly matching them to an alpha level, confidence intervals of non-standardized or standardized effect sizes, or calculating Bayes Factors.
If we want to know which author ate the most bread rolls, we would use descriptive measures. 
Only when generalizing beyond the sample, e.g. when we want to know which author will likely eat more bread rolls in the future, is the use of inferential measures meaningful. 

Inferential statistics are necessarily imprecise in a technical sense: They are subject to random error and thus lack *precision*.

Contrasting two superficially similar scenarios:
+ Matching two lists of experimental stimuli on word length.
+ Matching two lists of experimental stimuli on affect.

The latter requires ratings, sampled under (unavoidable) error. Repeating the measurement as precisely as possible, different (though hopefully similar) values would result (because different individuals are sampled and individuals vary over time). Inferential tests are conducted to infer the population parameter after sampling under error, as a best guess at the result of exhaustive sampling with error-free instruments.
In contrast, when preparing stimulus lists, most student assistants can usually be trusted to correctly count letters (and syllables, word frequency in a text, and classify words by word class without error, and subjects can be trusted to accurately provide their age), so repeating the first scenario will result in identical values. 
For many stimulus parameters, there is no random (sampling) error, because the entire population is known and its parameters can be measured directly, without error.
If stimuli that *might* have been presented, but haven't, are irrelevant, in contrast to the finite sample that *was* presented, inference of population parameters of stimulus aspects is pointless.

Inferential tests also do not inform about the question researchers are generally interested in - are the stimuli equivalent?
Instead, they present: how surprised would one be had they assumed the population parameter is exactly 0? Inferential tests do not test research hypotheses and do not establish *practical* significance, they test numerical hypotheses (parameters) and establish *statistical* significance.

We assume most published researchers are familiar with these statistical basics. Why then do many researchers apply inferential tests for known quantities? We are convinced by the arguments made by Gigerenzer [-@Gigerenzer2004] that in the human and social sciences, application of statistics is often ritualistic. E.g., ANOVA is not used because it quantifies the ratio of between- to within-variance, but because it is the tool we have learned must be applied for categorical predictors and gradient outcomes; the *p*-value is not consulted because we are interested in the probability of obtaining a test statistic as or more extreme than the one we have obtained if the population parameter was a specific value, such as 0, but because we know *p*<0.05 means the result is noteworthy, important, *significant*. 

In brain and behavioral sciences, most inferential statistics takes the form of hypothesis tests such as the two-sample *t*-test or the ANOVA.
Inspired by Fisher [@Gigerenzer2004], null hypothesis significance testing begins with a null hypothesis where

>H~0~ is the hypothesis under test.

While any value can be tested, such as the value 100 (as the null hypothesis for the IQ of a population), most null hypotheses in brain and behavioral sciences take the form of a point-null hypothesis where μ is the population parameter and H~0~: μ = 0.
H~0~ is a precise numeric postulate about a single value for the parameter in question, such as

>H~0~: the population parameter equals $x$.

It is not a statement of the form “there is no meaningful difference between the two conditions”. It is this hypothesis of the parameter having a precise value that is under test, and any derived conclusions refer only to this value.

Many inferential tests provide a *p*-value for the statement $P(D|H\_0_)$ so that

>*p* is the probability (P) of the data (D) conditional on the null (H~0~).

This means that *p* informs us how unlikely or weird [@Christensen:2005fp] the present sample parameter seems for those who assume H~0~ to be true - for those assuming that the population parameter is exactly $x$ (e.g., 0).
Such tests are very coarse. At best, they present the confidence with which one may declare the parameter to be not exactly zero. For parameters of interest, such as the length of words in a stimulus set, mean and standard deviation are usually much more informative than *p*; *p* allows a vague estimation of one value in a vaguely specified set of words, the mean *is* this relevant value in the relevant set.

## Dangers of inappropriate (inferential) control of nuisance parameters
Problems in inferring population parameters to control nuisance covariates go beyond the philosophical inadmissibility of these tests.

Specifically regarding the control of (stimulus or subject group) nuisance parameters, where researchers hope for equivalence, the false rejection rate Alpha and power, the detection rate (from the Neyman-Pearson framework in principle incompatible with Fisherian testing), are usually set up the wrong way to test for equivalence for situations where not detecting non-equivalence would be problematic. The error rate of rejecting H~0~ when it is true, of detecting non-equivalence, is deliberately chosen to be low (at 1/20). Commonly, the hypothesis of equivalence is not rejected if the probability of the current data under the null is as low as 1/2, 1/10, or even 1/19. Alpha and beta are supposed to be set up depending on the relative cost of missing true effects versus detecting false ones. The typical value for Alpha, 5%, is conservative regarding overdetection, and very rarely is any thought given to underdetection. Conservative Alpha levels make sense in a scenario of quality control, where long-run error rates need to be controlled, but not when trying to check for e.g. the possibility of presenting in one experiment stimuli that are non-equivalent in some problematic aspect; yet the same conservative alpha level is ritualistically chosen.
Consequently, even if differences are large, such as a data set corresponding to a test statistic resulting less than 1 out of 8 times when sampling from equivalent populations, ie., two quite imbalanced lists, tests will often not reject a H~0~ of equivalence at the 5% level. (On the other hand, with sufficiently high power, e.g. large samples and/or low variance, even marginal differences result in an effect. For example, comparing word length between one list of 200 words of length 5 and one of 195 words of length 5 and 5 of length 6 gives *p* < 0.03.)

With conservative alpha levels and low power, an insignificant test is uninformative. The power of tests, the probability of correctly rejecting a null hypothesis, is worryingly low across the brain and behavioral sciences [@Button:2013dz; @Yarkoni:2009ub], and unless one checks the power of a test before conducting it, failed tests say precisely nothing. Yet, often researchers "accept the null" - concluding from a nonsignificant test that e.g. stimulus sets are equivalent regarding the tested parameter. As tests fail due to reasons such as high variance, low sampling size or low (conservative) Alpha levels, this is a fallacy, as many inequalities in e.g. stimulus lists remain undetected. Even when a test does not reject a hypothesis of population equivalence, if stimuli do differ regarding the parameter and the parameter is correlated with primary experimental outcomes, experimental effects may appear completely dependent on stimulus inequalities an inferential test failed to detect. Below, we conduct a simulation study to test the possible dangers of inappropriately "accepting the null".

Methods often recommended as solutions to common problems of the null ritual, such as interval estimates [@Cumming:2005hy; @Christensen:2005fp; @Kruschke:2013jy; @Tryon:2008hg; @Lesaffre:2001je; @Lindquist:2013gj] or Bayesian statistics [@Kruschke:2013jy; @Dienes:2011cd; @Wagenmakers:2008ti], are not helpful in the context of describing known quantities, since they too are inferential. Both CIs and Bayes Factors estimate possible values for the parameter of the (irrelevant) population.

## Alternatives
There are multiple ways of dealing with nuisance stimulus parameters. First, while *p* values provide much less information than descriptive statistics, these in turn may be relevant for many purposes; often, knowing that two stimulus lists or subject groups have certain subjectively similar means and standard deviations regarding critical parameters may be sufficient. Instead of *p* values, other descriptive statistics, such as quartiles or standardised measures of effect size effect sizes [@Kline:2004vb][@Cohen:1994uk][@Hentschke2011][@Wilkinson:1999wd], may be presented.

A less subjective method is provided by multilevel/mixed models, or even regular multiple regression. Multilevel/mixed regression allows the simultaneous estimation of subject and item effects on multiple levels. In effect, this simply means treating the nuisance parameter as an independent variable, not a dependent variable. The impact of nuisance parameters such as each item's length, or each subject's age, may be estimated simultaneously with the predictors the researcher is primarily interested in, such as experimental conditions. This allows an estimate of fixed effects of interest in isolation of those item effects specified for the test. For example, if an experimental condition is found to result in an effect by a model including the factors stimulus length and subject age, we have some confidence of an independent effect not dependent on accidental properties of the stimulus set or the test subjects.
Tutorials for this somewhat involved method are presented by [!!!Gelman and Bates].

# Simulation: Experimental effects resulting purely from nondetected nuisance parameter inequalities correlated with outcomes
## Simulation Method
We simulated the cost/benefit ratio of using inferential tests of stimulus parameters to control for the influence of nuisance parameters on primary investigations. Using Python, we simulated the result of testing two groups of people differing in mean "ages", and different degrees to which the outcome variable was correlated with their "age". Subjects in both groups were drawn from the same distribution (so in our simulations, the null hypothesis was true), but for one, the mean level of the nuisance variable was increased. By adding fractions of the simulated nuisance parameter to each participant (e.g., by letting each subject's "reaction time" increase to a degree correlated with their "age"), four different degrees to which stimulus parameters and experimental outcomes are correlated were tested: 20, 9, 4 and 1% variance of the simulated outcome was explained by the stimulus parameter.  
We first compared the two groups regarding the value of the nuisance parameter ("age") using a *t*-test. We then estimated the impact of the nuisance parameter by comparing the data without the addition of this value, to that resulting from the addition of this value, by contrasting the two contaminated groups with each other, and the uncontaminated groups with each other, using a *t*-test.  
Those simulated experiments where these tests did not disagree regarding the statistical significance of the group differences were counted as "irrelevant". Amongst the "relevant" results (where the addition of the nuisance parameter effect on the primary outcome caused both tests to disagree regarding the significance), we counted 1. the number of tests where the nuisance test (the meaningless inference) did not detect a difference regarding the nuisance parameter, but there was a "false positive", with the contaminated data leading to a significant result, but not the uncontaminated data ("Nondetected surplus positives"); 2. the number of tests where the contaminated data led to a positive test and the uncontaminated data didn't, and the nuisance parameter test did indicate a statistically significant difference ("Detected surplus positives"); and those where the uncontaminated data resulted in an effect, but the contaminated data didn't, and there was a nonsignificant nuisance comparison test ("Nondetected surplus negative").

## Simulation Result
When 20% of the variance in the primary outcome was explained by the nuisance variable, we observed one false positive (a significant primary test where no difference in the nuisance levels was detected) for every two detected false positives (50.6% nondetected surplus positives). We also observed a similar number of false negatives.
When 1% of the variance was explained by the nuisance parameter, we observed two nondetected false positives for every three detected false positives (66% nondetected surplus positives), and a similar number of false negatives. In total, we observed false positive rates inflated by up to 30%.
The results are presented graphically in Figure 1.
We conclude that the ratio of problematic cofounds by nuisance parameters is extremely badly controlled by treating nuisance parameters as dependent variables.

# Survey: Prevalence of the problem in B&L
Instances of the error can be easily found not only in recent, but also in older publications, such as this example from the 1980s:

> the two prime categories were equivalent in text frequency ([...] et al., 1971), and in length (both t's < 1.1

Here, the authors commit the "double sin" of both estimating a known quantity, and deducing equivalence (acceptance of the null) from a failed test - in this case, a test that leads the authors to accept the null hypothesis.
To estimate how common the problem is in neurolinguistics, a high-quality neurolinguistic journal, *Brain & Language*, was investigated. 

## Survey Methods
The analysis was restricted to current volumes. 
For all articles published by *B&L* from 2011 to the 3rd issue of 2013, three raters (not blinded to the purpose of the experiment) investigated all published experimental papers (excluding reviews, simulation studies, editorials etc.). 
For each experiment reported in a study, the stimulus/materials sections were investigated for descriptive and inferential statistics derived from populations that were exhaustively sampled without error. 
If a descriptive and/or inferential statistic (such as mean and standard deviation) were reported, the study was coded as one where the researchers were interested in a known quantity, otherwise it was discarded. 
If an inferential statistic (such as a *p*-value) was reported, the study was coded as one where researchers answered that interest with an erroneous parameter estimate, otherwise as one where researchers did not commit the error.
If a statement of the form that groups were thought equivalent regarding the parameter was made, such as claims that they were “matched”, “equal” or “did not differ”, and this statement was backed up by a *p*-value greater than .05, the study was coded as accepting the null.
In cases of rater disagreement, the majority vote was registered.
Representative statements from every study committing an error are presented in the appendix. 

## Survey Results
In total, 86 articles where found where researchers reported known quantities in their stimulus/materials section, and 58 (**67%**) of these reported inferential statistics of these known values. Of these, 47 (**81%**) "accepted" the null hypothesis (i.e., concluded that stimuli or subjects were matched following a nonsignificant test). We conclude that in a majority of those cases where researchers published in *B&L* are concerned about nuisance parameters of experimental stimuli, they conduct meaningless tests and misinterpret the results of these tests in a potentially dangerous manner.

# Conclusion
Attempting to control confounding of experimental outcomes by statistical inference directly on the values of potential confounds is philosophically unjustified, ineffective, and yet extremely common. If one is worried about participant's age or stimulus length influencing the outcome in question, testing participant's age or stimulus length using inferential tests is pointless. We hope these observations contribute to a less ritualistic statistical practice in the brain and behavioral sciences.
Beyond our philosophical and mathematical discussion, we support these assertions with a survey study observing a high rate of improper methods in recent issues of *B&L*, and with a simulation study showing extremely high cost/benefit ratios of these tests. We propose concrete examples of how to better deal with potential confounds: treating them as IVs, not DVs, and including them as covariates in multilevel regression analyses. However, these should not simply result in a replacement of the current ritual with a new ritual. Statistical analysis requires attention and understanding to be meaningful.

# References