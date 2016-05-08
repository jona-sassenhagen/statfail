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

resimulate <- function(n,...,lapply.fnc=lapply){
  # strip out the iteration number being passed via lapply
  lambda <- function(x,...) simulate(...)

  x <- lapply.fnc(1:n,lambda,...)
  result <- do.call(rbind,x)

  result$iter <- sort(rep(seq(n),nrow(result)/n))

  result
}

compute.feature.stats <- function(simulation,...){
  # allow for processing of a single simulated dataset generated with simulate()
  if( !("iter" %in% names(simulation)) ) {
    simulation$iter <- 1
  }

  x <- ddply(simulation,"iter",summarise,htest = t.test(feature ~ condition,var.equal=TRUE),...)
  x$field <- rep(c("t","df","p","conf.int","means","H0","tails","test","data"))
  stats <- dcast(data=x, iter ~ field, value.var = "htest")
  stats
}

compute.manipulation.regression <- function(simulation,...){
  # allow for processing of a single simulated dataset generated with simulate()
  if( !("iter" %in% names(simulation)) ) {
    simulation$iter <- 1
  }

  x <- ddply(simulation,"iter",summarise,
             htest = {
               m <- lm(confounded.outcome ~ condition)
               c(as.list(summary(m)$coefficients),as.matrix(anova(m)))
             },...)
  n_anova_params <- 2 # condition + residuals
  n_lm_params <- 2    # Intercept + condition[manipulation]
  n_anova_cols <- 5   # df, SS, MSS, F, p
  n_lm_cols <- 4      # estimate, std. error, t, p

  x$field <- rep( c(rep("estimate",n_lm_params)
                    ,rep("std.err",n_lm_params)
                    ,rep("t.val",n_lm_params)
                    ,rep("p.val",n_lm_params)
                    ,rep("df",n_anova_params)
                    ,rep("SS",n_anova_params)
                    ,rep("MSS",n_anova_params)
                    ,rep("F.val",n_anova_params)
                    ,rep("p.val",n_anova_params)
  ))
  # first the terms of the LM, then the "terms" of the ANOVA
  x$term <-  rep( c(
    rep(c("Intercept","condition[manipulation]"),n_lm_cols),
    rep(c("condition", "residual"), n_anova_cols)))
  x$method <- rep( c(rep("lm",n_lm_params*n_lm_cols), rep("anova",n_anova_params*n_anova_cols)) )
  stats <- dcast(data=x, iter  + term + method ~ field, value.var = "htest")
  stats.anova <- stats[stats$method=="anova", c("iter","term","df","SS","MSS","F.val","p.val")]
  stats.lm   <- stats[stats$method=="lm", c("iter","term","estimate","std.err","t.val","p.val")]

  stats <- list(lm=stats.lm,anova=stats.anova)
  stats
}

compute.feature.regression <- function(simulation,...){
  # allow for processing of a single simulated dataset generated with simulate()
  if( !("iter" %in% names(simulation)) ) {
    simulation$iter <- 1
  }

  x <- ddply(simulation,"iter",summarise,
             htest = {
               m <- lm(confounded.outcome ~ feature)
               c(as.list(summary(m)$coefficients),as.matrix(anova(m)))
             },...)
  n_anova_params <- 2 # feature + residuals
  n_lm_params <- 2    # Intercept + feature[manipulation]
  n_anova_cols <- 5   # df, SS, MSS, F, p
  n_lm_cols <- 4      # estimate, std. error, t, p

  x$field <- rep( c(rep("estimate",n_lm_params)
                    ,rep("std.err",n_lm_params)
                    ,rep("t.val",n_lm_params)
                    ,rep("p.val",n_lm_params)
                    ,rep("df",n_anova_params)
                    ,rep("SS",n_anova_params)
                    ,rep("MSS",n_anova_params)
                    ,rep("F.val",n_anova_params)
                    ,rep("p.val",n_anova_params)
  ))
  # first the terms of the LM, then the "terms" of the ANOVA
  x$term <-  rep( c(
    rep(c("Intercept","feature"),n_lm_cols),
    rep(c("feature", "residual"), n_anova_cols)))
  x$method <- rep( c(rep("lm",n_lm_params*n_lm_cols), rep("anova",n_anova_params*n_anova_cols)) )
  stats <- dcast(data=x, iter  + term + method ~ field, value.var = "htest")
  stats.anova <- stats[stats$method=="anova", c("iter","term","df","SS","MSS","F.val","p.val")]
  stats.lm   <- stats[stats$method=="lm", c("iter","term","estimate","std.err","t.val","p.val")]

  stats <- list(lm=stats.lm,anova=stats.anova)
  stats
}

