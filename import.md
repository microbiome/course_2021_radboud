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

Let us adds phylogenetic tree.


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
# It seems like a comma separated file and includes headers
# Let us read it:
sample_meta <- read.table(sample_meta_file_path, sep = ",", header = TRUE)

# Convert it from data.frame to DataFrame
# (required for our purposes)
sample_meta <- DataFrame(sample_meta)

# Then it can be added to colData
colData(tse) <- sample_meta
```

Now colData includes sample metadata	


```r
colData(tse)
```

```
## DataFrame with 88 rows and 15 columns
##     sample.id MouseID_recoded           All    Genotype        Diet   Timepoint
##     <integer>     <character>   <character> <character> <character> <character>
## 1          99            41_1 KO_t1_western          ko     Western          T1
## 2         100            42_1 KO_t1_western          ko     Western          T1
## 3         101            13_1 KO_t1_control          ko     Control          T1
## 4         102            14_1 KO_t1_control          ko     Control          T1
## 5         103            15_1 KO_t1_control          ko     Control          T1
## ...       ...             ...           ...         ...         ...         ...
## 84        180           105_2 WT_t2_western          wt     Western          T2
## 85        186           125_2 WT_t2_western          wt     Western          T2
## 86        174            91_2 WT_t2_control          wt     Control          T2
## 87        175            92_2 WT_t2_control          wt     Control          T2
## 88        176            93_2 WT_t2_control          wt     Control          T2
##     Timepoint1vs2WTcontrol Timepoint1vs2WTWestern Timepoint1vs2HETcontrol
##                <character>            <character>             <character>
## 1                       NA                     NA                      NA
## 2                       NA                     NA                      NA
## 3                       NA                     NA                      NA
## 4                       NA                     NA                      NA
## 5                       NA                     NA                      NA
## ...                    ...                    ...                     ...
## 84                      NA          WT_t2_western                      NA
## 85                      NA          WT_t2_western                      NA
## 86           WT_t2_control                     NA                      NA
## 87           WT_t2_control                     NA                      NA
## 88           WT_t2_control                     NA                      NA
##     Timepoint1vs2HETWestern Timepoint1vs2KOcontrol Timepoint1vs2KOWestern
##                 <character>            <character>            <character>
## 1                        NA                     NA          KO_t1_western
## 2                        NA                     NA          KO_t1_western
## 3                        NA          KO_t1_control                     NA
## 4                        NA          KO_t1_control                     NA
## 5                        NA          KO_t1_control                     NA
## ...                     ...                    ...                    ...
## 84                       NA                     NA                     NA
## 85                       NA                     NA                     NA
## 86                       NA                     NA                     NA
## 87                       NA                     NA                     NA
## 88                       NA                     NA                     NA
##     Timepoint1ControlWTvsHET Timepoint1ControlWTvsKO Timepoint1ControlHETvsKO
##                  <character>             <character>              <character>
## 1                         NA                      NA                       NA
## 2                         NA                      NA                       NA
## 3                         NA           KO_t1_control            KO_t1_control
## 4                         NA           KO_t1_control            KO_t1_control
## 5                         NA           KO_t1_control            KO_t1_control
## ...                      ...                     ...                      ...
## 84                        NA                      NA                       NA
## 85                        NA                      NA                       NA
## 86                        NA                      NA                       NA
## 87                        NA                      NA                       NA
## 88                        NA                      NA                       NA
```


