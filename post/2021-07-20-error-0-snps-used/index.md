---
title: 'Error: 0 % SNPs used'
author: Festus
date: '2021-07-20'
slug: error-0-snps-used
categories:
  - FAQ
tags:
  - PrediXcan
---

- Mismatch between the model SNP ids and geneotype/gwas SNP ids, e.g using model rsids to match with genotype variant_ids
- When having different genome builds use chr{}*{}*{}_{}_b38" for the --on_the_fly_mapping argument. This parameter specifies a format string to be used when building a variant id from its (liftover coordinates) and alleles (genotype). Then these ids will be matched to the ids in the mashr/elastic net model which are all hg38-based.
- You can use a text variant mapping instead of on_the_fly_mapping as below

    > The argument you would need to use is: -variant_mapping /path/to/tab-separated-file.txt KEYNAME VALUENAME where:

    > a) path refers to a simple tabular file

    > b) KEYNAME is the name of the column with your input variants

    > c) VALUENAME is the name of the column with the mapped variant as existing in a model (NA would cause the model to be ignored)

- When you are using mashr models they don't use RSIDs so you need to let S-PrediXcan
 knows this is the case with the additional command line arguments:

    > **-keep_non_rsid —additional_output --model_db_snp_key varID**