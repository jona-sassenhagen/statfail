# Many *Brain & Language* authors, editors and reviewers confuse significance and *statistical* significance


## Abstract
In (xx%) of articles of the most recent (XX) volumes of *B&L*, statistical tests were used in a way that strongly implies that many authors, editors and reviewers falsely understood *statistical* significance as absolute significance. 
Specifically, completely known populations (such as word length of preselected, closed stimulus lists) are subjected to parameter estimation tests such as the *t*-test; thus, tests *estimating* a population parameter based on a sample are used on an exhaustively *measured* quantity, a population parameter that did not have to be estimated since it is precisely known. 
Such usage of inference tests indicates that researchers use them to quantify the practical relevance, or (common-language) significance, of a finding via *p*-value calculation - a crass misunderstanding. 
Researchers, including editors, reviewers and authors, must deepen their understanding of statistics.




## Introduction

Although many of the same tests are used for both descriptive and inferential statistics (and indeed the two are deeply related in the frequentist interpretation via probability theory), the p-value makes little sense in descriptive statistics. 

The p-value represents the probability that any sample of the same size would have the same descriptive properties as the sample actually taken, under the assumption of the null hypothesis. 
That is, the p-value is inherently an inferential method, despite its reliance on descriptive methods.[^convert-to-p] 

[^convert-to-p]:The actual conversion from a descriptive statistic to a p-value depends on either theoretical distributions (parametric tests) or simulated distributions (non parametric tests, e.g., permutation tests). 

For example, the F-test provides a measure for inter- vs. 
intra-group variation.  
When constructing stimuli, it thus makes sense to use an F-test to compare the variation between conditions to the variation within conditions, i.e. 
whether the stimuli actually provide distinct conditions. 
However, it does not make sense to calculate a p-value in such cases *because the stimuli were not constructed/chosen randomly*. 
We are not inferences about the likelihood of having the given distribution under chance, but rather trying to determine how clear the division between conditions is.  

Moreover, the null hypothesis is, per definition, false in such situations. 
We know that the stimuli were not chosen by chance. 
We do not need to test for the likelihood of something happening under the assumption of a condition we know to be false. 
The p-value in such cases just tells us the likelihood of a randomly generated stimulus set having the same properties as a carefully constructed one -- not very useful at all. 

Consider the following quotes (neither from *Brain & Language*):

>Demographic and clinical characteristics of the two groups of participants are presented in Table 1. 
The two groups differed significantly in age, *t*(50) = 2.87, *p* < .05
[@Joormann:2011jc]

>The CWs across conditions were matched on word length and frequency: log frequency in CELEX (Baayen et al., 1993): HC = 2.71, LC = 2.70, SV = 2.69, *F* (2,646) = 2.35, *p* = 0.10.
[@Wang:2012rn]

The *p*-values are meaningless, less than redundant, and imply that the researchers in question have false intuitions regarding statistical inference tests. 
They show only that researches have become stuck in a rut of understanding statistics only as "significant", "not significant", and when it suits me, "tending towards significance". 
More explicitly, p-values in such cases imply that *statistical significance* is confused with *practical relevance*; this can be deduced from the observation that a crude parameter *estimation* test was applied to a *known* parameter, which indicates that the researchers misunderstand *p*-values as *magnitude quantifications*.
I do not wish to single out and ridicule any specific researcher. 
I freely admit that in the past, I have conducted similar tests, or worse, avoided them out of laziness even though I (lazily) believed them to be appropriate. 
However, the scientific literature is full of such statements, implying that many researchers, editors and reviewers make the same mistake. 
Even the volumes of high-quality journals such as *Brain & Language* contain many such misuses of statistics. 
In the following, I will discuss the appropriate interpretation of such tests, attempt to explain what they are (wrongly) used for instead, and show how prevalent such mistakes are by presenting the number of these mistakes in the last two years of *B&L*.

## What's in a *p*?
Many statistical tests yield unintuitive results. 
In common academic discourse, the results of hypothesis tests are referred to as *significance* or *not significant*. 
Likely, many, possibly most researchers know the proper definition of the terms and the related statistical concepts, such as *p*-values. 
They are repeated here for the sake of completeness for the example of a two-sample *t*-test:

