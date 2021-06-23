

# This creates the md files
# knitr::knit("install.Rmd")

# This creates the md files at
# https://microbiome.github.io/course_2021_radboud/

# md files can be converted to html files and to GitBook with GitBook documentation tool
# https://github.com/GitbookIO/gitbook

# Terminal command 'gitbook build ./ docs' creates html files from md files
# that are located in root folder. It stores html files to 'docs' folder. 
# SUMMARY.md includes a list of files that will be rendered.

# Sets the theme
library(ggplot2)
theme_set(theme_bw(20)) 

# Renders notebooks
rmarkdown::render("install.Rmd")
rmarkdown::render("import.Rmd")
rmarkdown::render("explore.Rmd")
rmarkdown::render("alpha.Rmd")
rmarkdown::render("beta.Rmd")
rmarkdown::render("dmm.Rmd")
rmarkdown::render("abundance.Rmd")
