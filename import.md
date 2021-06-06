# Import data

## Data

This workflow demonstrates the use of miaverse using data from the
following publication, which you can check for a more detailed
description of the samples and experimental design: Tengeler AC, Dam SA,
Wiesmann M, Naaijen J, van Bodegom M, Belzer C, Dederen PJ, Verweij V,
Franke B, Kozicz T, Vasquez AA & Kiliaan AJ (2020) [**Gut microbiota
from persons with attention-deficit/hyperactivity disorder affects the
brain in mice**](https://doi.org/10.1186/s40168-020-00816-x) Microbiome
8:44.

Data is located in a “data” subfolder. Data consists of 3 files:

-   biom file that contains abundance table and taxonomy information
-   csv file that contains sample metadata
-   tre file that contains a phylogenetic tree.

This notebook shows how to import the *biom* and its accompanying data
files to a *TreeSummarizedExperiment* object.

## Initialization

[Install](install.html) the necessary R packages if you have not already
done it.

Then load the R packages.

    library("mia")

Define source file paths.

    biom_file_path <- "data/Aggregated_humanization2.biom"
    sample_meta_file_path <- "data/Mapping_file_ADHD_aggregated.csv"
    tree_file_path <- "data/Data_humanization_phylo_aggregation.tre"

Load the (biom) data into a SummarizedExperiment (SE) object.

    se <- loadFromBiom(biom_file_path)

## Investigate the R data object

We have now imported the data set in R. Let us investigate its contents.

    print(se)

    ## class: SummarizedExperiment 
    ## dim: 151 27 
    ## metadata(0):
    ## assays(1): counts
    ## rownames(151): 1726470 1726471 ... 17264756 17264757
    ## rowData names(6): taxonomy1 taxonomy2 ... taxonomy5 taxonomy6
    ## colnames(27): A110 A111 ... A38 A39
    ## colData names(0):

Counts include the abundance table from biom file. Let us just use first
cols and rows.

    assays(se)$counts[1:3, 1:3]

    ##           A110  A111  A12
    ## 1726470  17722 11630    0
    ## 1726471  12052     0 2679
    ## 17264731     0   970    0

### rowData (taxonomic information)

The rowdata includes taxonomic information from biom file. The head()
command shows just the beginning of the data table for an overview.

    knitr::kable(head(rowData(se)))

<table style="width:100%;">
<colgroup>
<col style="width: 7%" />
<col style="width: 10%" />
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 17%" />
<col style="width: 18%" />
<col style="width: 15%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">taxonomy1</th>
<th style="text-align: left;">taxonomy2</th>
<th style="text-align: left;">taxonomy3</th>
<th style="text-align: left;">taxonomy4</th>
<th style="text-align: left;">taxonomy5</th>
<th style="text-align: left;">taxonomy6</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1726470</td>
<td style="text-align: left;">"k__Bacteria</td>
<td style="text-align: left;">p__Bacteroidetes</td>
<td style="text-align: left;">c__Bacteroidia</td>
<td style="text-align: left;">o__Bacteroidales</td>
<td style="text-align: left;">f__Bacteroidaceae</td>
<td style="text-align: left;">g__Bacteroides"</td>
</tr>
<tr class="even">
<td style="text-align: left;">1726471</td>
<td style="text-align: left;">"k__Bacteria</td>
<td style="text-align: left;">p__Bacteroidetes</td>
<td style="text-align: left;">c__Bacteroidia</td>
<td style="text-align: left;">o__Bacteroidales</td>
<td style="text-align: left;">f__Bacteroidaceae</td>
<td style="text-align: left;">g__Bacteroides"</td>
</tr>
<tr class="odd">
<td style="text-align: left;">17264731</td>
<td style="text-align: left;">"k__Bacteria</td>
<td style="text-align: left;">p__Bacteroidetes</td>
<td style="text-align: left;">c__Bacteroidia</td>
<td style="text-align: left;">o__Bacteroidales</td>
<td style="text-align: left;">f__Porphyromonadaceae</td>
<td style="text-align: left;">g__Parabacteroides"</td>
</tr>
<tr class="even">
<td style="text-align: left;">17264726</td>
<td style="text-align: left;">"k__Bacteria</td>
<td style="text-align: left;">p__Bacteroidetes</td>
<td style="text-align: left;">c__Bacteroidia</td>
<td style="text-align: left;">o__Bacteroidales</td>
<td style="text-align: left;">f__Bacteroidaceae</td>
<td style="text-align: left;">g__Bacteroides"</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1726472</td>
<td style="text-align: left;">"k__Bacteria</td>
<td style="text-align: left;">p__Verrucomicrobia</td>
<td style="text-align: left;">c__Verrucomicrobiae</td>
<td style="text-align: left;">o__Verrucomicrobiales</td>
<td style="text-align: left;">f__Verrucomicrobiaceae</td>
<td style="text-align: left;">g__Akkermansia"</td>
</tr>
<tr class="even">
<td style="text-align: left;">17264724</td>
<td style="text-align: left;">"k__Bacteria</td>
<td style="text-align: left;">p__Bacteroidetes</td>
<td style="text-align: left;">c__Bacteroidia</td>
<td style="text-align: left;">o__Bacteroidales</td>
<td style="text-align: left;">f__Bacteroidaceae</td>
<td style="text-align: left;">g__Bacteroides"</td>
</tr>
</tbody>
</table>

Taxonomic ranks are not real rank names. Let’s replace those taxonomic
classes with real rank names.

In addition to that, taxa names include, e.g., ’"k\_\_’ before the name,
so let’s make them cleaner by removing them.

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

<table>
<colgroup>
<col style="width: 8%" />
<col style="width: 8%" />
<col style="width: 15%" />
<col style="width: 16%" />
<col style="width: 17%" />
<col style="width: 18%" />
<col style="width: 15%" />
</colgroup>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">Kingdom</th>
<th style="text-align: left;">Phylum</th>
<th style="text-align: left;">Class</th>
<th style="text-align: left;">Order</th>
<th style="text-align: left;">Family</th>
<th style="text-align: left;">Genus</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">1726470</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">Bacteroidia</td>
<td style="text-align: left;">Bacteroidales</td>
<td style="text-align: left;">Bacteroidaceae</td>
<td style="text-align: left;">Bacteroides</td>
</tr>
<tr class="even">
<td style="text-align: left;">1726471</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">Bacteroidia</td>
<td style="text-align: left;">Bacteroidales</td>
<td style="text-align: left;">Bacteroidaceae</td>
<td style="text-align: left;">Bacteroides</td>
</tr>
<tr class="odd">
<td style="text-align: left;">17264731</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">Bacteroidia</td>
<td style="text-align: left;">Bacteroidales</td>
<td style="text-align: left;">Porphyromonadaceae</td>
<td style="text-align: left;">Parabacteroides</td>
</tr>
<tr class="even">
<td style="text-align: left;">17264726</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">Bacteroidia</td>
<td style="text-align: left;">Bacteroidales</td>
<td style="text-align: left;">Bacteroidaceae</td>
<td style="text-align: left;">Bacteroides</td>
</tr>
<tr class="odd">
<td style="text-align: left;">1726472</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Verrucomicrobia</td>
<td style="text-align: left;">Verrucomicrobiae</td>
<td style="text-align: left;">Verrucomicrobiales</td>
<td style="text-align: left;">Verrucomicrobiaceae</td>
<td style="text-align: left;">Akkermansia</td>
</tr>
<tr class="even">
<td style="text-align: left;">17264724</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">Bacteroidia</td>
<td style="text-align: left;">Bacteroidales</td>
<td style="text-align: left;">Bacteroidaceae</td>
<td style="text-align: left;">Bacteroides</td>
</tr>
</tbody>
</table>

### colData (sample information)

We notice that the imported biom file did not contain sample meta data
yet, so it includes empty data frame

    head(colData(se))

    ## DataFrame with 6 rows and 0 columns

Let us add sample meta data file

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

Now colData includes sample metadata. Use kable to print it more nicely.

    knitr::kable(head(colData(se)))

<table>
<thead>
<tr class="header">
<th style="text-align: left;"></th>
<th style="text-align: left;">patient_status</th>
<th style="text-align: left;">cohort</th>
<th style="text-align: left;">patient_status_vs_cohort</th>
<th style="text-align: left;">sample_name</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td style="text-align: left;">A110</td>
<td style="text-align: left;">ADHD</td>
<td style="text-align: left;">Cohort_1</td>
<td style="text-align: left;">ADHD_Cohort_1</td>
<td style="text-align: left;">A110</td>
</tr>
<tr class="even">
<td style="text-align: left;">A12</td>
<td style="text-align: left;">ADHD</td>
<td style="text-align: left;">Cohort_1</td>
<td style="text-align: left;">ADHD_Cohort_1</td>
<td style="text-align: left;">A12</td>
</tr>
<tr class="odd">
<td style="text-align: left;">A15</td>
<td style="text-align: left;">ADHD</td>
<td style="text-align: left;">Cohort_1</td>
<td style="text-align: left;">ADHD_Cohort_1</td>
<td style="text-align: left;">A15</td>
</tr>
<tr class="even">
<td style="text-align: left;">A19</td>
<td style="text-align: left;">ADHD</td>
<td style="text-align: left;">Cohort_1</td>
<td style="text-align: left;">ADHD_Cohort_1</td>
<td style="text-align: left;">A19</td>
</tr>
<tr class="odd">
<td style="text-align: left;">A21</td>
<td style="text-align: left;">ADHD</td>
<td style="text-align: left;">Cohort_2</td>
<td style="text-align: left;">ADHD_Cohort_2</td>
<td style="text-align: left;">A21</td>
</tr>
<tr class="even">
<td style="text-align: left;">A23</td>
<td style="text-align: left;">ADHD</td>
<td style="text-align: left;">Cohort_2</td>
<td style="text-align: left;">ADHD_Cohort_2</td>
<td style="text-align: left;">A23</td>
</tr>
</tbody>
</table>

### Phylogenetic tree information

Now, let’s add a phylogenetic tree.

The current data object, se, is a SummarizedExperiment object. This does
not include a slot for adding a phylogenetic tree. In order to do this,
we can convert SE object to an extended TreeSummarizedExperiment object
which also includes a rowTree slot.

    tse <- as(se, "TreeSummarizedExperiment")

    # tse includes same data as se
    print(tse)

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

Next, let us read the tree data file and add it to the R data object
(tse).

    tree <- ape::read.tree(tree_file_path)

    # Add tree to rowTree
    rowTree(tse) <- tree

    # Check
    head(tse)

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

Now rowTree includes phylogenetic tree:

    head(rowTree(tse))
