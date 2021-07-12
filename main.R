# Setting up a global variable for the pkg "knitr" when attached later
# So as to save figures in a separate folder
# setHook(packageEvent("knitr", "attach"),
#         function(...) knitr::opts_chunk$set(echo = FALSE, fig.path="Figures/"))

library(bookdown)
# Render html files
render_book("index.Rmd", "bookdown::gitbook")

# Render pdf files
render_book("index.Rmd", "bookdown::pdf_document2")

# After you have rendered the book locally, you can observe rendered
# html files that are located in docs subfolder.