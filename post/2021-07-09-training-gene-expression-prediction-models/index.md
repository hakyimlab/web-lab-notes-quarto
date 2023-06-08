---
title: Training Gene Expression Prediction Models
author: Haky Im
date: '2021-07-09'
slug: training-gene-expression-prediction-models
categories:
  - how_to
tags: []
---

PrediXcan and TWAS methods in general correlate genetically predicted levels of gene expression traits with complex traits to understand the mechanism behind GWAS loci. A key component is the training of gene expression traits. A tutorial on how to generate elastic net models can be found [in this link](https://github.com/hakyimlab/PredictDB-Tutorial)

Elastic net is a good all purpose prediction approach for complex traits and has been shown to perform well for gene expression traits. Depending on your goals, you may want to use a different approach. For example, if the goal is to maximize the reliability (low false positive) of putatively causal genes, then we showed that a method that uses genetic variants more likely to be causal may work better. [Explained in this paper](https://onlinelibrary.wiley.com/doi/10.1002/gepi.22346). In the GTEx GWAS subgroup we chose the models that are based on fine-mapping, called mashr-based. 
