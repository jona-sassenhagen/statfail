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
library(plotly)

shinyUI(fluidPage(

  # Application title
  titlePanel("Inference failure: Confound and control in BBS experiments"),
  withMathJax(),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(h3("Simulation Parameters")
       ,sliderInput("manipulation.effect.size",
                   "Difference in outcome variable due to manipulation (Cohen's \\(d\\))",
                   min = -10,
                   max = 10,
                   value = 2,
                   round = -1)
       ,sliderInput("confound.feature.size",
                   "Difference in confounding feature between groups (Cohen's \\(d\\))",
                   min = -10,
                   max = 10,
                   value = 1,
                   round = -1)
       # ,sliderInput("confound.effect.size",
       #              "Difference in outcome variable due to confound (Cohen's \\(d\\))",
       #              min = -10,
       #              max = 10,
       #              value = 1,
       #              round = -1)
       ,sliderInput("confound.feature.effect.correlation",
                    "Impact of confounding feature (correlation between measured confounding feature and outcome variable)",
                    min = -1,
                    max = 1,
                    value = 1.0,
                    round = -1)
       ,sliderInput("n.items",
                    HTML("Number of items to draw </br > (from each manipulation-level)"),
                    min = 10,
                    max = 100,
                    value = 20,
                    round = -1)
       ,sliderInput("n.sims",
                    "Number of simulations to run",
                    min = 1,
                    max = 1000, # This has several second latency on a fast machine with lots of RAM, so we'll cap it here.
                                # If you know enough to tune this yourself, then go ahead -- the time growth curve is
                                # superlinear, perhaps roughly quadratic because of the way R does COW in its memory management
                    value = 1)
       ,actionButton("run",label = "Run simulation (again)")
    ),

    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
          tabPanel("Simulation"
                  ,h1("Single Simulation Results")
                  ,uiOutput("which.sim")
                  ,fluidRow(column(4,plotlyOutput("plt.feature.distribution"))
                            ,column(4,plotlyOutput("plt.manipulation.regression"))
                            ,column(4,plotlyOutput("plt.feature.regression"))
                            )
                  ,fluidRow(column(4,htmlOutput("feature.test")))
                  ,plotlyOutput("plt.multiple.regression")
                  ,h1("Repeated Simulation Results")
          )
         ,tabPanel("Theoretical background",includeMarkdown("inference_failure.md"))
         ,tabPanel("Debugging",tableOutput("testing.table"))
       )
    )
  )
))
