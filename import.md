---
title: "Import data"
output: html_notebook
---


This notebook imports _biom_ data to a _TreeSummarizedExperiment_ object. 

You are expected to have the necessary data files in a local subfolder
"data".


## Initialization

[Install](install.R) the necessary R packages if you have not already
done it.

Then load the R packages.



```r
library("mia")
```

Define source file paths.


```r
biom_file_path <- "data/table-with-taxonomy.biom"
sample_meta_file_path <- "data/WesternDietSert_extendedTimeComparisonsv4.txt"
tree_file_path <- "data/tree.nwk"
```


Create TSE object from biom file and investigate it.


```r
tse <- loadFromBiom(biom_file_path)
```


## Investigate the R data object

We have now imported the data in R. Let us investigate its contents.


```r
print(tse)
```

```
## class: TreeSummarizedExperiment 
## dim: 2805 88 
## metadata(0):
## assays(1): counts
## rownames(2805): 429528823edb55fa5e24e1f20b322a57
##   b821f00f48e4651623a105fb77872e44 ... 907b143b8c858095025a8c264731d477
##   743aa3d9860dd464ef41b9ebd1b1e3c1
## rowData names(8): confidence taxonomy1 ... taxonomy6 taxonomy7
## colnames(88): 100 101 ... 186 99
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: NULL
## rowTree: NULL
## colLinks: NULL
## colTree: NULL
```


Counts include the abundance table from biom file. Let us just use first cols and rows.


```r
assays(tse)$counts[1:3, 1:3]
```

```
##                                    100    101    102
## 429528823edb55fa5e24e1f20b322a57     0      0      0
## b821f00f48e4651623a105fb77872e44 55026 109435 118072
## 0dcefd65571849dd41395e1d88748cee 88016  20218   2202
```

Now rowdata includes taxonomical information from biom file. The head() command
shows just the beginning of the data table for an overview.


```r
knitr::kable(head(rowData(tse)))
```



|                                 |confidence         |taxonomy1     |taxonomy2            |taxonomy3             |taxonomy4               |taxonomy5                |taxonomy6                 |taxonomy7                 |
|:--------------------------------|:------------------|:-------------|:--------------------|:---------------------|:-----------------------|:------------------------|:-------------------------|:-------------------------|
|429528823edb55fa5e24e1f20b322a57 |0.9999999629215087 |D_0__Bacteria |D_1__Firmicutes      |D_2__Bacilli          |D_3__Lactobacillales    |D_4__Streptococcaceae    |D_5__Lactococcus          |                          |
|b821f00f48e4651623a105fb77872e44 |0.9162987510638083 |D_0__Bacteria |D_1__Bacteroidetes   |D_2__Bacteroidia      |D_3__Bacteroidales      |D_4__Muribaculaceae      |D_5__uncultured bacterium |D_6__uncultured bacterium |
|0dcefd65571849dd41395e1d88748cee |0.9101147578136789 |D_0__Bacteria |D_1__Verrucomicrobia |D_2__Verrucomicrobiae |D_3__Verrucomicrobiales |D_4__Akkermansiaceae     |D_5__Akkermansia          |D_6__uncultured bacterium |
|6fe357d6683c05da84a54a5c2a6fbe9e |0.9974611252130304 |D_0__Bacteria |D_1__Bacteroidetes   |D_2__Bacteroidia      |D_3__Bacteroidales      |D_4__Muribaculaceae      |D_5__uncultured bacterium |D_6__uncultured bacterium |
|9d91175efc096377a71b6ea55cc7679e |0.9942398133795611 |D_0__Bacteria |D_1__Firmicutes      |D_2__Erysipelotrichia |D_3__Erysipelotrichales |D_4__Erysipelotrichaceae |D_5__Faecalibaculum       |D_6__uncultured bacterium |
|388b5f3e63fdec5ad3d574070b253ca0 |0.9865806875655985 |D_0__Bacteria |D_1__Bacteroidetes   |D_2__Bacteroidia      |D_3__Bacteroidales      |D_4__Muribaculaceae      |D_5__uncultured bacterium |D_6__uncultured bacterium |


We notice that the imported biom file did not contain sample meta data
yet, so it includes empty data frame


```r
head(colData(tse))
```

```
## DataFrame with 6 rows and 0 columns
```


## Add side information

Let us add a phylogenetic tree.


```r
# Read the tree 
tree <- ape::read.tree(tree_file_path)

# Adds tree to rowTree
rowTree(tse) <- tree

# Check
head(tse)
```

```
## class: TreeSummarizedExperiment 
## dim: 6 88 
## metadata(0):
## assays(1): counts
## rownames(6): 429528823edb55fa5e24e1f20b322a57
##   b821f00f48e4651623a105fb77872e44 ... 9d91175efc096377a71b6ea55cc7679e
##   388b5f3e63fdec5ad3d574070b253ca0
## rowData names(8): confidence taxonomy1 ... taxonomy6 taxonomy7
## colnames(88): 100 101 ... 186 99
## colData names(0):
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (6 rows)
## rowTree: 1 phylo tree(s) (2805 leaves)
## colLinks: NULL
## colTree: NULL
```

Now rowTree includes phylogenetic tree:


```r
head(rowTree(tse))
```

Add sample meta data file


```r
# We use this to check what type of data is it
# read.table(sample_meta_file_path)

# It seems like a comma separated file and includes headers
# Let us read it and then convert from data.frame to DataFrame
# (required for our purposes)
sample_meta <- 
sample_meta <- DataFrame(read.table(sample_meta_file_path, sep = ",", header = TRUE))

# Then it can be added to colData
colData(tse) <- sample_meta
```

Now colData includes sample metadata. Use kable to print it more nicely.


```r
knitr::kable(head(colData(tse)))
```



| sample.id|MouseID_recoded |All           |Genotype |Diet    |Timepoint |Timepoint1vs2WTcontrol |Timepoint1vs2WTWestern |Timepoint1vs2HETcontrol |Timepoint1vs2HETWestern |Timepoint1vs2KOcontrol |Timepoint1vs2KOWestern |Timepoint1ControlWTvsHET |Timepoint1ControlWTvsKO |Timepoint1ControlHETvsKO |
|---------:|:---------------|:-------------|:--------|:-------|:---------|:----------------------|:----------------------|:-----------------------|:-----------------------|:----------------------|:----------------------|:------------------------|:-----------------------|:------------------------|
|        99|41_1            |KO_t1_western |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       100|42_1            |KO_t1_western |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       101|13_1            |KO_t1_control |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       102|14_1            |KO_t1_control |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       103|15_1            |KO_t1_control |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       104|16_1            |KO_t1_control |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |


