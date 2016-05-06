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

library(shiny)
# a near drop-in replacement for ggplot2 on the web
library(plotly)
library(car)
library(plyr)
library(reshape2)

source("statfail.R")

shinyServer(function(input, output, session) {

  runSimulation <- reactive({
    # force update when user clicks on "Run Again"
    input$run
    results <- resimulate(n=input$n.sims
              ,manipulation.effect.size=input$manipulation.effect.size
              ,confound.feature.size=input$confound.feature.size
              ,confound.feature.effect.correlation=input$confound.feature.effect.correlation
              ,n.items=input$n.items)

    results$condition <- factor(results$condition,levels=c("control","manipulation"))
    # since there are no other categorical variables to interact with, we keep
    # it simple and use treatment coding. This allows a few shortcuts later, where
    # we assume that the control=0 and treatment=1
    options(decorate.contr.Treatment = "")
    contrasts(results$condition) <- contr.Treatment(levels(results$condition))

    results
  })

  runFeatureStats <- reactive({
    simulation <- runSimulation()
    #simulation <- resimulate(n=3,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=1,n.items=20)

    x <- ddply(simulation,"iter",summarise,htest = t.test(feature ~ condition,var.equal=TRUE))
    x$field <- rep(c("t","df","p","conf.int","means","H0","tails","test","data"))
    stats <- dcast(data=x, iter ~ field, value.var = "htest")
    stats
  })

  runManipulationRegression <- reactive({
    simulation <- runSimulation()
    #simulation <- resimulate(n=3,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=1,n.items=20)

    x <- ddply(simulation,"iter",summarise,
               htest = {
                 m <- lm(confounded.outcome ~ condition)
                 c(as.list(summary(m)$coefficients),as.matrix(anova(m)))
                 })
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
  })

  runFeatureRegression <- reactive({
    simulation <- runSimulation()

    x <- ddply(simulation,"iter",summarise,
               htest = {
                 m <- lm(confounded.outcome ~ feature)
                 c(as.list(summary(m)$coefficients),as.matrix(anova(m)))
               })
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
  })

  runMultipleRegression <- reactive({
    simulation <- runSimulation()
    #simulation <- resimulate(n=3,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=1,n.items=20)

    x <- ddply(simulation,"iter",summarise,
               htest = {
                 m <- lm(confounded.outcome ~ condition*feature)
                 c(as.list(summary(m)$coefficients),as.matrix(anova(m)))
               })
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
  })

  output$which.sim <- renderUI({
    if(input$n.sims > 1){
      sliderInput("which.sim","Iteration to display",min=1,max=input$n.sims,value=42,round=1,animate=FALSE)
    }
    #else{
    #  em("Iteration selection disabled for single iteration.")
    #}
  })

  which.sim <- reactive({
    if(is.null(input$which.sim)){
      1
    }else{
      input$which.sim
    }
  })


  output$plt.feature.distribution <- renderPlotly({
    simulation <- subset(runSimulation(), iter == which.sim())
    g <- ggplot(simulation,aes(color=condition,fill=condition,x=feature)) +
      geom_density(alpha=0.4) +
      #geom_histogram(alpha=0.4) +
      #geom_rug(size=1.5,alpha=0.4) +
      #scale_color_discrete(name="Condition",labels=c("control","manipulation")) +
      guides(fill="none",color="none") +
      ggtitle("Feature distribution across groups")
    ggplotly(g) %>% layout(showlegend = FALSE)
  })

  output$feature.test <- renderUI({
    stats <- runFeatureStats()
    stats <- subset(stats,iter == which.sim())
    # stim_stats$test,"\n with H0: \\(\\mu=",stim_stats$H0,"\\):\n",
    text <- paste("<center>$$t(",stats$df,")=",signif(as.numeric(stats$t),2),", p = ",signif(as.numeric(stats$p),2),"$$")
    if(as.numeric(stats$p) < 0.05){
      text <- paste(text,"\n <font color='red'>SIGNIFICANT</font>")
    }else{
      text <- paste(text,"\n <b>NOT</b> SIGNIFICANT </center>")
    }

    withMathJax(HTML(text))
  })

  output$plt.manipulation.regression <- renderPlotly({
    simulation <- subset(runSimulation(), iter == which.sim())
    g <- ggplot(simulation,aes(x=as.numeric(condition)-1,y=confounded.outcome)) +
      geom_smooth(method=lm) +
      geom_point(aes(color=condition),alpha=0.3) +
      scale_x_continuous("condition",breaks=c(0,1),labels=c("control","manipulation")) +
      ylab("outcome") +
      ggtitle("ANOVA for manipulation")
    ggplotly(g)  %>% layout(showlegend = FALSE)
  })

  output$manipulation.regression <- renderUI({
    stats <- runManipulationRegression()
    stats.lm <- subset(stats$lm,iter == which.sim())
    stats.anova <- subset(stats$anova,iter == which.sim())

    ndf <- stats.anova[stats.anova$term == "condition", "df"]
    ddf <- stats.anova[stats.anova$term == "residual", "df"]
    f   <- stats.anova[stats.anova$term == "condition", "F.val"]
    p   <- stats.anova[stats.anova$term == "condition", "p.val"]

    text <- paste("<center>$$F(", ndf, "," , ddf, ")=",signif(as.numeric(f),2),", p = ",signif(as.numeric(p),2),"$$")
    if(as.numeric(p) < 0.05){
      text <- paste(text,"\n <font color='red'>SIGNIFICANT</font>")
    }else{
      text <- paste(text,"\n <b>NOT</b> SIGNIFICANT")
    }

    text <- paste(text,"</center>")

    df <- ddf
    beta <- stats.lm[stats.lm$term == "condition[manipulation]", "estimate"]
    se  <- stats.lm[stats.lm$term == "condition[manipulation]", "std.err"]
    t   <- stats.lm[stats.lm$term == "condition[manipulation]", "t.val"]
    p   <- stats.lm[stats.lm$term == "condition[manipulation]", "p.val"]

    text.beta <- paste0("beta=",signif(as.numeric(beta),2),", se=",signif(as.numeric(se),2),
                       ", t(",df,")=",signif(as.numeric(t),2),
                       ", p = ",signif(as.numeric(p),2))

    div(withMathJax(HTML(text)), title=text.beta)
  })

  output$plt.feature.regression <- renderPlotly({
    simulation <- subset(runSimulation(), iter == which.sim())
    g <- ggplot(simulation,aes(x=feature,y=confounded.outcome)) +
      geom_smooth(method=lm) +
      geom_point(aes(color=condition),alpha=0.3) +
      ylab("outcome") +
      ggtitle("Simple regression for feature")
    ggplotly(g) %>% layout(showlegend = FALSE)
  })

  output$feature.regression <- renderUI({
    stats <- runFeatureRegression()
    stats.lm <- subset(stats$lm,iter == which.sim())
    stats.anova <- subset(stats$anova,iter == which.sim())

    # since we only have one non-intercept parameter in the model,
    # the F-test on the entire model reduces to the ANOVA F-test
    # on that parameter

    ndf <- stats.anova[stats.anova$term == "feature", "df"]
    ddf <- stats.anova[stats.anova$term == "residual", "df"]
    f   <- stats.anova[stats.anova$term == "feature", "F.val"]
    p   <- stats.anova[stats.anova$term == "feature", "p.val"]

    text <- paste("<center>$$F(", ndf, "," , ddf, ")=",signif(as.numeric(f),2),", p = ",signif(as.numeric(p),2),"$$")
    if(as.numeric(p) < 0.05){
      text <- paste(text,"\n <font color='red'>SIGNIFICANT</font>")
    }else{
      text <- paste(text,"\n <b>NOT</b> SIGNIFICANT")
    }
    text <- paste(text,"</center>")

    df <- ddf
    beta <- stats.lm[stats.lm$term == "feature", "estimate"]
    se  <- stats.lm[stats.lm$term == "feature", "std.err"]
    t   <- stats.lm[stats.lm$term == "feature", "t.val"]
    p   <- stats.lm[stats.lm$term == "feature", "p.val"]

    text.beta <- paste0("beta=",signif(as.numeric(beta),2),", se=",signif(as.numeric(se),2),
                        ", t(",df,")=",signif(as.numeric(t),2),
                        ", p = ",signif(as.numeric(p),2))

    div(withMathJax(HTML(text)), title=text.beta)
  })

  output$plt.multiple.regression <- renderPlotly({
    simulation <- subset(runSimulation(), iter == which.sim())
    g <- ggplot(simulation,aes(x=feature,y=confounded.outcome,color=condition,fill=condition)) +
      geom_smooth(method=lm,fullrange=TRUE) +
      geom_point(alpha=0.3) +
      ylab("outcome") +
      guides(fill="none",color="none") +
      ggtitle("Multiple regression for manipulation and feature")
    ggplotly(g) %>% layout(showlegend = FALSE)
  })

  output$multiple.regression <- renderTable({
    stats <- runMultipleRegression()
    stats.lm <- subset(stats$lm,iter == which.sim())

    rownames(stats.lm) <- stats.lm$term
    stats.lm <- stats.lm[,c("estimate","std.err","t.val","p.val")]

    # by doing the rounding here, we can use xtable to do the collapsing if need be
    stats.lm$estimate <- signif(as.numeric(stats.lm$estimate),2)
    stats.lm$std.err <- signif(as.numeric(stats.lm$std.err),2)
    stats.lm$t.val <- round(as.numeric(stats.lm$t.val),1)
    stats.lm$p.val <- signif(as.numeric(stats.lm$p.val),2)

    names(stats.lm) <- c("Beta","SE","t","p")

    stats.lm

  },include.rownames=TRUE,digits=c(0,2,2,2,2),display=c("s","s","g","f","g"))

  output$multiple.regression.sigs <- renderTable({
    stats <- runMultipleRegression()
    stats.anova <- subset(stats$anova,iter == which.sim())

    row.names(stats.anova) <- stats.anova$term
    stats.anova <- stats.anova[, c("df","SS","MSS","F.val","p.val")]

    # by doing the rounding here, we can use xtable to do the collapsing if need be
    stats.anova$SS <- round(as.numeric(stats.anova$SS),2)
    stats.anova$MSS <- round(as.numeric(stats.anova$MSS),2)
    stats.anova$F.val <- round(as.numeric(stats.anova$MSS),2)
    stats.anova$p.val <- signif(as.numeric(stats.anova$p.val),2)

    stats.anova$sig <- NA
    stats.anova$sig[stats.anova$p.val < 0.05] <- "<font color='red'>SIGNIFICANT</font>"
    stats.anova$sig[stats.anova$p.val > 0.05] <-"<b>NOT</b> SIGNIFICANT"

    names(stats.anova) <- c("df","SS","MSS","F","p","")

    stats.anova

  },include.rownames=TRUE,digits=c(0,0,0,0,2,2,0),display=c("s","d","f","f","f","g","s"),sanitize.text.function=function(x) x)

  output$single.sim.results <- renderUI({
    agg <- runAggregateResults()
    cmp <- subset(agg, iter == which.sim())
    cmp <- lapply(cmp,function(x) x < 0.05)

    text <- "<ul>"

    if(cmp$pretest){
      text <- paste0(text,"<li>The pretest rejected your manipulation as confounded. ")

      if(!cmp$feature.multiple){
        text <- paste0(text,"<li>However, in the multiple regression, the confounding feature did not reach significance. ")
      }else{
        text <- paste0(text,"<li>And, indeed, in the multiple regression, the confounding feature did achieve significance. ")
      }

      if(cmp$manipulation.multiple){
        text <- paste0(text,"<li>Nonetheless, your manipulation of interest was still significant in the multiple regression. ")
      }else{
        text <- paste0(text,"<li>Moreover, your manipulation of interest failed to achieve significance. ")
      }
    }else{
      text <- paste0(text,"<li>The pretest accepted your manipulation as <b>not</b> confounded. ")

      if(cmp$feature.multiple){
        text <- paste0(text,"<li>However, in the multiple regression, the confounding feature did significance! ")
      }else{
        text <- paste0(text,"<li>This was matched by the confounding feature failing to achieve significance in the multiple regression. ")
      }

      if(cmp$manipulation.multiple){
        text <- paste0(text,"<li>Your manipulation of interest was significant in the multiple regression. ")
      }else{
        text <- paste0(text,"<li>Your manipulation of interest failed to achieve significance in the multiple regression. ")
      }
    }

    text <- paste0(text,"</ul>")

    HTML(text)
  })

  runAggregateResults <- reactive({
    feat.test <- runFeatureStats()

    feat.reg <- runFeatureRegression()
    manip.reg <- runManipulationRegression()
    mult.reg <- runMultipleRegression()

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
  })

  output$tbl.aggregate.results <- renderTable({
    agg <- runAggregateResults()
    cmp <- lapply(agg,function(x) x < 0.05)
    cmp <- as.data.frame(cmp)
    n <- nrow(cmp)
    rejections <- sum(cmp$pretest)
    manipulation_still_significant <- sum(with(subset(cmp,pretest), manipulation.multiple))
    feature_has_no_effect <- sum(with(subset(cmp,pretest), !feature.simple))
    feature_irrelevant_in_multiple <- sum(with(subset(cmp,pretest), !feature.multiple))

    vals <- c(rejections, manipulation_still_significant, feature_has_no_effect, feature_irrelevant_in_multiple)

    out <- data.frame(count=vals,percentage=signif(vals/n,2)*100)

    rownames(out) <- c("Rejected studies"
                       ,"where the manipulation was still significant in the multiple regression"
                       ,"where the feature had no effect on the outcome in simple regression"
                       ,"where the feature was irrelevant in the multiple regression")

    out
  })

  # output$plt.feature.distribution.all <- renderPlotly({
  #   simulation <- runSimulation()
  #   g <- ggplot(simulation,aes(color=condition,fill=condition,x=feature)) +
  #     geom_density(alpha=0.4) +
  #     #geom_histogram(alpha=0.4) +
  #     #geom_rug(size=1.5,alpha=0.4) +
  #     #scale_color_discrete(name="Condition",labels=c("control","manipulation")) +
  #     guides(fill="none",color="none") +
  #     facet_wrap(~iter) +
  #     ggtitle("Feature distribution across groups")
  #   ggplotly(g) %>% layout(showlegend = FALSE)
  # })
  #
  # output$plt.multiple.regression.all <- renderPlotly({
  #   simulation <- runSimulation()
  #   g <- ggplot(simulation,aes(x=feature,y=confounded.outcome,color=condition,fill=condition)) +
  #     geom_smooth(method=lm,fullrange=TRUE) +
  #     geom_point(alpha=0.3) +
  #     ylab("outcome") +
  #     guides(fill="none",color="none") +
  #     facet_wrap(~iter) +
  #     ggtitle("Multiple regression for manipulation and feature")
  #   ggplotly(g) %>% layout(showlegend = FALSE)
  # })

})
