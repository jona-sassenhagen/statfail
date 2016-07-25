## Control and ecological validity in conflict
- Experimental control not possible in the brain & behavioural sciences in the same way as in the physical sciences:
    - truly artificial stimuli problematic (novel as types & tokens, etc.)
    - natural stimuli strongly confounded, with unclear causality and primacy
- Still, we try to match our stimulus, participant, etc. groups

## What's the problem?

> Animate and inanimate words chosen as stimulus materials did not differ in word frequency ($p$ > 0.05).

> Controls and aphasics did not differ in age ($p$ > 0.05).


### Philosophy
1. You can't accept the null in NHST, only fail to reject it.
  - Simply put, NHST doesn't have the notion of 'accepting' hypotheses, especially not the null.
  - You only reject a hypothesis as having a likelihood (probability conditional on your data model) that is too low to be taken seriously.

### Statistics
2. You're violating testing assumptions because *by design* you did not randomly sample.
  - You just aren't doing it by any stretch of the imagination.
  - You are actively trying to distort measures of both central location and spread.
3. You've performing inferences on a population you don't care about.
  - Inferential statistics, including statistical testing, draw conclusions from the data present about the data absent.
  - The absent data are things we don't care about:
     - The set of all animate vs. all inanimate nouns
     - The set of all possible patients vs. all possible controls
  - Alternatively, we have a completely sampled population and there are no absent data.
  - So just use descriptive statistics and make sure they match!

### Pragmatics
4. You're failing to perform the inference you actually care about.
  - Even if we could
      - accept the null and
      - pretend that we're sampling randomly
      - from a population we care about
  - we're still answering a boring question:

    > do these two populations differ systematically in the given feature?

  - when we actually care about:

    > is the variance observed in my manipulation (better or at least partially) explained by the differences in the given feature?

## What to do, what to do
- Stop inferential tests for confound control.
- Try to match groups as closely as possible using purely descriptive statistics (reduce confounds and collinearity).
- If you can (and this is a *should could*!), explicitly model these confounds as a covariate
    - Painful with ANOVA / ANCOVA / other 1970s statistics
    - Not a problem with modern (explicit) regression techniques like mixed-effects models
    - Which you really should be using anyway for many BBS designs [cf. @clark1973a; @judd.westfall.etal:2012pp; @westfallkennyjudd2014a]

# References
