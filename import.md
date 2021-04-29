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
head(rowData(tse))
```

```
## DataFrame with 6 rows and 8 columns
##                                          confidence     taxonomy1
##                                         <character>   <character>
## 429528823edb55fa5e24e1f20b322a57 0.9999999629215087 D_0__Bacteria
## b821f00f48e4651623a105fb77872e44 0.9162987510638083 D_0__Bacteria
## 0dcefd65571849dd41395e1d88748cee 0.9101147578136789 D_0__Bacteria
## 6fe357d6683c05da84a54a5c2a6fbe9e 0.9974611252130304 D_0__Bacteria
## 9d91175efc096377a71b6ea55cc7679e 0.9942398133795611 D_0__Bacteria
## 388b5f3e63fdec5ad3d574070b253ca0 0.9865806875655985 D_0__Bacteria
##                                             taxonomy2             taxonomy3
##                                           <character>           <character>
## 429528823edb55fa5e24e1f20b322a57      D_1__Firmicutes          D_2__Bacilli
## b821f00f48e4651623a105fb77872e44   D_1__Bacteroidetes      D_2__Bacteroidia
## 0dcefd65571849dd41395e1d88748cee D_1__Verrucomicrobia D_2__Verrucomicrobiae
## 6fe357d6683c05da84a54a5c2a6fbe9e   D_1__Bacteroidetes      D_2__Bacteroidia
## 9d91175efc096377a71b6ea55cc7679e      D_1__Firmicutes D_2__Erysipelotrichia
## 388b5f3e63fdec5ad3d574070b253ca0   D_1__Bacteroidetes      D_2__Bacteroidia
##                                               taxonomy4              taxonomy5
##                                             <character>            <character>
## 429528823edb55fa5e24e1f20b322a57   D_3__Lactobacillales  D_4__Streptococcaceae
## b821f00f48e4651623a105fb77872e44     D_3__Bacteroidales    D_4__Muribaculaceae
## 0dcefd65571849dd41395e1d88748cee D_3__Verrucomicrobia..   D_4__Akkermansiaceae
## 6fe357d6683c05da84a54a5c2a6fbe9e     D_3__Bacteroidales    D_4__Muribaculaceae
## 9d91175efc096377a71b6ea55cc7679e D_3__Erysipelotricha.. D_4__Erysipelotricha..
## 388b5f3e63fdec5ad3d574070b253ca0     D_3__Bacteroidales    D_4__Muribaculaceae
##                                               taxonomy6              taxonomy7
##                                             <character>            <character>
## 429528823edb55fa5e24e1f20b322a57       D_5__Lactococcus                       
## b821f00f48e4651623a105fb77872e44 D_5__uncultured bact.. D_6__uncultured bact..
## 0dcefd65571849dd41395e1d88748cee       D_5__Akkermansia D_6__uncultured bact..
## 6fe357d6683c05da84a54a5c2a6fbe9e D_5__uncultured bact.. D_6__uncultured bact..
## 9d91175efc096377a71b6ea55cc7679e    D_5__Faecalibaculum D_6__uncultured bact..
## 388b5f3e63fdec5ad3d574070b253ca0 D_5__uncultured bact.. D_6__uncultured bact..
```


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
knitr::kable(colData(tse))
```