>Assuming the hypothesis under test (which is that the difference between the two populations is X) is true, the *p*-value gives the probability of obtaining a sample as far or further from X as the present data.

At its heart, the NHST is a crude form of parameter estimation. 
It presents how surprising a given sample drawn from some population(s) is to those who have assumed a certain value for the population parameter. 
Although this is not what the null in null-hypothesis significance tests (NHST) refers to, in brain and behavioral sciences, X is near-universally set at 0, so *p* gives the surprise value of the obtained data for anybody who assumes the two populations to be identical. 
A low p value means that the data is highly surprising to those who assume no difference between the sampled populations. 
This is typically interpreted as allowing to say with some confidence (often 95%) that the parameter (the difference between the two populations) is not 0.
No other entailment is afforded by the *p* value beyond providing some confidence in a  crude estimate of the population parameter, and (at least in the Fischerian tradition[^1]) only for the case where the test results in a low *p* value, which affords the estimation that the parameter is likely not 0.

[^1]: In a Neyman-Pearson framework, entirely different problems become relevant [@Gigerenzer2004]. 
I acknowledge that the present approach may at times not treat the fundamental differences between Neyman-Pearson and Fischerian concepts with enough care.

Trivially, statistical significance does not entail practical significance [@Goodman:2008gz]; a near-zero effect maybe result in extremely small *p*-values if the sample size is high and/or the sample variance is low, and small samples may produce low *p*-values that misrepresent a small, nonexistent or opposing-sign effect [@Gelman:2009um]. 
The nonequivalence of statistical and practical significance is even emphasised in many textbooks [@Gliner:2002uu], and might be expected to be common knowledge.

However, it has been shown repeatedly that many, even most researchers, gravely misunderstand statistical concepts such as the meaning of p values [@Haller:2002vo][@Lecoutre:2003vz][@Oakes:1986tn][@Falk:1995vc]. 
Typically, it is discussed [@Gigerenzer2004][@Cohen:1994uk] that researchers intuitively interpret *p*-values as if they reflect the probabilities of  hypotheses, that is, as p(Hypothesis|Data) - a Bayesian interpretation [@Wagenmakers:2008ti]. *P*-values do not inform us about the probability of a hypothesis given the data, but about the probability of the data given some hypothesis, and as Cohen [-@Cohen:1994uk] discusses, the *modus tollens* leading from p(Data|Hypothesis) to p(Hypothesis|Data) fails due to the probabilistic nature of the statement. 
This is not the phenomenon to be discussed here. 
Instead, the present essay investigates the following problem: researchers use *parameter estimators* on known parameters, likely because they are misinterpreting these parameter estimators as *magnitude quantificators*. 
Such an interpretation is indefensible, wrong, and must be discontinued.
A related problem is that researchers are also known to infer from a test that fails to reject the null hypothesis that the null hypothesis is true. 
This is wrong [@Cohen:1994uk], but a precondition of the misuse of statistics in the way discussed here.

