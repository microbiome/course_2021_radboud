# Setting up a global variable for the pkg "knitr" when attached later
# So as to save figures in a separate folder
# setHook(packageEvent("knitr", "attach"),
#         function(...) knitr::opts_chunk$set(echo = FALSE, fig.path="Figures/"))

# This code below builds the Rmd file into a book
authors <- "Leo Lahti, Tuomas Borman, Henrik Eckermann, Chouaib Benchraka"

library(bookdown)
# Render html files
render_book("index.Rmd", "bookdown::gitbook")

# Render pdf files
render_book("index.Rmd", "bookdown::pdf_document2")

# Instead of render_book, you can run serve_book. The difference is that by serve_book
# you can preview the book on your web browser live. However, when using serve_book you
# should have servr package installed. 

# Installs servr package. Needs only to do once.
# install.packages("servr")
# starts local web browser and serve the HTML output
serve_book()
