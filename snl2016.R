library(ggplot2)
library(car)
library(plyr)
library(reshape2)

source("simulation/statfail.R")
set.seed(42)

results <- resimulate(n=1
                      ,manipulation.effect.size=2
                      ,confound.feature.size=1
                      ,confound.feature.effect.correlation=1
                      ,n.items=20)
results$condition <- factor(results$condition,levels=c("control","manipulation"))
# since there are no other categorical variables to interact with, we keep
# it simple and use treatment coding. This allows a few shortcuts later, where
# we assume that the control=0 and treatment=1
options(decorate.contr.Treatment = "")
contrasts(results$condition) <- contr.Treatment(levels(results$condition))

g <- ggplot(results,aes(color=condition,fill=condition,x=feature)) +
  geom_density(alpha=0.4) +
  #geom_histogram(alpha=0.4) +
  geom_rug(size=1.5,alpha=0.4) +
  #scale_color_discrete(name="Condition",labels=c("control","manipulation")) +
  guides(fill="none",color="none") +
  ggtitle("Feature distribution") + theme(legend.position = "none")

ggsave("figures/feature.pdf",g,height=4,width=4)

g <- ggplot(results,aes(x=as.numeric(condition)-1,y=confounded.outcome)) +
  geom_smooth(method=lm) +
  geom_point(aes(color=condition),alpha=0.4) +
  scale_x_continuous("condition",breaks=c(0,1),labels=c("control","manipulation")) +
  ylab("outcome") +
  ggtitle("ANOVA for manipulation") + theme(legend.position = "none")

ggsave("figures/anova.pdf",g,height=4,width=4)

g <- ggplot(results,aes(x=feature,y=confounded.outcome)) +
  geom_smooth(method=lm) +
  geom_point(aes(color=condition),alpha=0.4) +
  ylab("outcome") +
  ggtitle("Regression for feature") + theme(legend.position = "none")

ggsave("figures/feature_regression.pdf",g,height=4,width=4)

g <- ggplot(results,aes(x=feature,y=confounded.outcome,color=condition,fill=condition)) +
  geom_smooth(method=lm,fullrange=TRUE) +
  geom_point(alpha=0.4) +
  ylab("outcome") +
  guides(fill="none",color="none") +
  ggtitle("Multiple regression for manipulation and feature") + theme(legend.position = "none")

ggsave("figures/multiple_regression.pdf",g,height=4,width=12)

print(summary(lm(confounded.outcome~condition*feature,results)))

