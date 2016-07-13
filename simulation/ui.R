# Copyright 2016, Phillip Alday
#
# This file is part of statfail.
#
# Statfail is free software: you can redistribute it and/or modify
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
# add this so that the includeMarkdown() stuff works on shinyapps.io
library(rmarkdown)

shinyUI(fluidPage(

  # Application title
  titlePanel("A common misapplication of statistical inference: nuisance control with null-hypothesis significance tests"),
  withMathJax(),
  HTML("<i>If you're going to do lots of computations, please run the app locally so that server time remains available for others.</i>"),
  HTML("<p><i>Small screen and the output overlaps horizontally? Try making your window <b>even narrower</b> to force single-column mode.</i>"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(h3("Simulation Parameters")
       ,sliderInput("manipulation.effect.size",
                   "Effect of manipulation (Cohen's \\(d\\))",
                   min = -5,
                   max = 10,
                   value = 2,
                   step = 0.1)
       ,sliderInput("confound.feature.size",
                   "Difference in confounding feature between groups (Cohen's \\(d\\))",
                   min = -5,
                   max = 5,
                   value = 1.0,
                   step = 0.1)
       ,sliderInput("confound.feature.effect.correlation",
                    "Impact of confounding feature (correlation between confounding feature and outcome)",
                    min = -1,
                    max = 1,
                    value = 1.0,
                    step = 0.1)
       ,sliderInput("n.items",
                    HTML("Number of items to draw (per group)"),
                    min = 10,
                    max = 100,
                    value = 20,
                    step = 1)
       ,sliderInput("n.sims",
                    "Number of simulations to run",
                    min = 1,
                    max = 1000, # This has several second latency on a fast machine with lots of RAM, so we'll cap it here.
                                # If you know enough to tune this yourself, then go ahead -- the time growth curve is
                                # superlinear, perhaps roughly quadratic because of the way R does COW in its memory management
                    value = 1)
       ,actionButton("run",label = "Run simulation (again)")
       ,width = 2
    ),

    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
          tabPanel("Simulation"
                  ,h1("Single Simulation Results")
                  ,uiOutput("which.sim")
                  ,h2("Detection with traditional tests")
                  ,fluidRow(column(4,plotlyOutput("plt.feature.distribution"),htmlOutput("feature.test"))
                            ,column(4,plotlyOutput("plt.manipulation.regression"),htmlOutput("manipulation.regression"))
                            ,column(4,plotlyOutput("plt.feature.regression"),htmlOutput("feature.regression"))
                            )
                  ,h2("Multiple regression")
                  ,fluidRow(column(7,plotlyOutput("plt.multiple.regression"),includeMarkdown("interpret_multiple.md"))
                            ,column(5,h3("Linear Model"),tableOutput("multiple.regression"),h3("ANOVA"),htmlOutput("multiple.regression.sigs")))
                  ,h2("Comparison")
                  ,htmlOutput("single.sim.results")
                  ,h1("Repeated Simulation Results")
                  ,tableOutput("tbl.aggregate.results")
                  # ,tabsetPanel(
                  #   tabPanel("Feature distribution across groups", plotlyOutput("plt.feature.distribution.all"))
                  #   ,tabPanel("Multiple regression", plotlyOutput("plt.multiple.regression.all"))
                  # )
          )
          ,tabPanel("Simulation notes",includeMarkdown("simulation_notes.md"))
          ,tabPanel("Theoretical background",includeMarkdown("inference_failure.md"))
          ,tabPanel("About",includeMarkdown("about.md"))
       )
    )
  )
))
