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
library(plyr)
library(reshape2)

source("statfail.R")

shinyServer(function(input, output) {

  runSimulation <- reactive({
    # force update when user clicks on "Run Again"
    input$run
    resimulate(n=input$n.sims
              ,manipulation.effect.size=input$manipulation.effect.size
              ,confound.feature.size=input$confound.feature.size
              ,confound.feature.effect.correlation=input$confound.feature.effect.correlation
              ,n.items=input$n.items)
  })

  runFeatureStats <- reactive({
    simulation <- runSimulation()
    #simulation <- resimulate(n=3,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=1,n.items=20)

    x <- ddply(simulation,"iter",summarise,htest = t.test(feature ~ condition,var.equal=TRUE))
    x$field <- rep(c("t","df","p","conf.int","means","H0","tails","test","data"))
    stats <- dcast(data=x, iter ~ field, value.var = "htest")
    stats
  })

  # runManipulationOurcomeStats <- reactive({
  #   simulation <- runSimulation()
  #   #simulation <- resimulate(n=3,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=1,n.items=20)
  #
  #   x <- ddply(simulation,"iter",summarise,htest = t.test(confounded.outcome ~ condition,var.equal=TRUE))
  #   x$field <- rep(c("t","df","p","conf.int","means","H0","tails","test","data"))
  #   stats <- dcast(data=x, iter ~ field, value.var = "htest")
  #   stats
  # })
  #
  # runFeatureOutcomeStats <- reactive({
  #   simulation <- runSimulation()
  #   #simulation <- resimulate(n=3,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=1,n.items=20)
  #
  #   x <- ddply(simulation,"iter",summarise,htest = t.test(confounded.outcome ~ condition,var.equal=TRUE))
  #   x$field <- rep(c("t","df","p","conf.int","means","H0","tails","test","data"))
  #   stats <- dcast(data=x, iter ~ field, value.var = "htest")
  #   stats
  # })
  #
  # runMultipleRegression <- reactive({
  #   simulation <- runSimulation()
  #   #simulation <- resimulate(n=3,manipulation.effect.size=2,confound.feature.size=1,confound.feature.effect.correlation=1,n.items=20)
  #
  #   x <- ddply(simulation,"iter",summarise,htest = summary(lm(confounded.outcome ~ condition*feature)))
  #   x$field <- rep(c("t","df","p","conf.int","means","H0","tails","test","data"))
  #   stats <- dcast(data=x, iter ~ field, value.var = "htest")
  #   stats
  # })

  output$testing.table <- renderDataTable(runStats())

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
      ggtitle("Stimuli as selected for experiment")
    ggplotly(g)
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
      ggtitle("Simple regression for manipulation")
    ggplotly(g)
  })

  output$plt.feature.regression <- renderPlotly({
    simulation <- subset(runSimulation(), iter == which.sim())
    g <- ggplot(simulation,aes(x=feature,y=confounded.outcome)) +
      geom_smooth(method=lm) +
      ggtitle("Simple regression for feature")
    ggplotly(g)
  })

  output$plt.multiple.regression <- renderPlotly({
    simulation <- subset(runSimulation(), iter == which.sim())
    g <- ggplot(simulation,aes(x=feature,y=confounded.outcome,color=condition,fill=condition)) +
      geom_smooth(method=lm,fullrange=TRUE) +
      guides(fill="none",color="none") +
      ggtitle("Multiple regression for manipulation and feature")
    ggplotly(g)
  })

  #summary(lm(confounded.outcome ~ condition*feature,data=simulation))

})
