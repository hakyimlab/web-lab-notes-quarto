---
title: GWAS on ANL Servers
author: ''
date: '2001-07-30'
slug: gwas-on-anl-servers
categories:
  - how_to
tags: []
---


Steps to running the GWAS on ANL's servers. 
 
 1. Install Hail and its dependencies
 2. Filter genotype files
 3. Phenotype and Covariate Files
 4. Set up GWAS environment
 
## Install Hail

This was done by Tom Brettin. Hail is working on the nucleus machine, but not washington at the moment.

## Filter Genotype Files

Downstream analysis can be a lot faster with a smaller genetic dataset. We filtered for individuals in the brain imaging cohort, and for typical GWAS population conditions: white British ancestry, not related to others in cohort, good SNP call rate, etc.

The exact list of eids is at `/vol/bmd/meliao/data/eids/intersection_brain_asthma.txt`, which is so named because the sample filters wre taken from the ukbREST example asthma query. The filtering was run with plink using file `filter_bgen_files.sh`. 

This filtering has mostly been done in `plink2`.

## Phenotype and Covariate Files


## Set up GWAS environment

There is a hail environment available on the ANL servers accessible by the command 
```
conda activate /vol/bmd/software/condaenvs/hail
```


## Interpret Results