Consider the following situation[^lindquist]: I wish to infer if I am significantly, or substantially, taller than my sister. 
I measure my height (6') and my sister's height (5'7). 
I now know that I am 5 inches taller than my sister. 
It would make no sense at all to apply a *t*-test to these two values. 
Even if a low *p* resulted, all that this would allow me to say is that I am probably not exactly the same height as my sister - which is not very useful since I already have much more precise knowledge of the parameter in question (5"). 
Neither would an extremely low *p*-value give me any confidence in the statement that I am "extremely" or "a little" taller than my sister; this is not afforded by the *p*-value, which simply allows me to say that likely, I am not exactly the same height as my sister given that the obtained measures would be highly improbable if we were of equal height.
If I wanted to infer if me and my brother are taller than my mother and my sister, it would likewise make little sense to follow the measurement of all of my siblings with a *t*-test. 
Neither would the *t*-test make sense if I had 14 brothers and 15 sisters and wanted to see which group is, on average, taller, assuming I precisely knew all their heights, since I could simply calculate the two mean heights and precisely measure the difference.
Contrast with the following two situations, where statistical inference may well make sense: I wish to know if I am taller than my sister, yet my ruler is somehow magically inaccurate and adds or subtracts a variable number of inches from every measurement. 
Here it might make sense to take multiple measurements of my sister and I and calculate a 95% Confidence Interval; this would allow me to roughly estimate the difference in inches (ignoring the superior option of simply standing next to my sister and looking in the mirror). 
Alternatively, I may wish to infer if men are generally taller than women. 
While it is possible for me to measure all of my (hypothetical) 29 siblings, it would be practically impossible to measure all men and women; however, a reliable estimate of the parameter might result from measuring a lot of men and women and conducting a statistical test. 
Cases such as the latter two are where parameter estimations such as the NHST make sense; cases such as the first are not meaningfully solved by ANOVAs.

[^lindquist]: A similar example has been used by Lindquist et al. [-@Lindquist:2013gj]

## Researchers estimate known quantities
A *t*-test comparing the length of two lists of 80 word stimuli each is equivalent to the former case in the above example, a *t*-test of 2x80 subject mean reaction times to these words in a classification task is equivalent to the latter. 
Some researchers, under compliance by editors and reviewers, use the crude parameter estimator that is the *p*-value in both kinds of situations (see below for the prevalence of this practice). 
They calculate *p* for the mean difference in ERP amplitude between two sentence types, between certain linguistic abilities for populations differing in some gene, or on reaction times following various stimuli. 
Here, parameter estimation makes sense because the true parameter is unknown. 
However, researchers also calculate *p*-values using parameter estimation tests such as the *t*-Test or the ANOVA for populations that are exhaustively measured (as are my sister and I's height), such as mean word length for two stimulus lists, or such as certain known parameters in two small, selected populations, like the age of two experimental groups.

So researchers already *know* the parameter (since they in fact must know e.g. 
the length of all their stimulus words to conduct the test of mean word length difference in the first place), and yet also *crudely estimate* it, with a tool allowing nothing but to say, with limited confidence, that e.g. 
two groups are not exactly identical with regards to the parameter, without any standardised quantification of the magnitude of the (possibly non-zero) difference. 
Statistical inference tests are validly used to infer a population parameter from a limited sample of the population. 
It is pointless to apply them to an *exhaustive* sample of the total population, where the population parameter must not be estimated since it can be measured.

## Interpreting low and high *p*'s
It is probably well-known that a researcher who declares his two groups identical based on a failed test is committing a grave mistake. 
Failed NHSTs do not at all allow the conclusion that the true parameter is that one under test (typically 0). 
The most pressing problem in this regard is that the power of tests, the likelihood of correctly rejecting a null hypothesis, is worryingly low in brain and behavioral sciences [@Button:2013dz][@Yarkoni:2009ub]. 
Even if the difference between two populations is substantial, a NHST may still fail to reject the hypothesis of no difference if only a small number of samples are investigated. 
However, even beyond that, failed NHSTs do not afford accepting the null with great confidence [@Cohen:1994uk][@Wagenmakers:2008ti]. 
A very simple demonstration of the fallacy of the test can be seen when considering that the actual status of the null hypothesis is *known*. 
The researcher estimating word length differences *knows* by what amount the mean word length between groups differs. 
If the words in one group measure on average 4.1 letters and the words in the other group 4.2, the population parameter is known to be 0.1 letter. 
For even such a small difference, a non-significant NHST, a test that fails to reject the zero-null hypothesis, is failing to reject a wrong null; in a two-sample *t*-test of the population difference, the null is (typically) that the difference is 0, so if the difference is anything but 0, such as 0.1, the null is wrong. 
Of course, many tests will fail to reject a null wrong by only such a small amount, for no other reason than insufficient power.
A test that may only allows to make with confidence the statement that a difference *does* exist, and never allows to say with confidence that no difference exists, is also most likely fully irrelevant to what the researchers have in mind in such situations, since usually, they want to show the equivalence of two groups. 
A *p*-value above 0.05 does not give confidence in the conclusion that two groups are equivalent; consider for example the situation of *p* = 0.1, a result clearly non-significant by current conventions. 
However, *p* in this case means that only in one out of 10 cases, a zero effect would result in data as extreme as the present observation, which presents more evidence against the null than for it. 
Of course, concluding that two populations are identical based on any other, even very high, *p*-value is similarly unjustified, for example since the test may simply be underpowered to detect a difference of the magnitude in the target population. 
So even if it would make sense to estimate known quantities, *t*- and *F*-family tests would still not be the appropriate tool for any researcher aiming to establish the equivalence of two groups regarding a parameter since it can never actually prove equivalence and is, at least with conventional type I thresholds, biased against non-equivalence.

Statistical methods for estimating population equivalence from samples do exist. 
Necessarily, they are not useful for *known* quantities; however, I will discuss them here briefly.
In the frequentist framework, researchers interested in the equivalence between two treatments may pre-define a Region of (practical) Equivalence [@Lesaffre:2001je] around the null and test if a CI falls entirely within this region; for example, a researcher investigating mean utterance length in men and women may assume that any difference in mean utterance length smaller than 2% is meaningless, and would infer from a 95% CI that falls entirely within [-0.02, 0.02] that likely, no meaningful difference exists and the populations are equivalent in this regard.
Alternatively, researchers may employ methods that explicitly allow to quantify the evidence in favour of one hypothesis, including a null hypothesis versus an alternative hypothesis, leading to the justified acceptance of the null hypothesis; such methods are provided by Bayesian statistics [@Wagenmakers:2008ti].

A researcher who finds a significant difference in word length between two groups and then says, with confidence, that the two groups differ is not committing as grave of a sign as one who infers equivalence from a high *p*; however, he is still wasting time, print space and computing power to crudely estimate what he already precisely knows. 
I assume that most researchers are smart people. 
Why, then, are they practicing such a meaningless ritual?
One answer is that the NHST is indeed ritualistic [@Gigerenzer2004], that it is done with much respect, but little consideration. 
However, what is the meaning of this ritual? I argue that the most likely explanation is that researcher use the NHST ritual because they somehow believe it to be a measure of effect size - a magnitude estimator [^2].
When mean word length differences of known populations (in contrast to, e.g., mean word length in unknown populations, such as when comparing mean word length in men vs. 
women) are statistically estimated, the likely common rationale is excluding the relevance of the factor word length for the actual outcomes, such as reaction times or ERP amplitudes in response to these stimuli.
This is not afforded by the test, regardless of its outcome. *P* informs us how unlikely the data are under the null, which at best can be interpreted to give us some confidence in saying the H~0~ is false; it entails no qualitative interpretation of the value, and it especially does not in any way help us decide how relevant the difference is. 
For a quantification of word length, the simple mean word length per group and their standard deviation are vastly superior to the crude estimation of if the parameter is or is not 0. 
To actually test if this difference in e.g. 
word length influences the results, I see no other, but also a simple possibility in computing the correlation between e.g. 
word length and the main outcome.

The direct implications of this error may admittedly be quite trivial [^carcrash]. 
Everybody is free to simply ignore a gratuitous *p*; if researchers argue that a non-significant inferential test establishes the equivalence of two groups regarding a parameter, it is easy to demonstrate the fallacy of this argument. 
In the worst case, a study will be cofounded because researchers used stimulus lists not well-controlled  because an underpowered test failed to reject a false null.
More problematic might be the entailment that many researchers, editors and reviewers sometimes see *p*-values as measures of the relevance and practical significance of an effect. 
Since *p*-values are still the primary quantification of research outcomes in brain and behavioral sciences, this means that many researchers, editors and reviewers substantially misunderstand the main tool that is used to evaluate findings.
Regarding quantifications of effect sizes, others [@Hentschke2011][@Cohen:1994uk][@Kruschke:2013jy][@Kline:2004vb], including the APA [@Wilkinson:1999wd], have convincingly argued that such measures are both critically called for, and readily available in the form of Confidence (or Credible) Intervals, standardised effect sizes, and CIs of standardised effect sizes. 
However, regardless of the alternatives, researchers must understand, both intellectually and intuitively, the difference between practical and statistical significance.

[^carcrash]: Though there are also reports of similar misuses of significance tests resulting in the loss of life, for example, in accident statistics influencing public policies [@Hauer:2004fz].

In no way am I saying that all statistical tests of e.g. 
word length are wrong. 
Neither are all statistical tests of stimulus parameters wrong; for example, acceptability ratings of stimuli can be meaningfully subjected to statistical tests that result in parameter estimates (though a test that allows to conclude equivalence, such as Bayesian tests or checking if a 95% CI falls within a pre-defined region of practical equivalence, would be preferable to a test that can only ever reject a null), since acceptability ratings are random samples non-exhaustively drawn from a large population.
However, parameter *estimation* of *known* parameters (such as a self-created stimulus list) reveal false intuitions regarding conventional statistics. 
Researchers must understand the difference between *p*, which is the surprise value of the observed data under the null, and actual measures of effect size which may take a shape such as Cohen's *d* [@Hentschke2011]. 
Note that standardised effect sizes (such as Cohen's rule of thumb of "small", "moderate" and "large" effects) do not straight-forwardly allow an assessment of the *relevance* of an effect either (since they are nothing but Cohen's rules of thumb). *t*-tests inform us how unlikely the parameter is to be zero, CIs inform us about a range of possible values for the effect, standardised effect sizes such as Cohen's *d* inform us how large a population effect is compared to the population variance; it is up to the researcher to understand and demonstrate how relevant any of these values are for his research questions. 
Instead of offering clear-cut solutions, one can only recommend researchers to abstain from ritualistic testing of any form, and consider each method's applicability and meaning on a case-by-case basis.

## Prevalence of the problem in B&L
The initial three examples for the problem where collected nonsystematically. 
To estimate how common the problem is in neurolinguistics, a high-quality neurolinguistic journal, *Brain & Language*, was investigated. 
Instances of the error can be easily found, not only in recent, but also in older publications:

> concrete primes were rated high, and abstract primes low, in both concreteness and imageability, and were significantly different on both dimensions: concreteness, t(59) = 17.84,p < .OOO1; imageability, t(59) = 23.64, p < .OOO1. 
However, the two prime categories were equivalent in text frequency (Carroll et al., 1971), and in length (both t’s < 1.1
[@Chiarello:1987ui]

Here, the authors commit the "double sin" of both estimating a known quantity, and deducing equivalence (acceptance of the null) from a failed test - in this case, a test that leads the authors to accept a wrong null hypothesis; the difference in word length in this study was 0.16, a small quantity, but certainly not exactly zero.

### Methods
The analysis was restricted to current volumes. 
For all articles published by B&L in the years 2012 and 2013 as of yet, two independent raters, neither of which was blind to the purpose of the experiment, investigated all published experimental papers (excluding reviews, simulation studies, editorials etc.). 
For each experiment reported in a study, the stimulus/materials sections were investigated for descriptive and inferential statistics of known quantities. 
If a descriptive and/or inferential statistic (such as mean and standard deviation) were reported, the study was coded as one where the researchers were interested in a known quantity, otherwise it was discarded. 
If an inferential statistic (such as a *p*-value) was reported, the study was coded as one where researchers answered that interest with an erroneous parameter estimate, otherwise as one where researchers did not commit the error. 
Rater agreement was generally good (yy%); in cases of disagreement, the author made the final call. 
Representative statements from every study committing the error are presented in the appendix. 

### Results
In total, N studies where found where researchers reported known quantities in their stimulus/materials section, and M (xx%) of these reported inferential statistics of these known values.
I abstain from computing the statistical significance of this finding; the evaluation of the significance of the findings is left to the reader.

[^2]: There is also a legitimate interpretation of the estimate of e.g. 
stimulus parameters; it reflects the capabilities of the stimulus selectors to provide adequate stimuli *as a probabilistic measure*. 
Of course, it is typically of little interest if the people in charge of stimulus creation were *likely* to obtain adequate stimuli; rather, for the interpretation of a study's main outcome, it might be relevant if they did in fact do so.


## References