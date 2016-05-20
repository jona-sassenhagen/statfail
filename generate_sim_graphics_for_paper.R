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

# This script just extracts the static simulation (published on RPubs) and
# runs it to create graphics for the paper.
# This guarantees that the figures and simulation are the same for both.

library(knitr)
script <- tempfile()
# extract code
params <- data.frame(n=5000,cores=parallel::detectCores(),use_plotly=FALSE)
purl('simulation/statfail.Rmd',output=script, documentation=0)
code <- scan(script,what="character",sep="\n")
# remove the plot displaying bits
code <- code[grep("ggplotly",code,invert=TRUE)]
# skip the bit where RMarkdown sets the params field
code <- code[4:length(code)]
# execute the simulation
startwd <- setwd(normalizePath('simulation'))
eval(parse(text=code))

setwd(startwd)
# save the graphics
ggsave("sim-accept.pdf",gg.accept,width=7.5,height=6)
ggsave("sim-reject.pdf",gg.reject,width=7.5,height=6)
