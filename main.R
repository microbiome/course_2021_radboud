

# This creates the md files
# knitr::knit("import.Rmd")

# This creates the html files at
# https://microbiome.github.io/course_2021_radboud/

rmarkdown::render("import.Rmd")
rmarkdown::render("explore.Rmd")
rmarkdown::render("alpha.Rmd")
