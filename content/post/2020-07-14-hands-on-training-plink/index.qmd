---
title: 'Hands-On Training: plink'
author: ''
date: '2020-07-14'
slug: hands-on-training-plink
categories:
  - how_to
tags: []
---


**LATEST VERSION IN https://bios25328.hakyimlab.org/post/2021/04/07/plink-tutorial/**

## Basic Commands

- here's a list of some of the basic commands you will learn about 
- We will go more in depth for each one below

Command       |       Function
--------------|--------------------------------------
--file        |       loads a file in ascii format
--bfile       |       loads a file in binary format
--make-bed    |       converts an ascii file to binary
--out         |       specifies what you want to name your output
--freq        |       generates minor allele frequencies

A more detailed tutorial for GWAS analysis is [here](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6001694/).


## Introduction

We will learn to run a GWAS using plink.  
This tutorial follows a plink tutorial you can find [here](https://zzz.bwh.harvard.edu/plink/tutorial.shtml)

- [ ] First, download plink into a new file /Users/<username>/demo/
```{bash, download plink, eval=FALSE}
DEMO="/Users/<yourusername>/demo"

```

- [ ] Download the [example data](https://zzz.bwh.harvard.edu/plink/hapmap1.zip) we will be using.  
  - Note that this data is not real and is only intended to be used as an example for using plink.  

Whenever running plink commands, you first have to indicate you're using plink by typing the full path to it.  

- [ ] To avoid writing out the same path over and over again, we will define a variable that contains the path to plink.
```{bash, plink path, eval=FALSE}
plink="Users/<username>/demo/plink"

```


## PED and MAP files

- PED and MAP files are plain text files that contain a table of part of your data
- Together, they make up all of the data of the study you're doing

- [ ] Look at the first few lines of your PED file by copy and pasting this command
```{bash, ped head, eval=FALSE}
cut -d ' ' -f  1-6  hapmap1.ped | head

```
- Each row represents a different individual.  
- PED files start with 6 informative columns about each individual.  
1) Family ID
2) Individual ID
3) Paternal ID
4) Maternal ID
5) Sex
    - 1 = male, 2 = female, other = unknown
6) Phenotype
    - Can be quantitative or an affection status
    - The default values for affection status is: 1 = unaffected, 2 = affected, 0 = missing, -9 = missing

- Every column after these is the data for the individual's genotypes
  - Each marker is biallelic, meaning there's two genotypes for each column, paternal and maternal.  

- [ ] Now look at the beginning of your MAP file
```{bash, map head, eval=FALSE}
head hapmap1.map

```
- Each row represents a different SNP.
- there are 4 informative columns.
1) Chromosome #
2) SNP identifier
3) Genetic distance (in centimorgans)
4) Base-pair position
- every row here corresponds to a genotype column in the ped file to indicate the position of those genotypes
  - the first row here corresponds to the first genotype column in the .ped (after the first ID-ing 6), the second row here to the next column there, and so on


## Binary Files

It's helpful to compress your data to speed up analysis and data processing  
One way to do this is to convert your files to binary format

- [ ] Convert your .ped and .map files to binary
```{bash, binary, eval=FALSE}
plink --file hapmap1 --make-bed --out hapmap1

```
These are the three plink commands we used:  
- *--file hapmap1*: specifies that we want to use the hapmap1 files  
- *--make-bed*: converts that file to binary  
- *--out hapmap1*: names our output files hapmap1  
    - if you don't specify a name for your output, it defaults to "plink"
- If you look at your hapmap folder, you'll see four new files
  - .bed: binary .ped
  - .bim: binary .map
  - .fam: copy of the first 6 column of .ped
  - .log: a log of what commands were run and what it printed

  
## Minor Allele Frequencies

- [ ] Find the minor allele frequencies of your data and look at the head
```{bash, maf, eval=FALSE}
plink --file hapmap1 --freq --out maf
head maf.freq

```
- There are 6 columns 
1) Chromosome #
2) SNP ID
3) Minor Allele
4) Major Allele
5) Minor Allele Frequencies
6) Number of Allele Observations


## Run a GWAS
- When you "run a GWAS," it just means you're finding the association between your SNPs and the phenotypes.
- In plink, you use the --assoc command to do this
- [ ] Run a GWAS and look at the head
```{bash, GWAS, eval=FALSE}
plink --file hapmap1 --assoc --out as
head as.assoc

```
- There are 10 columns
1) Chromosome #
2) SNP ID
3) Base pair
4) Minor Allele
5) Frequency of the minor allele in affected individuals
6) Frequency of the minor allele in unaffected idividuals
7) Major Allele
8) Chi-squared statistic
    - The difference between the data you observed and the data you expected under the null hypothesis
9) P-value
10) Odds ratio


## Manhattan Plot 

Now we will graph a Manhattan plot of our association data
We will do this in R using the "qqman" package
- [ ] First, download qqman
```{r, Manhattan, eval = FALSE}
library(qqman)

```

- [ ] Read your association table and set it to a variable
```{r, eval=FALSE}
mydata <- read_table("/Users/<username>/...", header = TRUE)

```

- Now if you try to plot mydata, R will give you an error because there are NA values in it.
- To get rid of the NA values, use the command *na.omit*
- [ ] Take out the NA values
```{r, eval=FALSE}
mydata2 <- na.omit(mydata)

```
- [ ] Now you're ready to graph your manhattan plot!
```{r, eval=FALSE}
manhattan(mydata2)

```

## QQ Plot

the qq() function takes in a vector instead of a table.  
When graphing our data in qq plots we use the p-values
- [ ] Graph your p values
```{r, qqplot, eval=FALSE}
qqplot(mydata2$P)

```



we will read the hapmap1.ped file. typically genotype files are too large to load into memory but in this example it takes 28MB, which is fine with current computers. As a rule of thumb (in a laptop with 16Gb of ram, try not to load files that are more than 1GB)
```{r, eval=FALSE}

hapmap1_ped = read_table("/Users/lvairus/Desktop/hapmap1/hapmap1.ped")

```

