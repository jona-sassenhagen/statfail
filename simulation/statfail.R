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

simulate <- function(manipulation.effect.size, confound.effect.size, confound.feature.size, n.items){
  control <- rnorm(n.items,mean=0)
  manipulation <- control + rnorm(n.items,mean=manipulation.effect.size)
  confound <- rnorm(n.items,mean=confound.effect.size)

  control.feature <- rnorm(n.items,0)
  manipulation.feature <- rnorm(n.items, mean=confound.feature.size)


  # # http://stats.stackexchange.com/a/15035/26743
  # #
  # cfeature <- rnorm(n.items,mean=0)
  # ceffect <- rnorm(n.items,mean=confound.feature.size)
  # X <- cbind(cfeature,ceffect)
  #
  # rho <- 0.5
  # C <- matrix(rho, nrow = 2, ncol = 2)
  # diag(C) <- 1
  # C <- chol(C)
  #
  # XC <-  X %*% C
  #
  # cor(XC[,1],XC[,2])

  outcomes <- data.frame(item=1:n.items,
                        control=control,
                        manipulation=manipulation)
  features <- data.frame(item=1:n.items,
                        control=control.feature,
                        manipulation=manipulation.feature)

  outcomes <- melt(outcomes,id.vars="item",variable.name="condition",value.name="outcome")
  features <- melt(features,id.vars="item",variable.name="condition",value.name="feature")

  results <- join(outcomes,features,by=c("item","condition"))

  results
}

x <- simulate(manipulation.effect.size=2,confound.effect.size=1,confound.feature.size=1,n.items=20)
summary(lm(manipulation ~ control, data=x))



resimulate <- function(...,n){

}