# Course material: miaverse basics 

**Welcome to [Radboud Summer School, July 2021](https://www.ru.nl/radboudsummerschool/courses/2021/brain-bacteria-behaviour/)**

<img src="https://user-images.githubusercontent.com/60338854/121848694-1072a480-ccf3-11eb-9af2-7fdefd8d1794.png" alt="ML4microbiome" width="50%"/>

Figure source: Moreno-Indias _et al_. (2021) [Statistical and Machine Learning Techniques in Human Microbiome Studies: Contemporary Challenges and Solutions](https://doi.org/10.3389/fmicb.2021.635781). Frontiers in Microbiology 12:11. 


## miaverse

The [_miaverse_](https://microbiome.github.io) (mia = **MI**crobiome **A**nalysis) is an
R/Bioconductor framework for microbiome data science. It aims to
extend the capabilities of another popular framework,
[phyloseq](https://joey711.github.io/phyloseq/).

The miaverse framework consists of an efficient data structure based
on the SummarizedExperiment class, an associated package ecosystem,
demonstration data sets, and comprehensive documentation. These are
explained in more detail in the online book [Orchestrating Microbiome
Analysis](https://microbiome.github.io/OMA).

This training material walks you through an example workflow that
shows the standard steps of taxonomic data analysis covering data
access, exploration, analysis, visualization and reporoducible
reporting. **You can run the workflow by simply copy-pasting the
examples.** For advanced material, you can test and modify further
examples from the [OMA book](https://microbiome.github.io/OMA), or try
to apply the techniques to your own data.


## Acknowledgments

**Citation** "Radboud summer school training material for miaverse (2021). Tuomas
Borman, Felix Ernst, Henrik Eckermann, Leo Lahti".

**Contact** [Leo Lahti](http://datascience.utu.fi), University of Turku and [mia Collective](https://microbiome.github.io)

**License** All material is released under the open [CC BY-NC-SA 3.0 License](LICENSE).

- Landing page (html): [miaverse teaching material](https://microbiome.github.io/course_2021_radboud/)
- Source code (github): [miaverse teaching material](https://github.com/microbiome/course_2021_radboud)

This repository is fully reproducible. It contains the Rmd files
includes executable code. All files can be rendered at one go by
running the file [main.R](main.R). See the file for details on how to
clone the repository and convert it into a gitbook.
