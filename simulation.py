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
import scipy
import matplotlib.pyplot as plt
import sys

# Set seed to ensure reproducible simulation
np.random.seed(42)

def main(argv=None):
    
    n=20
    stims=40
    effect_size=.5
    confound_size=.3
    runs=100000

    results = simulate(n=n, stims=stims, effect_size=effect_size, 
                        confound_size=confound_size, runs=runs)
    plot_hist(*results, n=n, effect_size=effect_size, confound_size=confound_size, 
                runs=runs, ax=plt.gca(), pltx=True)

    plt.gcf().savefig("simulation.pdf")
    
def simulate(n=20, stims=40, effect_size=0.5, confound_size=0.3, runs=100000):
    # assume that the distribution of sampled effects and confounds is normally distributed
    # around the true effect/confound size

    # slopes in regression    
    effect =  effect_size    + np.random.randn(runs, stims)
    confound = confound_size + np.random.randn(runs, stims) 
  
    # collapse across trials so that we can calculate a paired t-test instead of an (by-subjects) ANOVA  
    # this is equivalent to a crossing of random effects where there is no interaction between subject and items
    # the confound and effect are combined before pooling/averaging because the confound varies on a per-item basis
    confounded_effect = np.mean(effect+confound,1)
    effect = np.mean(effect,1)

    # intercepts in regression, first condition
    control = np.random.randn(runs, n)
    
    # for a two-level categorical manipulation, slope + intercept gives you the value of 
    # of the second condition
    manipulation = control + np.repeat(effect,20,axis=1)
    confounded_manipulation = manipulation + np.repeat(confounded_effect,20,axis=1)

    unconfounded_results = scipy.stats.ttest_rel(control, manipulation, axis=1)[1]
    confounded_results = scipy.stats.ttest_rel(control, confounded_manipulation, axis=1)[1]
    stim_tests = scipy.stats.ttest_1samp(confound.T, 0)[1]

    sig_stimtests = np.where(stim_tests < .05)
    insig_stimtests = np.where(stim_tests > .05)
    assert(len(stim_tests) == runs)

    # Fake effect (not detected) 
    # stimuli not classified as confounded
    # significant effect with confounds
    nonrejected_insign_in_conf = np.intersect1d(insig_stimtests, np.where(confounded_results < .05)[0])
    no_alarm = unconfounded_results[np.intersect1d(nonrejected_insign_in_conf, 
                                                   np.where(unconfounded_results > .05)[0])]

    # Fake effect (not detected) 
    # stimuli classified as confounded
    # significant effect with confounds
    rejected_sign_in_conf = np.intersect1d(sig_stimtests, np.where(confounded_results < .05)[0])
    good_alarm = unconfounded_results[np.intersect1d(rejected_sign_in_conf, 
                                                     np.where(unconfounded_results > .05)[0])]

    # Real effect (falsely rejected) 
    # stimuli classified as confounded
    # significant effect without confounds
    false_rejection = unconfounded_results[np.intersect1d(sig_stimtests, 
                                                          np.where(unconfounded_results < .05)[0])]

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
        ax.set_xlabel("p value of unconfounded data")
    else: 
        ax.set_xticks([])
    
    if plty: 
        ax.set_ylabel("Counts")
    
    ax.set_title("n: {}. Effect size: {}. Confound size: {}".format(n, effect_size, confound_size))

if __name__ == "__main__":
    sys.exit(main())