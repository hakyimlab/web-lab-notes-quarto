---
title: How to annotate genes - BioMart Basics
author: Sabrina Mi
date: '2022-06-28'
slug: query-gene-annotations-from-biomart
categories:
  - cheatsheet
tags: []
---

## About BioMart

BioMart is a database containing Ensembl annotations of genes across many species and builds. To query data, you first pick one the databases:
1. Ensembl Genes
2. Ensembl Variation
3. Ensembl Variation
4. Vega

We typically uses only the Ensembl Genes database, which lists all genes for the selected species and build, along with their positions, alternate names, and other descriptions.

## Querying Gene Annotations

The full tutorial is [online](https://useast.ensembl.org/info/data/biomart/how_to_use_biomart.html). Below is a quick [example from here](example_query.R).

```
library(tidyverse)

## install biomaRt if not avalable
## if (!require("BiocManager", quietly = TRUE))
##     install.packages("BiocManager")
## BiocManager::install("biomaRt")

library(biomaRt)

# connect to BioMart database, choosing gene annotations for rats
ensembl = useMart(biomart="ENSEMBL_MART_ENSEMBL", dataset = "rnorvegicus_gene_ensembl")

# returns the type of information we can query from the dataset
listAttributes(mart=ensembl)$name %>% unique

# query all relevant data and store in a dataframe
orth.rat = getBM( attributes=
                    c("ensembl_gene_id", 
                      "hsapiens_homolog_ensembl_gene",
                      "external_gene_name"),
                  filters = "with_hsapiens_homolog",
                  values =TRUE,
                  mart = ensembl,
                  bmHeader=FALSE)

# write to file
write.table(orth.rat, file="ortholog_genes_rats_humans.tsv", sep=\t, header=TRUE, quote=FALSE)
```
