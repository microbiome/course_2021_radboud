

# This creates the md files
# knitr::knit("import.Rmd")

# This creates the html files at
# https://microbiome.github.io/course_2021_radboud/

# Sets the theme
theme_set(theme_bw(20)) 

# Renders notebooks
rmarkdown::render("import.Rmd")
rmarkdown::render("explore.Rmd")
rmarkdown::render("alpha.Rmd")
rmarkdown::render("beta.Rmd")