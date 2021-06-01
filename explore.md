---
title: "Data exploration"
output: 
  html_document: 
    keep_md: true
---

# Data exploration

Now we have loaded the data set in R, and investigated that it has all
the necessary components.

This notebook introduces now basic operations to briefly explore the data. 

## Investigate the contents of a microbiome data object

Dimensionality tells us, how many taxa and samples the data contains. As we can see, 
there are 151 taxa and 27 samples.


```r
dim(tse)
```

```
## [1] 151  27
```

The rowData slot contains a taxonomic table. It includes taxonomic information
for each 151 entries. With the `head()` command, it is possible to print only 
the beginning of the table. The rowData seems to contain information from 6 different 
taxonomy classes.

`knitr::kable()` is for printing the information more nicely.


```r
knitr::kable(head(rowData(tse)))
```



|         |Kingdom  |Phylum          |Class            |Order              |Family              |Genus           |
|:--------|:--------|:---------------|:----------------|:------------------|:-------------------|:---------------|
|1726470  |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |
|1726471  |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |
|17264731 |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Porphyromonadaceae  |Parabacteroides |
|17264726 |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |
|1726472  |Bacteria |Verrucomicrobia |Verrucomicrobiae |Verrucomicrobiales |Verrucomicrobiaceae |Akkermansia     |
|17264724 |Bacteria |Bacteroidetes   |Bacteroidia      |Bacteroidales      |Bacteroidaceae      |Bacteroides     |

The colData slot contains sample metadata. It contains information for all 27 samples.
However, here only the 6 first samples are shown as we use the `head()` command. There
are 4 columns, that contain information, e.g., about patients' status, and cohort.


```r
knitr::kable(head(colData(tse)))
```



|     |patient_status |cohort   |patient_status_vs_cohort |sample_name |
|:----|:--------------|:--------|:------------------------|:-----------|
|A110 |ADHD           |Cohort_1 |ADHD_Cohort_1            |A110        |
|A12  |ADHD           |Cohort_1 |ADHD_Cohort_1            |A12         |
|A15  |ADHD           |Cohort_1 |ADHD_Cohort_1            |A15         |
|A19  |ADHD           |Cohort_1 |ADHD_Cohort_1            |A19         |
|A21  |ADHD           |Cohort_2 |ADHD_Cohort_2            |A21         |
|A23  |ADHD           |Cohort_2 |ADHD_Cohort_2            |A23         |

From here, we can observe, e.g., what is the patient status distribution.
`colData(tse)$patient_status` fetches the data from the column, `table()` creates a table
that shows how many times each class is present, and `sort()` sorts the table to 
ascending order.

There are 13 samples from patients having ADHD, and 14 control samples.


```r
sort(table(colData(tse)$patient_status))
```

```
## 
##    ADHD Control 
##      13      14
```

## Manipulate the data


### Transformations

Abundances are always relative even though counts are calculated. That is due to technical aspects of the data generation process (see e.g. [Gloor et al., 2017](https://www.frontiersin.org/articles/10.3389/fmicb.2017.02224/full)). Below, we calculate relative abundances as these are usually easier to interpret
than plain counts. For some statistical models we need to transform the data into other formats as explained in above link (and as we will see later).


```r
# Calculates relative abundances, and stores the table to assays
tse <- transformCounts(tse, method = "relabundance")
```


### Aggregation

We might want to know, which taxonomic rank is, e.g., the most abundant. We can 
easily agglomerate the data based on taxonomic ranks. Here, we agglomerate 
the data at Phylum level. 


```r
tse_phylum <- agglomerateByRank(tse, rank = "Phylum")

# Show dimensionality
dim(tse_phylum)
```

```
## [1]  5 27
```



Now there are 5 taxa and 27 samples. It means that there are 5 different Phylum
level taxa. From rowData we might see little bit easier, how ranks are agglomerated. 
For example, all Firmicutes are combined together. That is why all lower rank 
information is lost. From assay we could see, that all abundances of taxa that 
belongs to Firmicutes are summed up.


```r
knitr::kable(head(rowData(tse_phylum)))
```



|                |Kingdom  |Phylum          |Class |Order |Family |Genus |
|:---------------|:--------|:---------------|:-----|:-----|:------|:-----|
|Bacteroidetes   |Bacteria |Bacteroidetes   |NA    |NA    |NA     |NA    |
|Verrucomicrobia |Bacteria |Verrucomicrobia |NA    |NA    |NA     |NA    |
|Proteobacteria  |Bacteria |Proteobacteria  |NA    |NA    |NA     |NA    |
|Firmicutes      |Bacteria |Firmicutes      |NA    |NA    |NA     |NA    |
|Cyanobacteria   |Bacteria |Cyanobacteria   |NA    |NA    |NA     |NA    |



## Visualization


For plotting, we use miaViz package, so we have to load it.


```r
library("miaViz")
```


Next, we can plot the Phylum level abundances. 


```r
# Here we specify "relabundance" to be abundance table that we use for plotting.
# Note that we can use agglomerated or non-agglomerated tse as an input, because
# the function agglomeration is built-in option. 

# Legend does not fit into picture, so its height is reduced.
plot_abundance <- plotAbundance(tse, abund_values="relabundance", rank = "Phylum") +
  theme(legend.key.height = unit(0.5, "cm")) +
  scale_y_continuous(label = scales::percent)
```

```
## Scale for 'y' is already present. Adding another scale for 'y', which will replace the existing scale.
```

```r
plot_abundance 
```

![](explore_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

From density plot, we could see, e.g., what is the most common abundance.
Here we plot distribution of Firmicutes relative abundances in different samples. 
Density plot can be seen as smoothened histogram.

From the plot, we can see that there are peak when abundance is little bit under 30 %.


```r
# Subset data by taking only Firmicutes
tse_firmicutes <- tse_phylum["Firmicutes"]

# Gets the abundance table
abundance_firmicutes <- assay(tse_firmicutes, "relabundance")

# Creates a data frame object, where first column includes abundances
firmicutes_abund_df <- as.data.frame(t(abundance_firmicutes))
# Rename the first and only column
colnames(firmicutes_abund_df) <- "abund"

# Creates a plot. Parameters inside feom_density are optional. With 
# geom_density(bw=1000), it is possible to adjust bandwidth.
firmicutes_abund_plot <- ggplot(firmicutes_abund_df, aes(x = abund)) + 
  geom_density(color="darkred", fill="lightblue") + 
  labs(x = "Relative abundance", title = "Firmicutes") +
  theme_classic() + # Changes the background
  scale_x_continuous(label = scales::percent)

firmicutes_abund_plot
```

![](explore_files/figure-html/unnamed-chunk-10-1.png)<!-- -->


```r
# # Does the same thing but differently
# # Calculates the density. Bandwidth can be adjusted; here, it is 0.065.
# # density() is from stats package
# density_firmicutes <- density(abundance_firmicutes, bw = 0.065)
# 
# # Plots the density
# plot(density_firmicutes,
#      xlab="Relative abundance",
#      ylab="Density",
#      main=paste0("Firmicutes (",density_firmicutes$n, " obs, ", density_firmicutes$bw, " bw)"))
```

For more visualization options and examples, see the [miaViz vignette](https://microbiome.github.io/miaViz/articles/miaViz.html).
