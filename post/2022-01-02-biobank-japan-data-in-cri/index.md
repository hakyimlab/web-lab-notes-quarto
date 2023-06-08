---
title: Biobank Japan Data in CRI
author: Sabrina Mi
date: '2022-01-02'
slug: biobank-japan-data-in-cri
categories: []
tags: []
---

**BBJ data directory:** `\gpfs/data/im-lab/nas40t2/Data/BBJ`

I first downloaded and decrypted Biobank Japan data ([instructions](https://lab-notes.hakyimlab.org/post/2020/07/30/downloading-data-from-biobank-japan/)), then organized into subdirectories `BBJ-genotypes-decrypted` and `BBJ-phenotypes-decrypted`, in their original form.

## Phenotypes

**BBJ phenotypes file:** `gpfs/data/im-lab/nas40t2/Data/BBJ/BBJ-phenotypes.csv`

This CSV combines all phenotype data in the `BBJ-phenotypes-decrypted` subdirectory into one file.
The original BBJ phenotype data in `BBJ-phenotypes-decrypted`, was bulky and used dataset IDs instead of phenotype names.  The file `BBJ-phenotype-list.txt` contains all the phenotypes and their folder names ([download](BBJ-phenotype-list.txt))

I created the combined phenotype file with the following [script](process-phenotypes.py):

```
python3 process-phenotypes.py --BBJ_folder /Users/sabrinami/BBJ/BBJ-phenotypes \
--phenotype_mapping /Users/sabrinami/Github/analysis-sabrina/BBJ-data-processing/BBJ-phenotype-list.txt \
--output /Users/sabrinami/Github/analysis-sabrina/BBJ-data-processing/BBJ-phenotypes.csv
```

## Genotypes

**BBJ genotypes folder:** `gpfs/data/im-lab/nas40t2/Data/BBJ/BBJ-genotypes-decrypted`




