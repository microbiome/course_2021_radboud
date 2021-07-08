
# This code below builds the Rmd file into a book
authors <- "Leo Lahti, Tuomas Borman, Henrik Eckermann"
# Read pre-build data objects into the session
se <- readRDS(file = "data/se.rds")
tse <- readRDS(file = "data/tse.rds")

library(bookdown)
render_book()

# After you have rendered the book locally, you can observe rendered html files
# that are located in docs subfolder.