| sample.id|MouseID_recoded |All            |Genotype |Diet    |Timepoint |Timepoint1vs2WTcontrol |Timepoint1vs2WTWestern |Timepoint1vs2HETcontrol |Timepoint1vs2HETWestern |Timepoint1vs2KOcontrol |Timepoint1vs2KOWestern |Timepoint1ControlWTvsHET |Timepoint1ControlWTvsKO |Timepoint1ControlHETvsKO |
|---------:|:---------------|:--------------|:--------|:-------|:---------|:----------------------|:----------------------|:-----------------------|:-----------------------|:----------------------|:----------------------|:------------------------|:-----------------------|:------------------------|
|        99|41_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       100|42_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       101|13_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       102|14_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       103|15_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       104|16_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       105|21_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       106|22_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       107|23_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       108|24_1            |KO_t1_control  |ko       |Control |T1        |NA                     |NA                     |NA                      |NA                      |KO_t1_control          |NA                     |NA                       |KO_t1_control           |KO_t1_control            |
|       109|45_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       110|31_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       111|33_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       112|34_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       113|44_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       114|35_1            |KO_t1_western  |ko       |Western |T1        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t1_western          |NA                       |NA                      |NA                       |
|       115|81_1            |HET_t1_control |het      |Control |T1        |NA                     |NA                     |HET_t1_control          |NA                      |NA                     |NA                     |HET_t1_control           |NA                      |HET_t1_control           |
|       116|52_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       117|53_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       118|54_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       119|55_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       120|61_1            |HET_t1_control |het      |Control |T1        |NA                     |NA                     |HET_t1_control          |NA                      |NA                     |NA                     |HET_t1_control           |NA                      |HET_t1_control           |
|       121|82_1            |HET_t1_control |het      |Control |T1        |NA                     |NA                     |HET_t1_control          |NA                      |NA                     |NA                     |HET_t1_control           |NA                      |HET_t1_control           |
|       122|63_1            |HET_t1_control |het      |Control |T1        |NA                     |NA                     |HET_t1_control          |NA                      |NA                     |NA                     |HET_t1_control           |NA                      |HET_t1_control           |
|       123|64_1            |HET_t1_control |het      |Control |T1        |NA                     |NA                     |HET_t1_control          |NA                      |NA                     |NA                     |HET_t1_control           |NA                      |HET_t1_control           |
|       124|65_1            |HET_t1_control |het      |Control |T1        |NA                     |NA                     |HET_t1_control          |NA                      |NA                     |NA                     |HET_t1_control           |NA                      |HET_t1_control           |
|       125|86_1            |HET_t1_control |het      |Control |T1        |NA                     |NA                     |HET_t1_control          |NA                      |NA                     |NA                     |HET_t1_control           |NA                      |HET_t1_control           |
|       126|72_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       127|73_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       128|74_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       129|75_1            |HET_t1_western |het      |Western |T1        |NA                     |NA                     |NA                      |HET_t1_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       130|101_1           |WT_t1_western  |wt       |Western |T1        |NA                     |WT_t1_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       131|112_1           |WT_t1_control  |wt       |Control |T1        |WT_t1_control          |NA                     |NA                      |NA                      |NA                     |NA                     |WT_t1_control            |WT_t1_control           |NA                       |
|       132|113_1           |WT_t1_control  |wt       |Control |T1        |WT_t1_control          |NA                     |NA                      |NA                      |NA                     |NA                     |WT_t1_control            |WT_t1_control           |NA                       |
|       133|104_1           |WT_t1_western  |wt       |Western |T1        |NA                     |WT_t1_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       134|115_1           |WT_t1_control  |wt       |Control |T1        |WT_t1_control          |NA                     |NA                      |NA                      |NA                     |NA                     |WT_t1_control            |WT_t1_control           |NA                       |
|       135|121_1           |WT_t1_western  |wt       |Western |T1        |NA                     |WT_t1_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       136|122_1           |WT_t1_western  |wt       |Western |T1        |NA                     |WT_t1_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       137|103_1           |WT_t1_western  |wt       |Western |T1        |NA                     |WT_t1_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       138|105_1           |WT_t1_western  |wt       |Western |T1        |NA                     |WT_t1_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       139|125_1           |WT_t1_western  |wt       |Western |T1        |NA                     |WT_t1_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       140|91_1            |WT_t1_control  |wt       |Control |T1        |WT_t1_control          |NA                     |NA                      |NA                      |NA                     |NA                     |WT_t1_control            |WT_t1_control           |NA                       |
|       141|92_1            |WT_t1_control  |wt       |Control |T1        |WT_t1_control          |NA                     |NA                      |NA                      |NA                     |NA                     |WT_t1_control            |WT_t1_control           |NA                       |
|       142|93_1            |WT_t1_control  |wt       |Control |T1        |WT_t1_control          |NA                     |NA                      |NA                      |NA                     |NA                     |WT_t1_control            |WT_t1_control           |NA                       |
|       155|41_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       156|42_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       143|13_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       144|14_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       145|15_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       146|16_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       147|21_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       148|22_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       149|23_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       150|24_2            |KO_t2_control  |ko       |Control |T2        |NA                     |NA                     |NA                      |NA                      |KO_t2_control          |NA                     |NA                       |NA                      |NA                       |
|       158|45_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       151|31_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       152|33_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       153|34_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       157|44_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       154|35_2            |KO_t2_western  |ko       |Western |T2        |NA                     |NA                     |NA                      |NA                      |NA                     |KO_t2_western          |NA                       |NA                      |NA                       |
|       171|81_2            |HET_t2_control |het      |Control |T2        |NA                     |NA                     |HET_t2_control          |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       159|52_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       160|53_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       161|54_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       162|55_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       163|61_2            |HET_t2_control |het      |Control |T2        |NA                     |NA                     |HET_t2_control          |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       172|82_2            |HET_t2_control |het      |Control |T2        |NA                     |NA                     |HET_t2_control          |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       164|63_2            |HET_t2_control |het      |Control |T2        |NA                     |NA                     |HET_t2_control          |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       165|64_2            |HET_t2_control |het      |Control |T2        |NA                     |NA                     |HET_t2_control          |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       166|65_2            |HET_t2_control |het      |Control |T2        |NA                     |NA                     |HET_t2_control          |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       173|86_2            |HET_t2_control |het      |Control |T2        |NA                     |NA                     |HET_t2_control          |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       167|72_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       168|73_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       169|74_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       170|75_2            |HET_t2_western |het      |Western |T2        |NA                     |NA                     |NA                      |HET_t2_western          |NA                     |NA                     |NA                       |NA                      |NA                       |
|       177|101_2           |WT_t2_western  |wt       |Western |T2        |NA                     |WT_t2_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       181|112_2           |WT_t2_control  |wt       |Control |T2        |WT_t2_control          |NA                     |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       182|113_2           |WT_t2_control  |wt       |Control |T2        |WT_t2_control          |NA                     |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       179|104_2           |WT_t2_western  |wt       |Western |T2        |NA                     |WT_t2_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       183|115_2           |WT_t2_control  |wt       |Control |T2        |WT_t2_control          |NA                     |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       184|121_2           |WT_t2_western  |wt       |Western |T2        |NA                     |WT_t2_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       185|122_2           |WT_t2_western  |wt       |Western |T2        |NA                     |WT_t2_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       178|103_2           |WT_t2_western  |wt       |Western |T2        |NA                     |WT_t2_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       180|105_2           |WT_t2_western  |wt       |Western |T2        |NA                     |WT_t2_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       186|125_2           |WT_t2_western  |wt       |Western |T2        |NA                     |WT_t2_western          |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       174|91_2            |WT_t2_control  |wt       |Control |T2        |WT_t2_control          |NA                     |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       175|92_2            |WT_t2_control  |wt       |Control |T2        |WT_t2_control          |NA                     |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |
|       176|93_2            |WT_t2_control  |wt       |Control |T2        |WT_t2_control          |NA                     |NA                      |NA                      |NA                     |NA                     |NA                       |NA                      |NA                       |


