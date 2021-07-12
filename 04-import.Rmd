# Importing microbiome data

This section demonstrates how to import microbiome profiling data in R.


## Data access

**Option 1**

*ADHD-associated changes in gut microbiota and brain in a mouse model*

Tengeler AC _et
al._ (2020) [**Gut microbiota from persons with
attention-deficit/hyperactivity disorder affects the brain in
mice**](https://doi.org/10.1186/s40168-020-00816-x). Microbiome
8:44.

In this study, mice are colonized with microbiota from participants
with ADHD (attention deficit hyperactivity disorder) and healthy
participants.  The aim of the study was to assess whether the mice
display ADHD behaviors after being inoculated with ADHD microbiota,
suggesting a role of the microbiome in ADHD pathology.

Download the data from
  [data](https://github.com/microbiome/course_2021_radboud/tree/main/data)
  subfolder.

**Option 2**

*Western diet intervention study in serotonin transporter modified mouse model*

Mice received three weeks of Western (high fat, high sugar) or Control diet in 
three Genotype groups, a wild-type group and 2 groups with either partial or 
complete knock-out of the serotonin transporter (SERT), leading to an excess of 
serotonin in the gut, brain and blood circulation. Mice were measured before 
and after the intervention. In total there are three factors in this design, 
Time (pre-,post-intervention), Diet (Control, Western diet) and Genotype group 
(WT, HET, KO). There are about 6-8 mice per group. 

Data can be found from Summer School's [Brightspace](https://brightspace.ru.nl/d2l/le/content/249077/Home). 

**Option 3**

*Open data set of your own choice*, see e.g.: 

-   [Bioconductor microbiomeDataSets](https://bioconductor.org/packages/release/data/experiment/html/microbiomeDataSets.html)

## Importing microbiome data in R

**Import example data** by modifying the examples in the online book
section on [data exploration and
manipulation](https://microbiome.github.io/OMA/data-introduction.html#loading-experimental-microbiome-data). The
data files in our example are in _biom_ format, which is a standard
file format for microbiome data. Other file formats exist as well, and
import details vary by platform.

Here, we import _biom_ data files into a specific data container (structure)
in R, _TreeSummarizedExperiment_ (TSE) [Huang et
al. (2020)](https://f1000research.com/articles/9-1246). This provides
the basis for downstream data analysis in the _miaverse_ data science
framework.

In this course, we focus on downstream analysis of taxonomic profiling
data, and assume that the data has already been appropriately
preprocessed and available in the TSE format. In addition to our
example data, further demonstration data sets are readily available in
the TSE format through
[microbiomeDataSets](https://bioconductor.org/packages/release/data/experiment/html/microbiomeDataSets.html).


<img src="https://raw.githubusercontent.com/FelixErnst/TreeSummarizedExperiment
/2293440c6e70ae4d6e978b6fdf2c42fdea7fb36a/vignettes/tse2.png" width="100%"/>

**Figure sources:** 

**Original article**
-   Huang R _et al_. (2021) [TreeSummarizedExperiment: a S4 class 
for data with hierarchical structure](https://doi.org/10.12688/
f1000research.26669.2). F1000Research 9:1246.

**Reference Sequence slot extension**
- Lahti L _et al_. (2020) [Upgrading the R/Bioconductor ecosystem for microbiome 
research](https://doi.org/10.7490/
f1000research.1118447.1) F1000Research 9:1464 (slides).


## Example solutions

 * Example code for data import: [import.Rmd](import.Rmd)
