# Setting up a global variable for the pkg "knitr" when attached later
# So as to save figures in a separate folder
# setHook(packageEvent("knitr", "attach"),
#         function(...) knitr::opts_chunk$set(echo = FALSE, fig.path="Figures/"))

# This code below builds the Rmd file into a book
authors <- "Leo Lahti, Tuomas Borman, Henrik Eckermann, Chouaib Benchraka"
# Read pre-build data objects into the session
se <- readRDS(file = "data/se.rds")
tse <- readRDS(file = "data/tse.rds")

library(bookdown)
# Render pdf files
render_book("index.Rmd", "bookdown::pdf_book")

# Render html files
render_book("index.Rmd", "bookdown::gitbook")

# After you have rendered the book locally, you can observe rendered html files
# that are located in docs subfolder.
