# StatFail: Confusing Descriptive and Inferential Statistics in Experimental Design 

# Read the paper

Sassenhagen, Jona and Phillip M. Alday (under review): A common misapplication of statistical inference: nuisance control with null-hypothesis significance tests. Brain & Language. [arXiv preprint](http://arxiv.org/abs/1602.04565). [Repository](https://github.com/jona-sassenhagen/statfail/). 

The title will probably change in the near feature, as some of our initial reviewer feedback has been some very helpful terminological suggestions.

# Simulation in R

## Run it fast on your local machine
Run the following command in R:

```
# make sure shiny is installed
if(!require(shiny)){
  install.packages("shiny")
  library(shiny)
}
runGitHub("statfail",username="jona-sassenhagen",ref="shiny",subdir="simulation")
```

## Try it out slow on shinyapps.io
A Shiny app that allows you to more closely individual simulated experiments for a given set of simulation parameters is available in the GitHub repository and on [shinyapps.io](https://palday.shinyapps.io/statfail/).
If you're going to do lots of computations, please run the app locally so that server time remains available for others.

## See a static summary across different parameter levels

A more comprehensive aggregrate, static simulation showing the effects across many settings of the simulation parameters simultaneously is available on [RPubs](http://rpubs.com/palday/statfail).

## Simulation in Python

Another Python-based simulation will soon be made available on Binder, but the preliminary code is already in the GitHub repository.

## Copyright
Copyright (c) 2013-2015 by Jona Sassenhagen and Phillip Alday.

Unless otherwise specified, the files contained in this work are licensed under the Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-nd/3.0/ or send a letter to Creative Commons, 444 Castro Street, Suite 900, Mountain View, California, 94041, USA. 

