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
library(ggplot2)
library(gridExtra)
library(scales)
library(reshape)
library(zoo)

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Inference failure: Confound and control in BBS experiments"),
  withMathJax(),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(h3("Simulation Parameters")
       ,sliderInput("manipulation.effect.size",
                   "Manipulation effect size",
                   min = -1,
                   max = 1,
                   value = 0.5,
                   round = -1)
       ,sliderInput("confound.effect.size",
                   "Confound effect size",
                   min = -1,
                   max = 1,
                   value = 0.3,
                   round = -1)
       ,sliderInput("confound.manipulation.correlation",
                    "Confound-manipulation correlation",
                    min = -1,
                    max = 1,
                    value = 0.6,
                    round = -1)
       ,sliderInput("n.items",
                    "Number of items to draw (from each manipulation-level/group/condition)",
                    min = 10,
                    max = 100,
                    value = 20,
                    round = -1)
       ,sliderInput("n.sims",
                    "Number of simulations to run",
                    min = 1,
                    max = 1000000,
                    value = 1)
       ,actionButton("run",label = "Run simulation (again)")
    ),

    # Show a plot of the generated distribution
    mainPanel(h1("Single Simulation Results")
        ,uiOutput("which.sim")
       ,h1("Repeated Simulation Results")
       ,h1("Theoretical background")
       ,includeMarkdown("inference_failure.md")
    )
  )
))
