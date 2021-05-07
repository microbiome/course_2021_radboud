# Data exploration (explore.Rmd)
 
Investigate contents of the data object:
- Show data dimensionality (taxa vs. samples)
- Show (beginning of) taxonomic table (in rowdata)
- Show (beginning of) sample data (in coldata)
- Show table of sample sizes per Genotype: sort(table(colData(tse)$Genotype))

Manipulate the data
- Aggregate abundances at the Phylum level
- Show again data dimensionality (taxa vs. samples)

Visualize data:
- Visualize abundance distribution of all phyla across samples (some example from miaViz)
- Visualize density plot for a single Phylum (Firmicutes?)


# Alpha diversity (alpha.Rmd)

Show how to calculate Shannon and Faith diversity with the example data

Histogram of Shannon diversities

Cross-plot comparing these two indices across samples

Boxplot comparing diversity between different Genotypes; and between different Diets

Use Wilcoxon test to calculate p-value for the difference in Shannon between Diets (Control vs. Western)


# Beta diversity (beta.Rmd)


## Examples of PCoA with different settings

PCoA for ASV-level data with Bray-Curtis

PCoA for ASV-level data with CLR transformation + Euclidean distance

PCoA aggregated to Phylum level with CLR transformation + Euclidean distance


## Examples on showing external variables on PCoA plot

PCoA with some discrete sample grouping variable shown with colors

PCoA with some continuous sample grouping variable shown with colors


## Example on clustering

Dirichlet-Multinomial Mixture clustering (ask Chandler for example; he
has Rmd file that does this for another data set). Just show how to
run DMM clustering and decide the number of clusters.

PCoA for ASV-level data with Bray-Curtis; with DMM clusters shown with
colors


## Example of associations

PERMANOVA example (see section 6.3.1-6.3.2 in [OMA](https://microbiome.github.io/OMA/microbiome-diversity.html#beta-diversity))





