---
title: "Import data"
output: html_notebook
---
This notebook imports biom data to TSE object. 

General information about Notebook
This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. When you execute code within the notebook, the results appear beneath the code. 

Try executing this chunk by clicking the *Run* button within the chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code and output will be saved alongside it (click the *Preview* button or press *Ctrl+Shift+K* to preview the HTML file).

The preview shows you a rendered HTML copy of the contents of the editor. Consequently, unlike *Knit*, *Preview* does not run any R code chunks. Instead, the output of the chunk when it was last run in the editor is displayed.


```r
# Install BiocManager
#BiocManager::install()
# Install mia
#BiocManager::install("microbiome/mia")
# Load mia
library("mia")
```

```
## Error in library("mia"): there is no package called 'mia'
```

```r
# Paths for files
biom_file_path <- "data/table-with-taxonomy.biom"
sample_meta_file_path <- "data/WesternDietSert_extendedTimeComparisonsv4.txt"
tree_file_path <- "data/tree.nwk"

# Creates TSE object from biom file
tse <- loadFromBiom(biom_file_path)
```

```
## Error in loadFromBiom(biom_file_path): could not find function "loadFromBiom"
```

```r
tse
```

```
## Error in eval(expr, envir, enclos): object 'tse' not found
```

```r
# counts include the abundance table from biom file
assays(tse)$counts
```

```
## Error in assays(tse): could not find function "assays"
```

```r
# rowdata includes tazonomical information from biom file
rowData(tse)
```

```
## Error in rowData(tse): could not find function "rowData"
```

biom file did not contain sample meta data, so it includes empty data frame
colData(tse)


```r
# Adds tree

# Installs ape
#BiocManager::install("ape")

# Read the tree 
tree <- ape::read.tree(tree_file_path)
# Adds tree to rowTree
rowTree(tse) <- tree
```

```
## Error in rowTree(tse) <- tree: object 'tse' not found
```

```r
tse
```

```
## Error in eval(expr, envir, enclos): object 'tse' not found
```

```r
# rowTree includes phylogenetic tree
rowTree(tse)
```

```
## Error in rowTree(tse): could not find function "rowTree"
```

```r
# Adds sample meta data file

# Checks what type of data is it
read.table(sample_meta_file_path)
```

