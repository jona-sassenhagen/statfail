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
#library(scales)
#library(reshape2)
#library(zoo)

shinyServer(function(input, output) {

  runSimulation <- reactive({
    # force update when user clicks on "Run Again"
    input$run
    with(input,resimulate(n=input$n.sims
                          ,manipulation.effect.size=manipulation.effect.size
                          ,confound.feature.size=confound.feature.size
                          ,confound.feature.effect.correlation=confound.feature.effect.correlation
                          ,n.items=n.items))
  })

  output$which.sim <- renderUI({
    if(input$n.sims > 1){
      sliderInput("which.sim","Iteration to display",min=1,max=input$n.sims,value=42)
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

  output$simulation.table <- renderDataTable(runSimulation())

  output$plt.population.distribution <- renderPlot({
  })

  output$plt.sample.distribution <- renderPlot({
    simulation <- subset(runSimulation(), iter == which.sim())
    print(simulation)
    ggplot(simulation) + geom_density(aes(color=condition,fill=condition,x=feature),alpha=0.4)
  })
  output$distPlot <- renderPlot({

    input$manipulation.effect.size
    input$confound.effect.size
    #input$confound.manipulation.correlation
    input$n.items
    input$n.sims

  })

})
