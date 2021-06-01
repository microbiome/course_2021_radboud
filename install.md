# Installation of the necessary R packages

This notebook shows how to install all required packages. The
installation needs to be done just once.

    # List of packages that we need from cran and bioc 
    cran_pkg <- c("BiocManager", "dplyr", "ecodist", "ggplot2", "gridExtra", "knitr", "vegan")
    bioc_pkg <- c("ANCOMBC", "ape", "DESeq2",  "DirichletMultinomial", "mia", "miaViz")

    # Gets those packages that are already installed
    cran_pkg_already_installed <- cran_pkg[ cran_pkg %in% installed.packages() ]
    bioc_pkg_already_installed <- bioc_pkg[ bioc_pkg %in% installed.packages() ]

    # Gets those packages that need to be installed
    cran_pkg_to_be_installed <- setdiff(cran_pkg, cran_pkg_already_installed)
    bioc_pkg_to_be_installed <- setdiff(bioc_pkg, bioc_pkg_already_installed)

    # If there are packages that need to be installed, installs them
    if( length(cran_pkg_to_be_installed) ) {
       install.packages(cran_pkg_to_be_installed)
    }

    # If there are packages that need to be installed, installs them
    if( length(bioc_pkg_to_be_installed) ) {
       BiocManager::install(bioc_pkg_to_be_installed, ask = F)
    }

    # Loading all packages into session
    sapply(c(cran_pkg , bioc_pkg), require, character.only = TRUE)

    ##          BiocManager                dplyr              ecodist              ggplot2            gridExtra                knitr 
    ##                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE 
    ##                vegan              ANCOMBC                  ape               DESeq2 DirichletMultinomial                  mia 
    ##                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE                 TRUE 
    ##               miaViz 
    ##                 TRUE
