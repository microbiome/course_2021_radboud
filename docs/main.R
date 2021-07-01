
# This code below builds the Rmd file into a book
authors <- "Leo Lahti, Tuomas Borman, Henrik Eckerman"
library(bookdown)
render_book()

# Instead of render_book, you can run serve_book. The difference is that by serve_book
# you can preview the book on your web browser live. However, when using serve_book you
# should have servr package installed. 

# Installs servr package. Needs only to do once.
# install.packages("servr")
# starts local web browser and serve the HTML output
# serve_book()
