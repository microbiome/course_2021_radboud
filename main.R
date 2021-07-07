
# This code below builds the Rmd file into a book
authors <- "Leo Lahti, Tuomas Borman, Henrik Eckermann"
library(bookdown)
render_book()

## Seemingly folders named with an underscored at beginning are skipped or hidden at github 
## Creating a duplicate of the output directory where HTML figures are without underscore
## so as the book works locally with a web-browser and hopefully when browsed from github
dir.create("docs/main_files");file.copy(list.files("docs/_main_files", full.names = TRUE),
                                        "docs/main_files",recursive = TRUE, copy.mode = TRUE)

# Instead of render_book, you can run serve_book. The difference is that by serve_book
# you can preview the book on your web browser live. However, when using serve_book you
# should have servr package installed. 

# Installs servr package. Needs only to do once.
# install.packages("servr")
# starts local web browser and serve the HTML output
# serve_book()
