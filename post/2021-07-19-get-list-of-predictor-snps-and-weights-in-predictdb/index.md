---
title: Get list of predictor SNPs and weights in predictdb
author: Haky Im
date: '2021-07-19'
slug: get-list-of-predictor-snps-and-weights-in-predictdb
categories:
  - how_to
tags: []
editor_options: 
  chunk_output_type: console
---

To get a list of SNPs and the corresponding weights to predict
expression levels (or splicing) of a given gene, you will first need to
download the databases where the prediction models are stored. For
example, you can download them from
[here](https://zenodo.org/record/3518299#.YPXA4G5Olqs) more specifically
[from this tar
file](https://zenodo.org/record/3518299/files/mashr_eqtl.tar?download=1)

On CRI they are located in
`/gpfs/data/im-lab/nas40t2/Data/PredictDB/GTEx_v8/models_v1/eqtl/mashr/`

Here I will mount the drive to my local machine following [these
instructions](https://lab-notes.hakyimlab.org/post/2021/07/12/map-cri-storage-to-your-computer/)

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.3.1 ──

    ## ✓ ggplot2 3.3.3     ✓ purrr   0.3.4
    ## ✓ tibble  3.1.2     ✓ dplyr   1.0.6
    ## ✓ tidyr   1.1.3     ✓ stringr 1.4.0
    ## ✓ readr   1.4.0     ✓ forcats 0.5.1

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
model_dir = "/Volumes/im-lab/nas40t2/Data/PredictDB/GTEx_v8/models_v1/eqtl/mashr"
```

Get ensemblid for the gene. For example GSDMA's ensid is ENSG00000167914

``` r
## install.packages("RSQLite")
library("RSQLite")
sqlite <- dbDriver("SQLite")
df = data.frame()
dbnamelist= list.files(model_dir,pattern = "*.db")
for(dbname in dbnamelist)
{
  print("--")
  print(dbname)
  ## connect to db
  db = dbConnect(sqlite,glue::glue("{model_dir}/{dbname}"))
  ## list tables
  tempo <- dbGetQuery(db,"select * from weights where gene like 'ENSG00000167914%'") ## % is wildcard, to avoid dealing with ENSG version number
  if(nrow(tempo)>0) 
  {
    tempo$tissue <- gsub("mashr_","",gsub(".db","",dbname))
    df = rbind(df,tempo)
  }
}
```

    ## [1] "--"
    ## [1] "mashr_Adipose_Subcutaneous.db"
    ## [1] "--"
    ## [1] "mashr_Adipose_Visceral_Omentum.db"
    ## [1] "--"
    ## [1] "mashr_Adrenal_Gland.db"
    ## [1] "--"
    ## [1] "mashr_Artery_Aorta.db"
    ## [1] "--"
    ## [1] "mashr_Artery_Coronary.db"
    ## [1] "--"
    ## [1] "mashr_Artery_Tibial.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Amygdala.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Anterior_cingulate_cortex_BA24.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Caudate_basal_ganglia.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Cerebellar_Hemisphere.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Cerebellum.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Cortex.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Frontal_Cortex_BA9.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Hippocampus.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Hypothalamus.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Nucleus_accumbens_basal_ganglia.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Putamen_basal_ganglia.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Spinal_cord_cervical_c-1.db"
    ## [1] "--"
    ## [1] "mashr_Brain_Substantia_nigra.db"
    ## [1] "--"
    ## [1] "mashr_Breast_Mammary_Tissue.db"
    ## [1] "--"
    ## [1] "mashr_Cells_Cultured_fibroblasts.db"
    ## [1] "--"
    ## [1] "mashr_Cells_EBV-transformed_lymphocytes.db"
    ## [1] "--"
    ## [1] "mashr_Colon_Sigmoid.db"
    ## [1] "--"
    ## [1] "mashr_Colon_Transverse.db"
    ## [1] "--"
    ## [1] "mashr_Esophagus_Gastroesophageal_Junction.db"
    ## [1] "--"
    ## [1] "mashr_Esophagus_Mucosa.db"
    ## [1] "--"
    ## [1] "mashr_Esophagus_Muscularis.db"
    ## [1] "--"
    ## [1] "mashr_Heart_Atrial_Appendage.db"
    ## [1] "--"
    ## [1] "mashr_Heart_Left_Ventricle.db"
    ## [1] "--"
    ## [1] "mashr_Kidney_Cortex.db"
    ## [1] "--"
    ## [1] "mashr_Liver.db"
    ## [1] "--"
    ## [1] "mashr_Lung.db"
    ## [1] "--"
    ## [1] "mashr_Minor_Salivary_Gland.db"
    ## [1] "--"
    ## [1] "mashr_Muscle_Skeletal.db"
    ## [1] "--"
    ## [1] "mashr_Nerve_Tibial.db"
    ## [1] "--"
    ## [1] "mashr_Ovary.db"
    ## [1] "--"
    ## [1] "mashr_Pancreas.db"
    ## [1] "--"
    ## [1] "mashr_Pituitary.db"
    ## [1] "--"
    ## [1] "mashr_Prostate.db"
    ## [1] "--"
    ## [1] "mashr_Skin_Not_Sun_Exposed_Suprapubic.db"
    ## [1] "--"
    ## [1] "mashr_Skin_Sun_Exposed_Lower_leg.db"
    ## [1] "--"
    ## [1] "mashr_Small_Intestine_Terminal_Ileum.db"
    ## [1] "--"
    ## [1] "mashr_Spleen.db"
    ## [1] "--"
    ## [1] "mashr_Stomach.db"
    ## [1] "--"
    ## [1] "mashr_Testis.db"
    ## [1] "--"
    ## [1] "mashr_Thyroid.db"
    ## [1] "--"
    ## [1] "mashr_Uterus.db"
    ## [1] "--"
    ## [1] "mashr_Vagina.db"
    ## [1] "--"
    ## [1] "mashr_Whole_Blood.db"

``` r
df %>% count(rsid,varID) %>% arrange(desc( n))
```

    ##                      rsid                   varID  n
    ## 1               rs3859191  chr17_39972461_G_A_b38 17
    ## 2              rs28618095  chr17_39952822_T_C_b38 14
    ## 3               rs4794821  chr17_39967950_T_C_b38  5
    ## 4               rs4458030  chr17_39965453_G_A_b38  4
    ## 5               rs4065876  chr17_39973253_G_A_b38  3
    ## 6  chr17_39954836_G_C_b38  chr17_39954836_G_C_b38  2
    ## 7               rs3916061  chr17_39971460_A_G_b38  2
    ## 8              rs56326707  chr17_39973886_C_T_b38  2
    ## 9              rs59269632  chr17_39969978_A_G_b38  2
    ## 10             rs60667221  chr17_39954137_T_A_b38  2
    ## 11               rs921651  chr17_39977669_G_A_b38  2
    ## 12            rs113277605  chr17_40000142_C_T_b38  1
    ## 13              rs3859192  chr17_39972395_C_T_b38  1
    ## 14            rs397713502 chr17_39972331_A_AG_b38  1
    ## 15            rs398100509 chr17_39966991_AC_A_b38  1
    ## 16              rs4239225  chr17_39970859_G_A_b38  1
    ## 17             rs56946324  chr17_39951713_C_A_b38  1
    ## 18             rs60725845  chr17_39968377_T_G_b38  1
    ## 19              rs7214085  chr17_40012842_T_C_b38  1
    ## 20              rs7221814  chr17_39933464_A_G_b38  1
    ## 21             rs72832971  chr17_39952366_C_T_b38  1
    ## 22            rs796403983 chr17_39972785_AG_A_b38  1
    ## 23              rs8077456  chr17_39972512_G_C_b38  1

``` r
write_csv(df,"~/Downloads/GSDMA-weights.csv")
```

Also checkout how to query sqlite database [this
post](https://lab-notes.hakyimlab.org/post/2021/04/27/querying-predictdb-sqlite-databases/)
