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

