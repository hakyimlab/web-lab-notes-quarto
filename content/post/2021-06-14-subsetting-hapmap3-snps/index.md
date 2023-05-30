---
title: Subsetting HapMap3 SNPs
author: Yanyu Liang
date: '2021-06-14'
slug: subsetting-hapmap3-snps
categories:
  - how_to
tags: []
---

# About

This is the readme of the codes [here](https://github.com/liangyy/misc-tools/tree/master/hapmap3_snps).

This module extract HapMap 3 SNPs for downstream use.
Download data from [https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/hapmap3_r3/plink_format/](https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/hapmap3_r3/plink_format/)

The workflow is based on `snakemake` and it contains the following steps:
1. Extract SNP information from PED file (`rule get_bim_file`)
2. Extract individuals from the desired population (`rule extract_individuals`)
3. Compute MAF among the extracted individuals from step 2 (`rule compute_maf`)
4. Filter the SNPs based on the MAF calculated in step 3 (`rule filter_by_maf`)
5. Filter out ambiguous SNPs. Also, the non-SNV SNPs or SNPs without rsID or SNPs outside chr1-chr22 are filtered out (`rule filter_by_ambiguity`)
6. Annotate the extracted SNPs (from step 5) with genomic position and MAF. If specified, also do liftover (`rule gen_lookup_table`)

If one wants to do liftover, then `chain_file` should be specified.
The `target_build` should always be specified and it will be added as an column to the final output. 
Please make sure that it is correct. 
For HapMap 3 SNPs considered here, the original build is b36 and if using liftover, one should assign `chain_file` with the final build after liftover. 
For instance, if use chain file `hg18ToHg19.over.chain.gz`, one should set `chain_file` to hg19 or b37.
Note that liftover will result loss of SNPs since some SNPs may fail to be liftover.
For instance, in the example run:
* MAF = 0.01: For b36 -> b37, the number of SNPs goes from 1108410 to 1108189 
* MAF = 0.05: For b36 -> b37, the number of SNPs goes from 1007394 to 1007190

# Dependency 

* python3: see imlabtools conda env at [here](https://github.com/hakyimlab/MetaXcan#example-conda-environment-setup)
* plink1.9
* snakemake
* Clone the repo: [https://github.com/liangyy/misc-tools](https://github.com/liangyy/misc-tools)

# Example run on CEU

Also, see `run_example/` for the full details.

```
# build b36
## maf = 0.01
snakemake -s hapmap.snmk --configfile config.hapmap3_eur.yaml -p --config maf=0.01 target_build=b36
## maf = 0.05
snakemake -s hapmap.snmk --configfile config.hapmap3_eur.yaml -p --config maf=0.05 target_build=b36

# build b37
## maf = 0.01
snakemake -s hapmap.snmk --configfile config.hapmap3_eur.yaml -p --config maf=0.01 target_build=b37 chain_file=[path-to/hg18ToHg19.over.chain.gz]
## maf = 0.05
snakemake -s hapmap.snmk --configfile config.hapmap3_eur.yaml -p --config maf=0.05 target_build=b37 chain_file=[path-to/hg18ToHg19.over.chain.gz]
```

The resulting files of the test run are here: 
* [maf = 0.01, build = b36](https://uchicago.box.com/s/n6oqakmu8g2unsspa5z1fyr8dn060o8b)
* [maf = 0.05, build = b36](https://uchicago.box.com/s/t1ock2xoyanun9umlkwkifvkjy1vda32)
* [maf = 0.01, build = b37](https://uchicago.box.com/s/junrcgxwpuyck03r6gq88j9b18g18vf5)
* [maf = 0.05, build = b37](https://uchicago.box.com/s/sj0xsd0wbvty9dgxx0jewjw0tnd8aoch) 

# how to download the hapmap files

wget https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/hapmap3_r3/plink_format/00README.txt
wget https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/hapmap3_r3/plink_format/hapmap3_r3_b36_fwd.consensus.qc.poly.map.gz
wget https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/hapmap3_r3/plink_format/hapmap3_r3_b36_fwd.consensus.qc.poly.ped.gz
wget https://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/hapmap3_r3/plink_format/hapmap3_r3_b36_fwd.qc.poly.tar.gz

** see copy of the files in https://uchicago.box.com/s/tccjhavco9cifwddyy2bmd0qtiwk0mp2