compute.multiple.regression <- function(simulation,...){
  # allow for processing of a single simulated dataset generated with simulate()
  if( !("iter" %in% names(simulation)) ) {
    simulation$iter <- 1
  }

  x <- ddply(simulation,"iter",summarise,
             htest = {
               m <- lm(confounded.outcome ~ condition*feature)
               c(as.list(summary(m)$coefficients),as.matrix(anova(m)))
             },...)
  n_anova_params <- 4 # condition,feature, condition:feature,residuals
  n_lm_params <- 4    # Intercept,condition[manipulation],feature, condition[manipulation]:feature
  n_anova_cols <- 5   # df, SS, MSS, F, p
  n_lm_cols <- 4      # estimate, std. error, t, p

  x$field <- rep( c(rep("estimate",n_lm_params)
                    ,rep("std.err",n_lm_params)
                    ,rep("t.val",n_lm_params)
                    ,rep("p.val",n_lm_params)
                    ,rep("df",n_anova_params)
                    ,rep("SS",n_anova_params)
                    ,rep("MSS",n_anova_params)
                    ,rep("F.val",n_anova_params)
                    ,rep("p.val",n_anova_params)
  ))
  # first the terms of the LM, then the "terms" of the ANOVA
  x$term <-  rep( c(
    rep(c("Intercept","condition[manipulation]","feature","condition[manipulation]:feature"),n_lm_cols),
    rep(c("condition", "feature", "condition:feature","residual"), n_anova_cols)))
  x$method <- rep( c(rep("lm",n_lm_params*n_lm_cols), rep("anova",n_anova_params*n_anova_cols)) )
  stats <- dcast(data=x, iter  + term + method ~ field, value.var = "htest")
  stats.anova <- stats[stats$method=="anova", c("iter","term","df","SS","MSS","F.val","p.val")]
  stats.lm   <- stats[stats$method=="lm", c("iter","term","estimate","std.err","t.val","p.val")]

  stats <- list(lm=stats.lm,anova=stats.anova)
  stats

}

compute.aggregate.results <- function(feat.test,manip.reg,feat.reg,mult.reg){

  confounds     <- feat.test[,c("iter","p")]
  features      <- feat.reg$anova[feat.reg$anova$term != "residual",c("iter","term","p.val")]
  manipulation  <- manip.reg$anova[feat.reg$anova$term != "residual",c("iter","term","p.val")]
  multiple      <- mult.reg$anova[feat.reg$anova$term != "residual",c("iter","term","p.val")]

  names(confounds) <- c("iter","p.val")

  confounds$test <- "stimulus"
  features$test <- "feature.regression"
  manipulation$test <- "manipulation.regression"
  multiple$test <- "multiple.regression"

  stats <- data.frame(iter=confounds$iter)
  stats$pretest <- confounds$p.val
  stats$manipulation.simple <- manipulation$p.val
  stats$feature.simple <- features$p.val
  stats$manipulation.multiple <- multiple$p.val[multiple$term == "condition"]
  stats$feature.multiple <- multiple$p.val[multiple$term == "feature"]

  stats
}
