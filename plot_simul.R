library(ggplot2)

dat <- read.table("~/simul.csv",header=T,sep=',')

cbbPalette <- c("grey", "white", "#66CC99", "#9999CC")
cbbPalette <- c("grey", "white", "red", "#9999CC")

#dat[dat$Correlation==0.45,]

dat$Correlation = as.factor(dat$Correlation)

#d2 = dat[dat$Test=="Not Rejected",]

ggplot(dat, aes(x=tests, y=conts, color = Result, shape = NuisanceTest)) + 
	geom_point(alpha=0.5) +
	scale_colour_manual(values=cbbPalette) + 
	ylab("p-value of experimental test") +
	xlab("p-value of nuisance parameter test") +
	facet_wrap(~ Correlation)

