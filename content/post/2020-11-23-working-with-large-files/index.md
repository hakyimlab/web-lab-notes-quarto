---
title: Working with Large Files
author: Sabrina Mi
date: '2020-11-23'
slug: working-with-large-files
categories: []
tags:
  - how to
  - programming tips
description: ''
topics: []
---

When working with large datasets, only the files with code should be pushed to Github repositories, not the data itself. The raw data inputs or analysis output should either be kept in a local directory that is never committed, or for best practices, they should be stored in Box ([download](https://www.box.com/resources/downloads)).

Once installed, you can navigate Box folders from Mac Finder or Windows Explorer. Files in Box Drive are also identified by a local path.

First, check that you have access to the [imlab-data](https://uchicago.box.com/s/mbsgna6ge5d4u4xwx7hor8xhnsx51wik) folder on Box. It should also appear in the Box Drive folder in Finder or Explorer, but you may need to first request access permission from Haky.

Next, create a directory in the data-Github folder, `Box/imlab-data/data-Github`, with the same name as the Github repository for the analysis. Copy all input files into the data-Github folder and create an output folder.

For example, I made a folder in data-Github, rat-genomic-analysis, and added the genotype data and model. Then I ran PrediXcan and output the results directly to `/Users/sabrinami/Box/imlab-data/data-Github/rat-genomic-analysis/Results/PrediXcan`

```
conda activate imlabtools

python3 /Users/sabrinami/Github/MetaXcan/software/Predict.py \
--model_db_path /Users/sabrinami/Box/imlab-data/data-Github/rat-genomic-analysis/sql/Vo_output_db.db  \
--text_genotypes /Users/sabrinami/Box/imlab-data/data-Github/rat-genomic-analysis/output/genotypes/chr1_20.txt.gz  \
--text_sample_ids /Users/sabrinami/Box/imlab-data/data-Github/rat-genomic-analysis/output/genotypes/samples.txt \
--prediction_output /Users/sabrinami/Box/imlab-data/data-Github/rat-genomic-analysis/Results/PrediXcan/Vo__predict.txt \
--prediction_summary_output /Users/sabrinami/Box/imlab-data/data-Github/rat-genomic-analysis/Results/PrediXcan/Vo__summary.txt \
--verbosity 1 \
--throw

```

## here is a semi-automated way to generate and open the data folder in box

Copy pasted it to the beginning of your Rmd file

```
suppressMessages(library(tidyverse))
suppressMessages(library(glue))
PRE = "/Users/haekyungim/Library/CloudStorage/Box-Box/LargeFiles/imlab-data/data-Github/web-data"
##PRE="/Users/temi/Library/CloudStorage/Box-Box/imlab-data/data-Github/web-data"
## COPY THE DATE AND SLUG fields FROM THE HEADER
SLUG="correlation-between-ptrs-and-rat-height-bmi" ## copy the slug from the header
bDATE='2022-07-07' ## copy the date from the blog's header here
DATA = glue("{PRE}/{bDATE}-{SLUG}")
if(!file.exists(DATA)) system(glue::glue("mkdir {DATA}"))
WORK=DATA

## move data to DATA
#tempodata=("~/Downloads/tempo/gwas_catalog_v1.0.2-associations_e105_r2022-04-07.tsv")
#system(glue::glue("cp {tempodata} {DATA}/"))
system(glue("open {DATA}")) ## this will open the folder 
```
