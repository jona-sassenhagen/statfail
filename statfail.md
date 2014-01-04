% Many *Brain & Language* authors, editors and reviewers confuse significance and *statistical* significance
% Jona Sassenhagen and Phillip M. Alday
% Summer and Fall 2013

# Abstract
In (xx%) of articles of the most recent (XX) volumes of *B&L*, statistical tests were used in a way that strongly implies that many authors, editors and reviewers falsely understood *statistical* significance as absolute significance. 
Specifically, completely known populations (such as word length of preselected, closed stimulus lists) are subjected to parameter estimation tests such as the *t*-test; thus, tests *estimating* a population parameter based on a sample are used on an exhaustively *measured* quantity, a population parameter that did not have to be estimated since it is precisely known. 
Such usage of inference tests indicates that researchers use them to quantify the practical relevance, or (common-language) significance, of a finding via *p*-value calculation - a crass misunderstanding. 
Researchers, including editors, reviewers and authors, must deepen their understanding of statistics.


# Misuse of inferential statistics

## Introduction
Suppose the authors of this manuscript wish to learn who amongst us is able to eat the most. 
Over 5 days, we conduct 10 experiments where we  attempt to eat as many bread rolls as we can. 
We conduct a repeated-measures one-way ANOVA of the number of rolls eaten per day, with the factors AUTHOR (levels: first author, second author, third author).
When we find a 'significant $p$-value', we conclude that the author who ate the most bread is likely able to eat more than all others (because if we all had equal stomaches, finding such a large discrepancy in bread rolls consumed would be weird). 
This endeavour may be silly (and unhealthy), but statistically, it is rather sound.
Now, we wish to know which of us has the largest feet.
Consequently, we measure our respective shoe sizes; whoever provides the largest value has biggest the feet.
Since we think ourselves competent enough to measure shoe size, we do not consider using an ANOVA this time.

We claim that contributors to *B&L* routinely conduct inferential statistics in situations such as the latter.
Specifically, we find that in most of the situations where researchers aim to control for possible cofounds resulting from undesired non-equivalences in stimulus materials, they apply inferential tests even though this procedure is meaningless and not helpful.
Consider a real example published under one of our names:

> critical stimuli did not differ in frequency, F(2,237) = 1.43, p > .24, or word length, F(2,237) = 1.70, p>.18.

By investigating multiple volumes of *Brain & Language*, we have found that in more than XXXX articles, researchers wrongly apply inferential statistics where they are neither licensed nor meaningful. 
For example, they compare the length of two fixed lists of words, those making up condition one and those in condition two, using a *t*-test, i.e. they estimate a known value.
Often, they also further claim that stimuli were “matched”/equal/equivalent regarding such parameters based on the non-significant result of such inferential tests.
Editors and reviewers often do not disallow such behavior.
The exact same mistake occur when comparing two participant groups in aspects that are not generalized beyond the group, e.g. age or lesion.
The mistake we addressing here is using inference tests for a descriptive purpose.
When comparing two participant groups, we are usually describing the distribution of certain features in those two groups, and not in the larger population (undergraduate students or neurological patients).
We want to know if their feet are different sizes, not whether foot size in the broader population varies.

We do not wish to single out and ridicule any specific researcher, especially given our own previous failings.
We want to show that this problem is endemic, even in such high-quality journals as *Brain & Language*, as well as address the misunderstandings that have lead to it.
In the following, we discuss the appropriate interpretation of such tests, attempt to explain what they are (wrongly) used for instead, and show how prevalent such mistakes are by demonstrating the proportion of these mistakes in the last two years of *B&L*.

[^bread]: Note that we did not actually conduct this test because we didn't want to deal with ethics.
[^shoes]: We wish, ethics be damned, to inform the reader that it is Mr. Alday.

## When all you have is a hammer: inferential statistics for known parameters
In the following, we briefly review basic statistical principles and terminology to emphasize the fundamental mistake that we make when we use inferential statistics for fully sampled, closed populations.
Moroever, it has been shown repeatedly that many, even most researchers gravely misunderstand statistical concepts such as the meaning of *p*-values [@Haller:2002vo; @Lecoutre:2003vz; @Oakes:1986tn; @Falk:1995vc].
Indeed, many of the most "basic", or perhaps better said, most commonly used statistical concepts are rather counterintuitive. 
The material presented here is nothing new, but sometimes it pays to review the things we learned in school.
Especially when in practice we find ourselves and others governed by incoherent rituals and heuristics [@Gigerenzer2004].

