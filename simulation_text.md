## Simulation study
We furthermore conducted a simulation study to estimate the impact of this procedure on 1. correctly detecting results where a confound in the form of influence from imbalanced stimulus selection led to a result that was significant where no significant result would have been detected without this confound, 2. incorrectly rejecting results where a confound may exist, but a true effect a. was presented and b. would have been detected regardless of the confound, 3. failing to reject results where no effect would have been detected without stimulus confounds, but one is detected with the confounding factor. Code for this simulation can be found in the appendix, but the structure of the simulation study was as follows:

* Generate results (100000 times)
	* generate random data for two conditions for a number of subjects
	* add a certain "real" effect to one condition
	* conduct a t-test
	* add a certain "confound" effect to one condition
	* conduct another t-test on the condition data
	* conduct a third t-test on the confound effect itself

* Evaluate results
    * if the first test rejects, the sample at hand is understood as having a real effect, without confound present.
    * if the second test rejects, the sample at hand is understood as having an effect with confound present.
    * if the third test rejects, the confound would have been detected by the procedure we criticise here.

### Results of simulation study
We observe major failure rates of the described procedure, both in the form of undetected false/confounded results, and in rejecting results that would have been significant without the confound effect (see Figure \ref{fig1}).
For example, for an effect size of .5 and a confound effect size of .3 and 20 subjects/group (in a within-subject design), ~14.5% of runs resulted in a failure to reject a result that was significant with the confound, but was not significant without; ~10.5% resulted in rejecting a result that would have been significant also without the confound; and only ~12.5% resulted in the correct rejection of results that would not have been significant without the confound effect.

We observe that the primary determinant of this procedure is the ratio of the confound effect compared to the real effect.
For example, if the real effect is 0 and the confound effect is .5, over 25% correct rejections stand against 4% false rejections and 4% missed rejections.

![Simulation study results\label{fig1}](statfail_simul.pdf)


