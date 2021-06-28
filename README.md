# Course

## Welcome to miaverse basics training material

**Raboud Summer School 2021**

<img src="https://user-images.githubusercontent.com/60338854/121848694-1072a480-ccf3-11eb-9af2-7fdefd8d1794.png" alt="ML4microbiome" width="50%"/>


This site contains the sources for [miaverse teaching material](https://microbiome.github.io/course_2021_radboud/) for [Radboud Summer School 7/2021](https://www.ru.nl/radboudsummerschool/courses/2021/brain-bacteria-behaviour/).


## miaverse

miaverse (mia = **MI**crobiome **A**nalysis) is an R ecosystem for microbiome analysis. It utilizes standard data 
structure called **TreeSummarizedExperiment**. It extends **SingleCellExperiment** class by
providing slots for phylogenetic tree and sample tree. 

TreeSummarizedExperiment works as a container of different kind of information that is 
obtained from the data set. Similarly, e.g., to **phyloseq** class, TreeSummarizedExperiment 
includes standardized slots. Each of this classes can store specific kind of information. For example,
assays can store abundance tables, and rowData information about taxa.
The main advantage of TreeSummarizedExperiment compared to phyloseq is that it can store
lots of more data than phyloseq.

Currently, miaverse includes two packages: one for data analysis and one for visualization. 
**mia** package includes wide variety of different kind of functions for data analysis. 
**miaViz** is the package for visualization. The aim is to enable easy, reliable, and efficient 
way to analyze microbiome data. 

## Example workflow

This workflow demonstrates the use of miaverse using data from the
following publication, which you can check for a more detailed
description of the samples and experimental design: Tengeler AC et al. (2020) [**Gut
microbiota from persons with attention-deficit/hyperactivity disorder
affects the brain in
mice**](https://doi.org/10.1186/s40168-020-00816-x). Microbiome 8:44.

In this study, mice are colonized with microbiota from participants with 
ADHD (attention deficit hyperactivity disorder) and healthy participants. 
The aim of the study was to assess whether the mice display ADHD behaviors after being 
inoculated with ADHD microbiota, suggesting a role of the microbiome in ADHD pathology.

**You can run the workflow by cloning the repository or you can apply it to your own data, 
e.g., by copy-pasting and tuning the code to fit to your data.**

Material in an html format can be found from [here](https://microbiome.github.io/course_2021_radboud/).

Repository can be found from [here](https://github.com/microbiome/course_2021_radboud).
- Rmd files includes executable code 
- All files can be rendered at one go by running the file main.R

## Further resources

 * Open online book (beta version):
   [Orchestrating Microbiome Analysis](https://microbiome.github.io/OMA).

 * [**mia** project](https://microbiome.github.io)

## References 

The material can be attributed to the following sources (kindly cite):

 * Authors: Leo Lahti, Tuomas Borman, Henrik Eckermann
 * Contact: [Leo Lahti](http://datascience.utu.fi), University of Turku 
 * [Mia Collective](https://microbiome.github.io)
 
Data is from article:

Tengeler AC, Dam SA, Wiesmann M, Naaijen J, van Bodegom M, 
Belzer C, Dederen PJ, Verweij V, Franke B, Kozicz T, Vasquez AA & Kiliaan AJ (2020)
[**Gut microbiota from persons with attention-deficit/hyperactivity disorder affects the brain in mice**](https://doi.org/10.1186/s40168-020-00816-x).
Microbiome 8:44. 

Front page image is from article: 

Moreno-Indias I, Lahti L, Nedyalkova M, Elbere I, Roshchupkin G, Adilovic M, Aydemir O,
Bakir-Gungor B, Santa Pau EC, D’Elia D, Desai MS, Falquet L, Gundogdu A, Hron K, Klammsteiner T,
Lopes MB, Marcos-Zambrano LJ, Marques C, Mason M, May P, Pašić L, Pio G, Pongor S, Promponas VJ,
Przymus P, Saez-Rodriguez J, Sampri A, Shigdel R, Stres B, Suharoschi R, Truu J, Truică C,
Vilne B, Vlachakis D, Yilmaz E, Zeller G, Zomer AL, Gómez-Cabrero D & Claesson MJ (2021)
[**Statistical and Machine Learning Techniques in Human Microbiome Studies: Contemporary Challenges and Solutions**](https://doi.org/10.3389/fmicb.2021.635781). 
Frontiers in Microbiology 12:11. 

## License

All material is released under the open [CC BY-NC-SA 3.0 License](LICENSE).