Inferential statistics estimate population parameters based on samples drawn from the population. 
We use estimation by inference because sampling from a population is not an exact **measurement** of a population. 
We use sampling because it is often not practical to measure an entire population or even possible, for example when we wish to generalize over time. 
As such, sampling is *necessarily* almost always incomplete and introduces errors. 
In most experiments, if we were to repeat the sampling and sample measurement, we would, even though the population parameter is (fictitiously) assumed unchanged, find different values[^alphabets].
This is why we need inferences: to estimate from a sample an unknown, but fixed parameter that we cannot observe by itself.
Inference tests attempt to provide a measure of whether obsevered differences arise from sampling artefacts or true differences.
Consequently, exhaustive and error-free sampling does not require, license or benefit from inferential tests.

[^alphabets] The difference between the true and estimated parameter is expressed in the literature in the choice of alphabet: Greek for estimated parameters, Latin for true parameters.

Descriptive statistics include reporting parameters that only pertain to the sample at hand, such as sample size, sample variance, and non-standardized (raw means) or standardized (Cohen's *d*) effect sizes. 
Essentially, what may be measured without error in the current sample is descriptive. 
Inferential procedures include the calculation of *p*-values and possibly matching them to an alpha level, confidence intervals of non-standardized or standardized effect sizes, or calculating the Bayes Factor; they are assumed to quantify the relationship between measurement and sampling error on one hand and the population parameter on the other.
Much like the decision whether to view a certain variable as a random or fixed factor, the decision whether to think descriptively or inferentially is somewhat experiment and hypothesis dependent. 
If we want to know which author ate the most bread rolls, then we would use descriptive measures. 
Only we when wish to generalize to not fully measured population, e.g. when we want to know which author will eat the most bread rolls in the future, is the use of inferential measures licensed. 

Inferential statistics are necessarily imprecise in a technical sense: They are subject to random error and thus lack *precision*
(For now, we will not comment on *accuracy* or systematic error  in statistical practice.)
For many stimulus parameters, there is no random (sampling) error, because the entire population is known and thus its parameters can be measured directly and without error.
More directly, we are not interested in the stimuli we *might* have selected, but haven't, but rather, and exclusively, in those we *have* selected, and so we are not generally interested in inferences.

Now, consider two very similar cases:

+ We wish to match two lists of stimuli on word length.
+ We wish to match two lists of stimuli on affect.

The latter requires *ratings*; ratings are samples drawn with measurement error from a large population. Were we to repeat the measurement as precisely as we could, we would still find different (though hopefully similar) data, both because we might measure different people, and because even the same individual might not give the same rating each time it is asked to do so. Consequently, it makes sense to apply an inferential test of the population parameter, as an estimate of what might have happened had we asked *everybody* (and if everyone were a robot).
In contrast, we trust our student assistants well enough to correctly count letters and syllables, access frequency data bases and classify words by word class without error, so the former scenario should result in exactly the same values however often we repeat it. 
Also, the population we attempt to measure is not, as in the second example, beyond our reach; rather, we are interested in 80 words, and just these 80 words.

frequency vs frequency in a corpus

Lastly, our inferential tests do not inform us about the question we are actually interested in - are the stimuli equivalent?
They inform us about a numerical hypothesis we are actually very rarely interested in: how surprised would we be had we assumed that the population parameter is exactly 0? Inferential tests do not test research hypotheses and do not establish *practical* significance, they test numerical hypotheses (parameters) and establish *statistical* significance.

## Hitting the wall, not the nail: testing and accepting the null

Many, and in brain and behavioral sciences, nearly all inferential statistics takes the form of hypothesis tests. We will in the following mostly concern ourselves with the two-sample test that estimates if two samples were drawn from one distribution, such as the two-sample  *t*-test or the one-by-two ANOVA.
Two distinct schools of hypothesis test have left their marks on current statistical practice. The *Fischer*ian hypothesis test [@Fisher:1949uc] is to be conducted when only very little can be assumed regarding the population effect. It requires a null hypothesis, which, in the Fischerian framework, is defined thusly:

>H~0~ is the hypothesis under test.

It is often said that the null hypothesis in a comparison of two populations is that of no differences (nil-null). This is wrong. Yet, most null hypotheses in brain and behavioral sciences take the form of a point-null hypothesis, where μ is the population parameter and H~0~: μ = 0.
H~0~ is a precise numeric postulate about a single value for the parameter in question. It is not a statement of the form “there is no meaningful difference between the two conditions”; it is nothing precisely that a certain parameter has a precise value. And it is only this hypothesis, of the parameter having a precise value, that is under test, and any derived conclusions refer only to this value.
This is how *p*-values reveal themselves as parameter estimation: the null hypothesis is that the parameter is (e.g.) 0, and a test may then inform us that, with some confidence, the parameter may be assumed to be not precisely that value.

In our survey, in all the not rejected H~0~'s, we have not found even one that was true. We know that they are wrong, because the null hypothesis is that the parameter is exactly 0, and it never was in our survey. When the two populations under test are 40 word stimuli in group one, and 40 word stimuli in group two, and the mean word length is 4 in group one and 4.0001 in group two, the null hypothesis is wrong, because H~0~: μ = 0, but μ = 0.0001. Yet, inferential tests very often will fail to reject H~0~ in such cases, because the sample size is too small (the variance is too large). However, this is what would be called a type II error in the Neyman-Pearson framework: we fail to reject a wrong null.
In contrast, if your stimuli happened to be two groups of computer-generated non-word lists that were selected to precisely share mean length, we would not bother to test them using an inference test.

The inference test provides a *p*-value for the statement p(D|H~0~) so that

>*p* is the probability of the data conditional on the null.

This means that *p* informs us how unlikely or weird [@Christensen:2005fp] the present sample parameter is for anybody who assumes the null to be true - for anybody who assumes that the population parameter is exactly that assumed by the null (e.g., 0). For repeated sampling from identical distributions, *p*-values will be uniformly distributed [@Murdoch:2008dc] - we expect unlikely events to occur, we just expect them to occur rarely (so that only 3% of samples should result in a *p*<.03 if the null hypothesis point estimate equals the center of the sampled distribution). Generally, from a low *p*, we then proceed to say that the null hypothesis can be considered unlikely with some confidence.
This test is of course very coarse. It informs us only about the confidence with which we may assume the parameter to be not exactly zero. It does not tell us how far from zero it is, or even what exactly this difference might be. Compare the *p*-value resulting from the test of word length differences, and the simple mean of the differences from two stimulus lists. The *p* value, at its most informative, tells us how surprising it would be for the population parameter to be 0. The mean itself tells us, since we have measured the whole population, exactly what the population parameter is!

The Neyman-Pearson approach introduces the option of rejecting and accepting hypotheses, the alternative hypothesis H~1~, the long-run boundary for incorrectly rejecting H~0~, α, the long-run boundary for incorrectly rejecting H~1~, β, and resulting concepts such as type I and II errors, statistical power (1-β) and a fixed significance level (α). For the Neyman-Pearson approach, the goal is to optimise long-term error rates; it provides decision criteria for repeated experiments, such as in quality control. In the NP approach, H~0~ is rejected and H~1~ accepted if our test result suffices for our α; if not, we accept H~0~.

Both approaches share some aspects, such as *p*-values and the default proposal for a critical significance or decision criterion at .05 or 1/20. They are also fundamentally incompatible. In the *null ritual* dominating much of brain and behavioral science, they are combined into an incoherent default [@Gigerenzer2004].

Neither from a Fischerian nor an NP perspective is it meaningful to apply an inferential test resulting in a *p*-value when a researcher wants to demonstrate the equivalence of two small populations. A Fischerian test simply does not provide any information regarding any other hypothesis but the one under test, which is the null. In the typical point null test comparing two samples, we will be able to say that just this point estimate is unlikely if *p* is low, but conversely, a high *p* does not tell us that the point estimate is likely correct. Inverting the *modus tollens* when the antecedent statement is probabilistic is a well-known fallacy [@Cohen:1994uk]. We do not find p(H|D), the probability of the hypothesis given the data [@Wagenmakers:2008ti]; we find p(D|H), the data given the hypothesis.
Consequently, in the Fischerian framework, no other information can ever be derived from a *p* value but that either the data is unlikely to have come from a distribution described by the null, or that we are unable to speak with confidence about this distribution. It does not give us any confidence regarding any other possible hypotheses, such as the hypotheses that the population parameter is *almost* zero.

Regarding the NP framework, from which we have our “p<.05” significance filter, it does provide the possibility of accepting either of the two hypotheses (one aspect where it is fundamentally incompatible with the Fischerian tradition). However, alpha and beta, the way they are almost always chosen, are set up just the wrong way to test for equivalence for situations where not detecting non-equivalence would be problematic. The error rate of rejecting H~0~ when it is true, of detecting non-equivalence, is deliberately chosen to be low (at 1/20). For a sample, we do not accept the hypothesis of non-equivalence if the likelihood of the current data under the null is as low as 1/2, 1/10, or even 1/19. This might make sense in a scenario of quality control, where long-run error rates need to be controlled, but makes little sense when trying to check for e.g. the possibility of presenting in one experiment stimuli that are non-equivalent in some problematic aspect; yet, here, too a conservative alpha level is chosen.
This means that even if the observed difference between two stimulus lists would have been a data set we would obtain only 1 out of 8 times when sampling from equivalent populations, the test would still not provide evidence against equivalence at the .05 level. Our test is conservative regarding the rejection of the null. Consider what happens when one increases ones α to make the test less conservative; stimuli will be found non-equivalent.
Furthermore, as described above, the likelihood of rejecting a wrong H~0~ is not simply determined by the divergence of the two populations, but also by the size of the sample, because we derive more confidence from larger samples. When one wants to decrease the type II rate, since we do not have control over effect size, sample size must be increased. However, this is not sound when constructing stimulus sets.
Of course, the power of tests, the likelihood of correctly rejecting a null hypothesis, is generally worryingly low in brain and behavioral sciences [@Button:2013dz; @Yarkoni:2009ub]. 

We are still considering the situation of a researcher who constructs two stimulus sets so that they differ in one aspect, such as animacy or familiarity, and wishes to test if they are equivalent with regards to one aspect he deems uninteresting, such as word length or frequency, because he hopes that the two stimulus lists will result in different responses and that this difference may be safely assigned to the main aspect in question. He thus hopes to show that they are equivalent with regards to the uninteresting parameter.
We believe researchers are not truly interested in the confidence with which they may reject the point null estimate. The nil-null is uninteresting and usually known to be wrong; as noted, if words differ by as little as .0001 letter, H~0~, as a point-null assuming the value 0, is wrong. But this does not invalidate the researcher's study; very often, a small, but non-zero difference is truly irrelevant and the two conditions can be considered equivalent regarding some aspect. We assume what researchers primarily want out of their inferential tests is an objective decision regarding the non-relevance of differences between conditions in some aspect.
Inferential hypothesis tests do not by themselves provide such a measure. A high *p*-value does not allow one to state with confidence that the two conditions are practically equivalent.
We repeat: statistical tests estimate numerical hypotheses and provide us with information regarding *statistical* significance, or the confidence with which we may assume a *statistical difference*. They do not answer questions regarding *practical* significance, or how meaningful an estimated difference is. Yet the best explanation regarding our finding that *B&L* contributors consider inferential tests in such situations appropriate is that researchers intuitively apply these tests because they are hoping for an objective measure of practical significance, meaningfulness, or relevance (the alternative, which we think less likely, is that they do not understand fundamental concepts of statistics such as sampling, error and p(D|H)).

Standardized effect sizes [@Kline:2004vb][@Cohen:1994uk][@Hentschke2011][@Wilkinson:1999wd] are arguably more interesting parameters than *p*-values from point null hypotheses. As an example, Cohen's *d* estimates the ratio between the difference between populations and their standard deviation. If *d* is large, the difference between groups is large compared to the within-group variance. Cohen even provides rules of thumb, where *d* = .5 is a moderate effect. By itself, this may be considered just a descriptive statistic.
Can standardized effect sizes give the information researchers wish to deduce from hypothesis tests? No. Cohen's rules of thumb were always only meant as rules of thumb. How meaningful a *d* of .3 or 1.3 is in a certain context is still subjective, unless an external criterion is applied.

In a Fischerian interpretation [@Cumming:2005hy; @Christensen:2005fp] of the confidence interval (originally better associated with Neyman-Pearson), the (1-α)% CI gives the range of point hypotheses for which the data would be surprising at the level of α. A CI thereby estimates a range of values regarding if we may with confidence reject them as the parameter for the population from which the sample was drawn. It may be seen as an upper and lower bound for the difference between two populations, based on the sample - a vastly more informative measure beyond simply estimating if the difference is exactly zero!
However, how meaningful a certain difference might be is still up to the researcher to decide.
Confidence intervals are used for explicit tests of equivalence [@Kruschke:2013jy; @Tryon:2008hg; @Lesaffre:2001je; @Lindquist:2013gj], for example, in medical research comparing the effectivity of two treatments. Here, researchers specify a priori an equivalence region; if the CI of the estimated mean difference falls entirely within that region, equivalence can be assumed with a certain confidence. However, this Region of Perceived Equivalence/RoPE must be set up in advance based on a judgement by the researcher - is a difference of not more than .3 syllables equivalence? Can it be considered equivalence if the 95% CI of *d* is contained between -.1 and .1? Of course, sometimes, once a researcher has decided on his RoPE, he must not conduct an inferential test/a parameter estimate, such as a CI, anymore, because the precise difference between conditions is known.

Lastly, Bayesian methods allow the acceptance of the null hypothesis [@Dienes:2011cd; @Wagenmakers:2008ti]. Of course, leaving aside such problems as specifying a prior or alternative hypotheses, a test of evidence in favour of the null is superior when one wishes to find the level of support for the null. However, still, there is no reason to calculate a Bayes factor to aid in statistical inference when the sample in question has been measured without error and is an exhaustive sample of the population under question.

The only inferential test that establishes the relevance of the difference between stimuli regarding the primary outcomes we can think of is a regression from the factor that is hoped to be equivalent to the primary outcome. A multilevel/mixed model may provide a precise estimate of the effect of the stimulus parameters hoped to be equivalent between conditions on the primary outcome.

## Stop the ritual

Beyond the potentially overused cliché of the man who sees only nails because he only has a hammer, we wish to invoke a certain imagery here: the princess is about to be sacrificed at the altar of Cthulhu. The princess, here, may be the truth or the data; Cthulhu is best mapped to our thesis supervisor or grant institute; the sacrificial obsidian knife is the *t*-test. We must stop the ritual.
Researchers are not stupid. They see patterns in complex, underdetermined situations, Yet, when they attempt to formalize their visions, they sometimes produce pointless, incoherent practices. Why? We can only assume that the procedure of submitting data to the next thing that will give a *p*-value has become so habituated, ritualized, that researchers apply it even in situations where it makes no sense. We fear that such mindless applications of a statistical ritual [@Gigerenzer2004] also impacts far more interesting and important aspects of research [carcrash]. If researchers have wrong intuitions regarding the comparatively simple statistics involved in comparing two lists of 40 words each for their mean length, how confident can we be when trying to understand fMRI data, multilevel regressions or gene association studies?
We must progress from the mindless statistical ritual to careful consideration of the appropriate statistical tool for a given scientific problem. Statistics estimate parameters; it is up to us to create theories that can be tested by estimating parameters, and to properly estimate what an estimated parameter tells us about brain and behavior.

[^carcrash]: There are also reports of similar misuses of significance tests resulting in the loss of life, for example, in accident statistics influencing public policies [@Hauer:2004fz].


# Prevalence of the problem in B&L
The initial three examples for the problem where collected nonsystematically. 
To estimate how common the problem is in neurolinguistics, a high-quality neurolinguistic journal, *Brain & Language*, was investigated. 
Instances of the error can be easily found, not only in recent, but also in older publications:

> concrete primes were rated high, and abstract primes low, in both concreteness and imageability, and were significantly different on both dimensions: concreteness, t(59) = 17.84,p < .OOO1; imageability, t(59) = 23.64, p < .OOO1. 
However, the two prime categories were equivalent in text frequency (Carroll et al., 1971), and in length (both t's < 1.1
[@Chiarello:1987ui]

Here, the authors commit the "double sin" of both estimating a known quantity, and deducing equivalence (acceptance of the null) from a failed test - in this case, a test that leads the authors to accept a wrong null hypothesis; the difference in word length in this study was 0.16, a small quantity, but certainly not exactly zero.

## Methods
The analysis was restricted to current volumes. 
For all articles published by B&L in the years 2012 and 2013 as of yet, two independent raters, neither of which was blind to the purpose of the experiment, investigated all published experimental papers (excluding reviews, simulation studies, editorials etc.). 
For each experiment reported in a study, the stimulus/materials sections were investigated for descriptive and inferential statistics derived from populations that were exhaustively sampled without error. 
If a descriptive and/or inferential statistic (such as mean and standard deviation) were reported, the study was coded as one where the researchers were interested in a known quantity, otherwise it was discarded. 
If an inferential statistic (such as a *p*-value) was reported, the study was coded as one where researchers answered that interest with an erroneous parameter estimate, otherwise as one where researchers did not commit the error.
Furthermore, if a statement of the form that two populations were thought equivalent in the parameter was made, such as a statement containing the forms “matched”, “equal” or “did not differ”, and this statement was followed by a *p*-value greater than .05, the study as coded as accepting the null.
Rater agreement was generally good (yy%); in cases of disagreement, the author made the final call. 
Representative statements from every study committing an error are presented in the appendix. 
We abstain from computing the statistical significance of this finding; the evaluation of the significance of the findings is left to the reader.

## Results
In total, N studies where found where researchers reported known quantities in their stimulus/materials section, and M (xx%) of these reported inferential statistics of these known values. O (zz%%) accepted the null hypothesis.
