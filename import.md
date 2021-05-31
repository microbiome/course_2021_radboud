---
title: "Import data"
output: 
  html_document: 
    keep_md: true
---


## Data

This workflow demonstrates the use of miaverse using data from the
following publication, which you can check for a more detailed
description of the samples and experimental design: Tengeler AC, Dam
SA, Wiesmann M, Naaijen J, van Bodegom M, Belzer C, Dederen PJ,
Verweij V, Franke B, Kozicz T, Vasquez AA & Kiliaan AJ (2020) [**Gut
microbiota from persons with attention-deficit/hyperactivity disorder
affects the brain in
mice**](https://doi.org/10.1186/s40168-020-00816-x) Microbiome 8:44.


Data is located in a "data" subfolder. Data consists of 3 files: 

- biom file that contains abundance table and taxonomy information
- csv file that contains sample metadata
- tre file that contains a phylogenetic tree.

This notebook shows how to import the _biom_ and its accompanying data
files to a _TreeSummarizedExperiment_ object.


## Initialization

[Install](install.html) the necessary R packages if you have not already
done it.

Then load the R packages.


```r
library("mia")
```

Define source file paths.


```r
biom_file_path <- "data/Aggregated_humanization2.biom"
sample_meta_file_path <- "data/Mapping_file_ADHD_aggregated.csv"
tree_file_path <- "data/Data_humanization_phylo_aggregation.tre"
```

Load the (biom) data into a SummarizedExperiment (SE) object.


```r
se <- loadFromBiom(biom_file_path)
```


## Investigate the R data object

We have now imported the data set in R. Let us investigate its contents.


```r
print(se)
```

```
## class: SummarizedExperiment 
## dim: 151 27 
## metadata(0):
## assays(1): counts
## rownames(151): 1726470 1726471 ... 17264756 17264757
## rowData names(6): taxonomy1 taxonomy2 ... taxonomy5 taxonomy6
## colnames(27): A110 A111 ... A38 A39
## colData names(0):
```


Counts include the abundance table from biom file. Let us just use first cols and rows.


```r
assays(se)$counts[1:3, 1:3]
```

```
##           A110  A111  A12
## 1726470  17722 11630    0
## 1726471  12052     0 2679
## 17264731     0   970    0
```


### rowData (taxonomic information)

The rowdata includes taxonomic information from biom file. The head() command
shows just the beginning of the data table for an overview.


```r
knitr::kable(head(rowData(se)))
```



|         |taxonomy1    |taxonomy2          |taxonomy3           |taxonomy4             |taxonomy5              |taxonomy6           |
|:--------|:------------|:------------------|:-------------------|:---------------------|:----------------------|:-------------------|
|1726470  |"k__Bacteria |p__Bacteroidetes   |c__Bacteroidia      |o__Bacteroidales      |f__Bacteroidaceae      |g__Bacteroides"     |
|1726471  |"k__Bacteria |p__Bacteroidetes   |c__Bacteroidia      |o__Bacteroidales      |f__Bacteroidaceae      |g__Bacteroides"     |
|17264731 |"k__Bacteria |p__Bacteroidetes   |c__Bacteroidia      |o__Bacteroidales      |f__Porphyromonadaceae  |g__Parabacteroides" |
|17264726 |"k__Bacteria |p__Bacteroidetes   |c__Bacteroidia      |o__Bacteroidales      |f__Bacteroidaceae      |g__Bacteroides"     |
|1726472  |"k__Bacteria |p__Verrucomicrobia |c__Verrucomicrobiae |o__Verrucomicrobiales |f__Verrucomicrobiaceae |g__Akkermansia"     |
|17264724 |"k__Bacteria |p__Bacteroidetes   |c__Bacteroidia      |o__Bacteroidales      |f__Bacteroidaceae      |g__Bacteroides"     |

Taxonomic ranks are not real rank names. Let's replace those taxonomic classes 
with real rank names. 

In addition to that, taxa names include, e.g., '"k__' before the name, so let's
make them cleaner by removing them. 


```r
names(rowData(se)) <- c("Kingdom", "Phylum", "Class", "Order", 
                        "Family", "Genus")

# Goes through whole DataFrame. Removes '.*[kpcofg]__' from strings, where [kpcofg] 
# is any character from listed ones, and .* any character.
rowdata_modified <- BiocParallel::bplapply(rowData(se), 
                                           FUN = stringr::str_remove, 
                                           pattern = '.*[kpcofg]__')

# Genus level has additional '\"', so let's delete that also
rowdata_modified <- BiocParallel::bplapply(rowdata_modified, 
                                           FUN = stringr::str_remove, 
                                           pattern = '\"')

# rowdata_modified is list, so it is converted back to DataFrame. 
rowdata_modified <- DataFrame(rowdata_modified)

# And then assigned back to the SE object
rowData(se) <- rowdata_modified

# Now we have a nicer table
knitr::kable(head(rowData(se)))
```



|         |Kingdom  |Phylum          |Class            |Order              |Family              |Genus           |
|:--------|:--------|:---------------|:----------------|:------------------|:-------------------|:---------------|
|1726470  |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |
|1726471  |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |
|17264731 |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Porphyromonadaceae  |Parabacteroides |
|17264726 |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |
|1726472  |Bacteria |Verrucomicrobia |Verrucomicrobiae |Verrucomicrobiales |Verrucomicrobiaceae |Akkermansia     |
|17264724 |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |

### colData (sample information)

We notice that the imported biom file did not contain sample meta data
yet, so it includes empty data frame


```r
head(colData(se))
```

```
## DataFrame with 6 rows and 0 columns
```


Let us add sample meta data file


```r
# We use this to check what type of data is it
# read.table(sample_meta_file_path)

# It seems like a comma separated file and includes headers
# Let us read it and then convert from data.frame to DataFrame
# (required for our purposes)
sample_meta <- DataFrame(read.table(sample_meta_file_path, sep = ",", header = FALSE))

# Add sample names to rownames

rownames(sample_meta) <- sample_meta[,1]

# Delete column that included sample names
sample_meta[,1] <- NULL

# We can add titles 
colnames(sample_meta) <- c("patient_status", "cohort", "patient_status_vs_cohort", "sample_name")

# Then it can be added to colData
colData(se) <- sample_meta
```

Now colData includes sample metadata. Use kable to print it more nicely.


```r
knitr::kable(head(colData(se)))
```



|     |patient_status |cohort   |patient_status_vs_cohort |sample_name |
|:----|:--------------|:--------|:------------------------|:-----------|
|A110 |ADHD           |Cohort_1 |ADHD_Cohort_1            |A110        |
|A12  |ADHD           |Cohort_1 |ADHD_Cohort_1            |A12         |
|A15  |ADHD           |Cohort_1 |ADHD_Cohort_1            |A15         |
|A19  |ADHD           |Cohort_1 |ADHD_Cohort_1            |A19         |
|A21  |ADHD           |Cohort_2 |ADHD_Cohort_2            |A21         |
|A23  |ADHD           |Cohort_2 |ADHD_Cohort_2            |A23         |


### Phylogenetic tree information

Now, let's add a phylogenetic tree.

The current data object, se, is a SummarizedExperiment object. This
does not include a slot for adding a phylogenetic tree. In order to do
this, we can convert SE object to an extended TreeSummarizedExperiment
object which also includes a rowTree slot.



```r
tse <- as(se, "TreeSummarizedExperiment")

# tse includes same data as se
print(tse)
```

```
## class: TreeSummarizedExperiment 
## dim: 151 27 
## metadata(0):
## assays(1): counts
## rownames(151): 1726470 1726471 ... 17264756 17264757
## rowData names(6): Kingdom Phylum ... Family Genus
## colnames(27): A110 A12 ... A35 A38
## colData names(4): patient_status cohort patient_status_vs_cohort sample_name
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: NULL
## rowTree: NULL
## colLinks: NULL
## colTree: NULL
```

Next, let us read the tree data file and add it to the R data object (tse).



```r
tree <- ape::read.tree(tree_file_path)

# Add tree to rowTree
rowTree(tse) <- tree

# Check
head(tse)
```

```
## class: TreeSummarizedExperiment 
## dim: 6 27 
## metadata(0):
## assays(1): counts
## rownames(6): 1726470 1726471 ... 1726472 17264724
## rowData names(6): Kingdom Phylum ... Family Genus
## colnames(27): A110 A12 ... A35 A38
## colData names(4): patient_status cohort patient_status_vs_cohort sample_name
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
## rowLinks: a LinkDataFrame (6 rows)
## rowTree: 1 phylo tree(s) (151 leaves)
## colLinks: NULL
## colTree: NULL
```

Now rowTree includes phylogenetic tree:


```r
head(rowTree(tse))
```