```
##                                                                                                                                                                                                                                                                             V1
## 1  sample-id,MouseID_recoded,All,Genotype,Diet,Timepoint,Timepoint1vs2WTcontrol,Timepoint1vs2WTWestern,Timepoint1vs2HETcontrol,Timepoint1vs2HETWestern,Timepoint1vs2KOcontrol,Timepoint1vs2KOWestern,Timepoint1ControlWTvsHET,Timepoint1ControlWTvsKO,Timepoint1ControlHETvsKO
## 2                                                                                                                                                                                                    99,41_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 3                                                                                                                                                                                                   100,42_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 4                                                                                                                                                                             101,13_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 5                                                                                                                                                                             102,14_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 6                                                                                                                                                                             103,15_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 7                                                                                                                                                                             104,16_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 8                                                                                                                                                                             105,21_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 9                                                                                                                                                                             106,22_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 10                                                                                                                                                                            107,23_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 11                                                                                                                                                                            108,24_1,KO_t1_control,ko,Control,T1,NA,NA,NA,NA,KO_t1_control,NA,NA,KO_t1_control,KO_t1_control
## 12                                                                                                                                                                                                  109,45_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 13                                                                                                                                                                                                  110,31_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 14                                                                                                                                                                                                  111,33_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 15                                                                                                                                                                                                  112,34_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 16                                                                                                                                                                                                  113,44_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 17                                                                                                                                                                                                  114,35_1,KO_t1_western,ko,Western,T1,NA,NA,NA,NA,NA,KO_t1_western,NA,NA,NA
## 18                                                                                                                                                                       115,81_1,HET_t1_control,het,Control,T1,NA,NA,HET_t1_control,NA,NA,NA,HET_t1_control,NA,HET_t1_control
## 19                                                                                                                                                                                               116,52_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 20                                                                                                                                                                                               117,53_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 21                                                                                                                                                                                               118,54_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 22                                                                                                                                                                                               119,55_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 23                                                                                                                                                                       120,61_1,HET_t1_control,het,Control,T1,NA,NA,HET_t1_control,NA,NA,NA,HET_t1_control,NA,HET_t1_control
## 24                                                                                                                                                                       121,82_1,HET_t1_control,het,Control,T1,NA,NA,HET_t1_control,NA,NA,NA,HET_t1_control,NA,HET_t1_control
## 25                                                                                                                                                                       122,63_1,HET_t1_control,het,Control,T1,NA,NA,HET_t1_control,NA,NA,NA,HET_t1_control,NA,HET_t1_control
## 26                                                                                                                                                                       123,64_1,HET_t1_control,het,Control,T1,NA,NA,HET_t1_control,NA,NA,NA,HET_t1_control,NA,HET_t1_control
## 27                                                                                                                                                                       124,65_1,HET_t1_control,het,Control,T1,NA,NA,HET_t1_control,NA,NA,NA,HET_t1_control,NA,HET_t1_control
## 28                                                                                                                                                                       125,86_1,HET_t1_control,het,Control,T1,NA,NA,HET_t1_control,NA,NA,NA,HET_t1_control,NA,HET_t1_control
## 29                                                                                                                                                                                               126,72_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 30                                                                                                                                                                                               127,73_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 31                                                                                                                                                                                               128,74_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 32                                                                                                                                                                                               129,75_1,HET_t1_western,het,Western,T1,NA,NA,NA,HET_t1_western,NA,NA,NA,NA,NA
## 33                                                                                                                                                                                                 130,101_1,WT_t1_western,wt,Western,T1,NA,WT_t1_western,NA,NA,NA,NA,NA,NA,NA
## 34                                                                                                                                                                           131,112_1,WT_t1_control,wt,Control,T1,WT_t1_control,NA,NA,NA,NA,NA,WT_t1_control,WT_t1_control,NA
## 35                                                                                                                                                                           132,113_1,WT_t1_control,wt,Control,T1,WT_t1_control,NA,NA,NA,NA,NA,WT_t1_control,WT_t1_control,NA
## 36                                                                                                                                                                                                 133,104_1,WT_t1_western,wt,Western,T1,NA,WT_t1_western,NA,NA,NA,NA,NA,NA,NA
## 37                                                                                                                                                                           134,115_1,WT_t1_control,wt,Control,T1,WT_t1_control,NA,NA,NA,NA,NA,WT_t1_control,WT_t1_control,NA
## 38                                                                                                                                                                                                 135,121_1,WT_t1_western,wt,Western,T1,NA,WT_t1_western,NA,NA,NA,NA,NA,NA,NA
## 39                                                                                                                                                                                                 136,122_1,WT_t1_western,wt,Western,T1,NA,WT_t1_western,NA,NA,NA,NA,NA,NA,NA
## 40                                                                                                                                                                                                 137,103_1,WT_t1_western,wt,Western,T1,NA,WT_t1_western,NA,NA,NA,NA,NA,NA,NA
## 41                                                                                                                                                                                                 138,105_1,WT_t1_western,wt,Western,T1,NA,WT_t1_western,NA,NA,NA,NA,NA,NA,NA
## 42                                                                                                                                                                                                 139,125_1,WT_t1_western,wt,Western,T1,NA,WT_t1_western,NA,NA,NA,NA,NA,NA,NA
## 43                                                                                                                                                                            140,91_1,WT_t1_control,wt,Control,T1,WT_t1_control,NA,NA,NA,NA,NA,WT_t1_control,WT_t1_control,NA
## 44                                                                                                                                                                            141,92_1,WT_t1_control,wt,Control,T1,WT_t1_control,NA,NA,NA,NA,NA,WT_t1_control,WT_t1_control,NA
## 45                                                                                                                                                                            142,93_1,WT_t1_control,wt,Control,T1,WT_t1_control,NA,NA,NA,NA,NA,WT_t1_control,WT_t1_control,NA
## 46                                                                                                                                                                                                  155,41_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 47                                                                                                                                                                                                  156,42_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 48                                                                                                                                                                                                  143,13_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 49                                                                                                                                                                                                  144,14_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 50                                                                                                                                                                                                  145,15_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 51                                                                                                                                                                                                  146,16_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 52                                                                                                                                                                                                  147,21_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 53                                                                                                                                                                                                  148,22_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 54                                                                                                                                                                                                  149,23_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 55                                                                                                                                                                                                  150,24_2,KO_t2_control,ko,Control,T2,NA,NA,NA,NA,KO_t2_control,NA,NA,NA,NA
## 56                                                                                                                                                                                                  158,45_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 57                                                                                                                                                                                                  151,31_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 58                                                                                                                                                                                                  152,33_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 59                                                                                                                                                                                                  153,34_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 60                                                                                                                                                                                                  157,44_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 61                                                                                                                                                                                                  154,35_2,KO_t2_western,ko,Western,T2,NA,NA,NA,NA,NA,KO_t2_western,NA,NA,NA
## 62                                                                                                                                                                                               171,81_2,HET_t2_control,het,Control,T2,NA,NA,HET_t2_control,NA,NA,NA,NA,NA,NA
## 63                                                                                                                                                                                               159,52_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 64                                                                                                                                                                                               160,53_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 65                                                                                                                                                                                               161,54_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 66                                                                                                                                                                                               162,55_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 67                                                                                                                                                                                               163,61_2,HET_t2_control,het,Control,T2,NA,NA,HET_t2_control,NA,NA,NA,NA,NA,NA
## 68                                                                                                                                                                                               172,82_2,HET_t2_control,het,Control,T2,NA,NA,HET_t2_control,NA,NA,NA,NA,NA,NA
## 69                                                                                                                                                                                               164,63_2,HET_t2_control,het,Control,T2,NA,NA,HET_t2_control,NA,NA,NA,NA,NA,NA
## 70                                                                                                                                                                                               165,64_2,HET_t2_control,het,Control,T2,NA,NA,HET_t2_control,NA,NA,NA,NA,NA,NA
## 71                                                                                                                                                                                               166,65_2,HET_t2_control,het,Control,T2,NA,NA,HET_t2_control,NA,NA,NA,NA,NA,NA
## 72                                                                                                                                                                                               173,86_2,HET_t2_control,het,Control,T2,NA,NA,HET_t2_control,NA,NA,NA,NA,NA,NA
## 73                                                                                                                                                                                               167,72_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 74                                                                                                                                                                                               168,73_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 75                                                                                                                                                                                               169,74_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 76                                                                                                                                                                                               170,75_2,HET_t2_western,het,Western,T2,NA,NA,NA,HET_t2_western,NA,NA,NA,NA,NA
## 77                                                                                                                                                                                                 177,101_2,WT_t2_western,wt,Western,T2,NA,WT_t2_western,NA,NA,NA,NA,NA,NA,NA
## 78                                                                                                                                                                                                 181,112_2,WT_t2_control,wt,Control,T2,WT_t2_control,NA,NA,NA,NA,NA,NA,NA,NA
## 79                                                                                                                                                                                                 182,113_2,WT_t2_control,wt,Control,T2,WT_t2_control,NA,NA,NA,NA,NA,NA,NA,NA
## 80                                                                                                                                                                                                 179,104_2,WT_t2_western,wt,Western,T2,NA,WT_t2_western,NA,NA,NA,NA,NA,NA,NA
## 81                                                                                                                                                                                                 183,115_2,WT_t2_control,wt,Control,T2,WT_t2_control,NA,NA,NA,NA,NA,NA,NA,NA
## 82                                                                                                                                                                                                 184,121_2,WT_t2_western,wt,Western,T2,NA,WT_t2_western,NA,NA,NA,NA,NA,NA,NA
## 83                                                                                                                                                                                                 185,122_2,WT_t2_western,wt,Western,T2,NA,WT_t2_western,NA,NA,NA,NA,NA,NA,NA
## 84                                                                                                                                                                                                 178,103_2,WT_t2_western,wt,Western,T2,NA,WT_t2_western,NA,NA,NA,NA,NA,NA,NA
## 85                                                                                                                                                                                                 180,105_2,WT_t2_western,wt,Western,T2,NA,WT_t2_western,NA,NA,NA,NA,NA,NA,NA
## 86                                                                                                                                                                                                 186,125_2,WT_t2_western,wt,Western,T2,NA,WT_t2_western,NA,NA,NA,NA,NA,NA,NA
## 87                                                                                                                                                                                                  174,91_2,WT_t2_control,wt,Control,T2,WT_t2_control,NA,NA,NA,NA,NA,NA,NA,NA
## 88                                                                                                                                                                                                  175,92_2,WT_t2_control,wt,Control,T2,WT_t2_control,NA,NA,NA,NA,NA,NA,NA,NA
## 89                                                                                                                                                                                                  176,93_2,WT_t2_control,wt,Control,T2,WT_t2_control,NA,NA,NA,NA,NA,NA,NA,NA
```

```r
# It is comma separated file and includes headers
sample_meta <- read.table(sample_meta_file_path, sep = ",", header = TRUE)
# sample_meta needs to be converted from data.frame to DataFrame
sample_meta <- DataFrame(sample_meta)
```

```
## Error in DataFrame(sample_meta): could not find function "DataFrame"
```

```r
# It is added to colData
colData(tse) <- sample_meta
```

```
## Error in colData(tse) <- sample_meta: object 'tse' not found
```

```r
tse
```

```
## Error in eval(expr, envir, enclos): object 'tse' not found
```

```r
#colData includes sample meta data
colData(tse)
```

```
## Error in colData(tse): could not find function "colData"
```

