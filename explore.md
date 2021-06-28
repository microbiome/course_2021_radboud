Data exploration
================

Now we have loaded the data set into R, and investigated that it has all
the necessary components.

Here, basic operations to briefly explore the data are introduced.

Investigate the contents of a microbiome data object
----------------------------------------------------

Dimensionality tells us, how many taxa and samples the data contains. As
we can see, there are 151 taxa and 27 samples.

    dim(tse)

    ## [1] 151  27

The `rowData` slot contains a taxonomic table. It includes taxonomic
information for each 151 entries. With the `head()` command, it is
possible to print only the beginning of the table. The `rowData` seems
to contain information from 6 different taxonomy classes.

    knitr::kable(head(rowData(tse)))

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

The colData slot contains sample metadata. It contains information for
all 27 samples. However, here only the 6 first samples are shown as we
use the `head()` command. There are 4 columns, that contain information,
e.g., about patients’ status, and cohort.

    knitr::kable(head(colData(tse)))

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

From here, we can observe, e.g., what is the patient status
distribution. `colData(tse)$patient_status` fetches the data from the
column, `table()` creates a table that shows how many times each class
is present, and `sort()` sorts the table to ascending order.

There are 13 samples from patients having ADHD, and 14 control samples.

    sort(table(colData(tse)$patient_status))

    ## 
    ##    ADHD Control 
    ##      13      14

Manipulate the data
-------------------

### Transformations

Abundances are always relative even though absolute counts are
calculated. That is due to technical aspects of the data generation
process (see e.g. [Gloor et al.,
2017](https://www.frontiersin.org/articles/10.3389/fmicb.2017.02224/full)).
Below, we calculate relative abundances as these are usually easier to
interpret than plain counts. For some statistical models we need to
transform the data into other formats as explained in above link (and as
we will see later).

    # Calculates relative abundances, and stores the table to assays
    tse <- transformCounts(tse, method = "relabundance")

### Aggregation

We might want to know, which taxonomic rank is, e.g., the most abundant.
We can easily agglomerate the data based on taxonomic ranks. Here, we
agglomerate the data at Phylum level.

    tse_phylum <- agglomerateByRank(tse, rank = "Phylum")

    # Show dimensionality
    dim(tse_phylum)

    ## [1]  5 27

Now there are 5 taxa and 27 samples. It means that there are 5 different
Phylum level taxa. From `rowData` we might see little bit easier, how
ranks are agglomerated. For example, all Firmicutes are combined
together. That is why all lower rank information is lost. From assay we
could see, that all abundances of taxa that belongs to Firmicutes are
summed up.

    knitr::kable(head(rowData(tse_phylum)))

<table>
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
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">Verrucomicrobia</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Verrucomicrobia</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Proteobacteria</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Proteobacteria</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="even">
<td style="text-align: left;">Firmicutes</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Firmicutes</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
<tr class="odd">
<td style="text-align: left;">Cyanobacteria</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Cyanobacteria</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
<td style="text-align: left;">NA</td>
</tr>
</tbody>
</table>

Argument na.rm = FALSE in default. When na.rm = TRUE, taxa that do not
have information in specified level is removed. When na.rm = FALSE, they
are not removed. Then those taxa that do not have information in
specified level are agglomerated at lowest possible level that is left
after agglomeration.

    temp <- rowData(agglomerateByRank(tse, rank = "Genus"))

    # Prints those taxa that do not have information in Genus level
    knitr::kable(head(temp[temp$Genus == "",]))

<table>
<colgroup>
<col style="width: 22%" />
<col style="width: 7%" />
<col style="width: 13%" />
<col style="width: 17%" />
<col style="width: 17%" />
<col style="width: 16%" />
<col style="width: 5%" />
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
<td style="text-align: left;">Family:Lachnospiraceae</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Firmicutes</td>
<td style="text-align: left;">Clostridia</td>
<td style="text-align: left;">Clostridiales</td>
<td style="text-align: left;">Lachnospiraceae</td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">Order:Bacteroidales</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Bacteroidetes</td>
<td style="text-align: left;">Bacteroidia</td>
<td style="text-align: left;">Bacteroidales</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">Order:Clostridiales</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Firmicutes</td>
<td style="text-align: left;">Clostridia</td>
<td style="text-align: left;">Clostridiales</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
<tr class="even">
<td style="text-align: left;">Family:Enterobacteriaceae</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Proteobacteria</td>
<td style="text-align: left;">Gammaproteobacteria</td>
<td style="text-align: left;">Enterobacteriales</td>
<td style="text-align: left;">Enterobacteriaceae</td>
<td style="text-align: left;"></td>
</tr>
<tr class="odd">
<td style="text-align: left;">Order:Gastranaerophilales</td>
<td style="text-align: left;">Bacteria</td>
<td style="text-align: left;">Cyanobacteria</td>
<td style="text-align: left;">Melainabacteria</td>
<td style="text-align: left;">Gastranaerophilales</td>
<td style="text-align: left;"></td>
<td style="text-align: left;"></td>
</tr>
</tbody>
</table>

Here agglomeration is done similarly, but na.rm = TRUE

    temp2 <- rowData(agglomerateByRank(tse, rank = "Genus", na.rm = TRUE))

    print(paste0("Agglomeration with na.rm = FALSE: ", dim(temp)[1], " taxa."))

    ## [1] "Agglomeration with na.rm = FALSE: 54 taxa."

    print(paste0("Agglomeration with na.rm = TRUE: ", dim(temp2)[1], " taxa."))

    ## [1] "Agglomeration with na.rm = TRUE: 49 taxa."

Visualization
-------------

For plotting, we use miaViz package. We can plot the Phylum level
abundances.

    # Here we specify "relabundance" to be abundance table that we use for plotting.
    # Note that we can use agglomerated or non-agglomerated tse as an input, because
    # the function agglomeration is built-in option. 

    # Legend does not fit into picture, so its height is reduced.
    plot_abundance <- plotAbundance(tse, abund_values="relabundance", rank = "Phylum") +
      theme(legend.key.height = unit(0.5, "cm")) +
      scale_y_continuous(label = scales::percent)

    ## Scale for 'y' is already present. Adding another scale for 'y', which will
    ## replace the existing scale.

    plot_abundance 

    ## Warning in grid.Call.graphics(C_rect, x$x, x$y, x$width, x$height,
    ## resolveHJust(x$just, : semi-transparency is not supported on this device:
    ## reported only once per page

![](explore_files/figure-markdown_strict/unnamed-chunk-10-1.png)

From density plot, we could see, e.g., what is the most common
abundance. Here we plot distribution of Firmicutes relative abundances
in different samples. Density plot can be seen as smoothened histogram.

From the plot, we can see that there are peak when abundance is little
bit under 30 %.

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

![](explore_files/figure-markdown_strict/unnamed-chunk-11-1.png)

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

For more visualization options and examples, see the [miaViz
vignette](https://microbiome.github.io/miaViz/articles/miaViz.html).
