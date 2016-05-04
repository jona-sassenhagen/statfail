# Copyright 2016, Phillip Alday
#
# This file is part of statfail.
#
# Optional Stopping is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#n.items <- 20; manipulation.effect.size <- 2; confound.effect.size <- 0.5; confound.feature.size <- 0.5; confound.feature.effect.correlation <- 1;
#library(MASS)
#confound.feature.effect.correlation
#confound.feature.size
library(reshape2)
library(plyr)

generate.correlated.data <- function(rho,data,seed.data=NULL){

  # based on http://stats.stackexchange.com/q/15011/26743
  theta <- acos(rho)  # angle corresponding to correlation
  x1    <- data       # fixed given data
  n     <- length(x1)  # number of data points
  if(is.null(seed.data)){
    seed.data <- rnorm(n,mean=0,sd=1)
  }
  # avoid numerical issues with perfect correlation
  if(theta == 0){
    x <- data + mean(seed.data)
    if(rho < 0){
      return (-x)
    }else{
      return (x)
    }
  }

  x2    <- seed.data      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)

  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1

  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector

  x
}

simulate <- function(manipulation.effect.size, confound.feature.size,
                     confound.feature.effect.correlation, n.items){

  # this is the manipulation itself -- two normally distributed groups with sd=1
  # and difference in means given by Cohen's d (whose denominator is the sd is 1)
  control <- rnorm(n.items,mean=0)
  manipulation <- control + rnorm(n.items,mean=manipulation.effect.size)

  # this is the feature as measured, which is *not* the same as the impact of that
  # feature on the outcome variable
  control.feature <- rnorm(n.items,0)
  manipulation.feature <- rnorm(n.items, mean=confound.feature.size)

  # this is impact of the feature on the outcome variable, computed by producing a dataset with the same
  # feature-outcome.impact correlation
  control.confound <- generate.correlated.data(rho=confound.feature.effect.correlation, data=control.feature)
  manipulation.confound <-  generate.correlated.data(rho=confound.feature.effect.correlation,data=manipulation.feature)


  outcomes <- data.frame(item=1:n.items,
                        control=control,
                        manipulation=manipulation)
  features <- data.frame(item=1:n.items,
                        control=control.feature,
                        manipulation=manipulation.feature)

  confounds <- data.frame(item=1:n.items,
                         control=control.confound,
                         manipulation=manipulation.confound)

  outcomes <- melt(outcomes,id.vars="item",variable.name="condition",value.name="outcome")
  features <- melt(features,id.vars="item",variable.name="condition",value.name="feature")
  confounds <- melt(confounds,id.vars="item",variable.name="condition",value.name="confound")

  results <- join(outcomes,features,by=c("item","condition"))
  results <- join(results,confounds,by=c("item","condition"))

  results$confounded.outcome <- results$outcome + results$confound

  results
}

# x <- simulate(manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=0.8,n.items=20)
# summary(lm(outcome ~ condition, data=x))
# t.test(outcome~condition,data=x)
# t.test(confounded.outcome~condition,data=x)
# t.test(feature~condition,data=x)

resimulate <- function(n,...){
  # strip out the iteration number being passed via lapply
  lambda <- function(x,...) simulate(...)

  x <- lapply(1:n,lambda,...)
  result <- do.call(rbind,x)

  result$iter <- sort(rep(seq(n),nrow(result)/n))

  result
}

#resimulate(n=100,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=0.8,n.items=20)