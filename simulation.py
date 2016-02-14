# Copyright (c) 2014-15 Jona Sassenhagen and Phillip Alday
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/

import numpy as np
import scipy.stats
import matplotlib.pyplot as plt
import seaborn # not ever called directly, but loads nice matplotlib theme as a side-effect
import sys

# Set seed to ensure reproducible simulation
np.random.seed(42)

def main(argv=None):
    
    n=20
    stims=40
    effect_size=0.5
    confound_size=0.3
    runs=1e5

    results = simulate(n=n, stims=stims, effect_size=effect_size, 
                        confound_size=confound_size, runs=runs)
    plt.close('all')
    plot_hist(*results, n=n, effect_size=effect_size, confound_size=confound_size, 
                runs=runs, ax=plt.gca(), pltx=True)

    plt.gcf().savefig("simulation.pdf")
    
def simulate(n=20, stims=40, effect_size=0.5, confound_size=0.3, runs=1e5):
    # assume that the distribution of sampled effects and confounds is normally distributed
    # around the true effect/confound size

    # slopes in regression    
    effect =  effect_size    + np.random.randn(runs, n, stims)
    confound = confound_size + np.random.randn(runs, stims) 
    
    # collapse across trials so that we can calculate a paired t-test instead of an (by-subjects) ANOVA  
    # this is equivalent to a crossing of random effects where there is no interaction between subject and items
    # the confound and effect are combined before pooling/averaging because the confound varies on a per-item basis
     #np.apply_along_axis(lambda x,y: x+y,1,effect,effect)

    confounded_effect = np.zeros((runs,n,stims))
    for i in range(n):
        confounded_effect[:,i,:] = effect[:,i,:] + confound

    # by items
    confounded_effect = np.mean(confounded_effect,2)
    effect = np.mean(effect,2)
    
    # A by-subject ANOVA for two conditions is equivalent (via F=t^2) to a paired-samples t-test, 
    # where single-subject averages are computed (i.e. across items) for each condition to establish
    # the items. However, since a paired t-test is a one-sample t-test on the pairwise differences,
    # we can just simulate the differences directly and leave out simulating the subject baselines.
    # In other words, we can just do a t-test on the simulated effect. 


    # ttest returns (t,p)
    unconfounded_results = scipy.stats.ttest_1samp(effect, 0, axis=1)[1]
    confounded_results = scipy.stats.ttest_1samp(confounded_effect, 0, axis=1)[1]
    stim_tests = scipy.stats.ttest_1samp(confound.T, 0)[1]

    sig_stimtests = np.where(stim_tests < .05)[0]
    insig_stimtests = np.where(stim_tests >= .05)[0]

    sig_unconfounded_results = np.where(unconfounded_results < 0.05)[0]
    insig_unconfounded_results = np.where(unconfounded_results >= 0.05)[0]

    sig_confounded_results = np.where(confounded_results < 0.05)[0] 
    insig_confounded_results = np.where(confounded_results >= 0.05)[0] 
    
    # Fake effect (not detected) 
    # stimuli not classified as confounded
    # significant effect with confounds
    nonrejected_insign_in_conf = np.intersect1d(insig_stimtests, insig_confounded_results)
    no_alarm = unconfounded_results[np.intersect1d(nonrejected_insign_in_conf, insig_unconfounded_results)]

    # Fake effect (not detected) 
    # stimuli classified as confounded
    # significant effect with confounds
    rejected_sign_in_conf = np.intersect1d(sig_stimtests, sig_confounded_results)
    good_alarm = unconfounded_results[np.intersect1d(rejected_sign_in_conf, insig_unconfounded_results)]

    # Real effect (falsely rejected) 
    # stimuli classified as confounded
    # significant effect without confounds
    false_rejection = unconfounded_results[np.intersect1d(sig_stimtests, sig_unconfounded_results)]

    return no_alarm, good_alarm, false_rejection

def plot_hist(no_alarm, good_alarm, false_rejection, runs=100000, 
              effect_size=.5, n=20, confound_size=.3, ax=None, plty=False, pltx=False):
    ax.hist([no_alarm, good_alarm, false_rejection], 
             label=('Nondetected false results         : {}%'.format(len(no_alarm)        * 100.0 / runs), 
                    'Detected false results            : {}%'.format(len(good_alarm)      * 100.0 / runs), 
                    '(Falsely) rejected "real" results : {}%'.format(len(false_rejection) * 100.0 / runs)),
             bins=np.arange(0, 1.05, .05))
    ax.legend()
    
    if pltx: 
        ax.set_xlabel("p value without confound")
    else: 
        ax.set_xticks([])
    
    if plty: 
        ax.set_ylabel("Counts")
    
    ax.set_title("n: {}. Effect size: {}. Confound size: {}".format(n, effect_size, confound_size))

if __name__ == "__main__":
    sys.exit(main())