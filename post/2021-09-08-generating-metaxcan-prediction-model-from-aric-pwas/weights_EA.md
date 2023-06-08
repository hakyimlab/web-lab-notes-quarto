---
title: Weights EA
author: Sabrina Mi
date: '2021-09-08'
---

::: {.container-fluid .main-container}
::: {#header .fluid-row}
# generate weights {#generate-weights .title .toc-ignore}

#### sabrina-mi {#sabrina-mi .author}

#### 2020-06-22 {#section .date}
:::

workflowr

::: {#workflowr-report .collapse}
-   [Summary](#summary){toggle="tab"}
-   [Checks ](#checks){toggle="tab"}
-   [Past versions](#versions){toggle="tab"}

::: tab-content
::: {#summary .tab-pane .fade .in .active}
**Last updated:** 2021-09-08

**Checks:** 5 2

**Knit directory:** `~/Github/ARIC/`

This reproducible [R Markdown](http://rmarkdown.rstudio.com) analysis was created with [workflowr](https://github.com/jdblischak/workflowr) (version 1.6.2). The *Checks* tab describes the reproducibility checks that were applied when the results were created. The *Past versions* tab lists the development history.

------------------------------------------------------------------------
:::

::: {#checks .tab-pane .fade}
::: {#workflowr-checks .panel-group}
::: {.panel .panel-default}
::: panel-heading
[ **R Markdown file:** uncommitted changes](#strongRMarkdownfilestronguncommittedchanges){toggle="collapse" parent="#workflowr-checks"}
:::

::: {#strongRMarkdownfilestronguncommittedchanges .panel-collapse .collapse}
::: panel-body
The R Markdown is untracked by Git. To know which version of the R Markdown file created these results, you'll want to first commit it to the Git repo. If you're still working on the analysis, you can ignore this warning. When you're finished, you can run `wflow_publish` to commit the R Markdown file and build the HTML.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[ **Environment:** empty](#strongEnvironmentstrongempty){toggle="collapse" parent="#workflowr-checks"}
:::

::: {#strongEnvironmentstrongempty .panel-collapse .collapse}
::: panel-body
Great job! The global environment was empty. Objects defined in the global environment can affect the analysis in your R Markdown file in unknown ways. For reproduciblity it's best to always run the code in an empty environment.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[ **Seed:** `set.seed(12345)`](#strongSeedstrongcodesetseed12345code){toggle="collapse" parent="#workflowr-checks"}
:::

::: {#strongSeedstrongcodesetseed12345code .panel-collapse .collapse}
::: panel-body
The command `set.seed(12345)` was run prior to running the code in the R Markdown file. Setting a seed ensures that any results that rely on randomness, e.g. subsampling or permutations, are reproducible.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[ **Session information:** recorded](#strongSessioninformationstrongrecorded){toggle="collapse" parent="#workflowr-checks"}
:::

::: {#strongSessioninformationstrongrecorded .panel-collapse .collapse}
::: panel-body
Great job! Recording the operating system, R version, and package versions is critical for reproducibility.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[ **Cache:** none](#strongCachestrongnone){toggle="collapse" parent="#workflowr-checks"}
:::

::: {#strongCachestrongnone .panel-collapse .collapse}
::: panel-body
Nice! There were no cached chunks for this analysis, so you can be confident that you successfully produced the results during this run.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[ **File paths:** absolute](#strongFilepathsstrongabsolute){toggle="collapse" parent="#workflowr-checks"}
:::

::: {#strongFilepathsstrongabsolute .panel-collapse .collapse}
::: panel-body
Using absolute paths to the files within your workflowr project makes it difficult for you and others to run your code on a different machine. Change the absolute path(s) below to the suggested relative path(s) to make your code more reproducible.

| absolute                                                             | relative                                |
|:---------------------------------------------------------------------|:----------------------------------------|
| /Users/sabrinami/Github/ARIC/PWAS/PWAS_EA/Plasma_Protein_EA_hg38.pos | PWAS/PWAS_EA/Plasma_Protein_EA_hg38.pos |
| /Users/sabrinami/Github/ARIC/PWAS/PWAS_EA/Plasma_Protein_weights_EA  | PWAS/PWAS_EA/Plasma_Protein_weights_EA  |
| /Users/sabrinami/Github/ARIC/models/ARIC_EA_hg38.db                  | models/ARIC_EA_hg38.db                  |
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[ **Repository version:** No commits yet](#strongRepositoryversionstrongNocommitsyet){toggle="collapse" parent="#workflowr-checks"}
:::

::: {#strongRepositoryversionstrongNocommitsyet .panel-collapse .collapse}
::: panel-body
Great! You are using Git for version control. Tracking code development and connecting the code version to the results is critical for reproducibility.

Note that you need to be careful to ensure that all relevant files for the analysis have been committed to Git prior to generating the results (you can use `wflow_publish` or `wflow_git_commit`). workflowr only checks the R Markdown file, but you know if there are other scripts or data files that it depends on. Below is the status of the Git repository when the results were generated:

```         
Untracked files:
    Untracked:  .DS_Store
    Untracked:  .Rhistory
    Untracked:  ARIC_EA_hg38_validation.Rmd
    Untracked:  ARIC_EA_hg38_validation.html
    Untracked:  ARIC_EA_hg38_validation_height.Rmd
    Untracked:  ARIC_EA_hg38_validation_height.html
    Untracked:  PWAS/
    Untracked:  code/
    Untracked:  covariances_EA_hg38.Rmd
    Untracked:  covariances_EA_hg38.html
    Untracked:  figure/
    Untracked:  models/
    Untracked:  results/
    Untracked:  test_data/
    Untracked:  weights_EA.Rmd
    Untracked:  weights_EA.html
```

Note that any generated files, e.g. HTML, png, CSS, etc., are not included in this status report because it is ok for generated content to have uncommitted changes.
:::
:::
:::
:::

------------------------------------------------------------------------
:::

::: {#versions .tab-pane .fade}
There are no past versions. Publish this analysis with `wflow_publish()` to start tracking its development.

------------------------------------------------------------------------
:::
:::
:::

::: {#pwas-schema .section .level1}
# PWAS Schema

`Plasma_Protein_EA_hg38.pos` is a text file with proteins (ID) and locations on their encoding genes, (CHR, P0, P1), as well as pointers to their weights files (WGT).

The weights file for each protein is in `Plasma_Protein_weights_EA`, in TWAS/Fusion format. When loaded, each .RDat file contains snps (snp info), wgt.matrix (weights), and cv.performance (cross validation) data. The columns of the snps table are chromosome (V1), rsid (V2), position (V4), effect allele (V5) and reference allele (V6). In the wgt.matrix table, the rownames are the rsids, and the columns are the weights derived from elastic net and top1 methods for each snp.
:::

::: {#load-libraries .section .level1}
# Load Libraries

Run in R:

``` r
suppressPackageStartupMessages(library(RSQLite))
suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(data.table))
suppressPackageStartupMessages(library(biomaRt))
```
:::

::: {#initialize-extra-table .section .level1}
# Initialize Extra Table

The file `Plasma_Protein_EA_hg38.pos` points to the TWAS/FUSION files that contains the weights for each gene. We create a dictionary file that joins gene name, TWAS/FUSION file name, and Ensembl ID.

``` r
ensembl = useEnsembl(biomart = "genes", dataset = "hsapiens_gene_ensembl")
gene_annot = getBM( attributes=
                    c("ensembl_gene_id",
                      "hgnc_symbol"),
                  values =TRUE,
                  mart = ensembl)
gene_annot = gene_annot[!duplicated(gene_annot$hgnc_symbol),]
gene_list = read.table("/Users/sabrinami/Github/ARIC/PWAS/PWAS_EA/Plasma_Protein_EA_hg38.pos", head=TRUE)
gene_list = gene_list[2:6]
```

Some of the genes in the PWAS do not have an Ensembl ID annotation, so we use HGNC symbol in its place.

``` r
extra = left_join(gene_list, gene_annot, by=c("ID"="hgnc_symbol"))
extra = extra %>% mutate(ensembl_gene_id = coalesce(ensembl_gene_id,ID))
```

Then add columns to match PrediXcan format.

``` r
extra$pred.perf.R2 <- NA
extra$pred.perf.pval <- NA
extra$pred.perf.qval <- NA
```
:::

::: {#convert-file-to-dataframe .section .level1}
# Convert File to Dataframe

make_df will load a file and store its data as a dataframe. This is only for a single gene, so later will be repeated for all genes. The input is the name of the .RDat file, and it returns returns dataframe with gene, position, chromosome, ref allele, eff allele, and non-zero enet weights.

``` r
make_df <- function(file) {
  if (file %in% extra$WGT) {
    load(file)  
    weights <- data.frame(wgt.matrix) 
    snps <- data.frame(snps) 
    
    index = which(extra$WGT == file)
    
    weights$gene <- extra$ensembl_gene_id[index]
    weights$rsid <- rownames(weights)
    weights$varID <- paste("chr",paste(snps$V1,snps$V4,snps$V6,snps$V5,"b38", sep="_"), sep="")
    weights$ref_allele <- snps$V6
    weights$eff_allele <- snps$V5
    weights = filter(weights, enet != 0)[,c(3,4,5,6,7,1)]
    rownames(weights) <- c()
    weights = rename(weights, c("weight"="enet"))
    
    rsq = cv.performance[1,1]
    pval = cv.performance[2,1]
    extra$pred.perf.R2[index] = rsq
    extra$pred.perf.pval[index] = pval
    assign('extra',extra,envir=.GlobalEnv)
    return(weights)
  }
}
```
:::

::: {#make-weights-table .section .level1}
# Make Weights Table

First, combine .RDat file names in a vector. Then convert each of them to a dataframe in PrediXcan format, appending them in a weights table.

``` r
setwd("/Users/sabrinami/Github/ARIC/PWAS/PWAS_EA/Plasma_Protein_weights_EA")
files <- list.files(pattern = "\\.RDat")

weights = data.frame()
for(i in 1:length(files)) {
  weights <- rbind(weights, make_df(files[i]))
}
```
:::

::: {#make-extra-table .section .level1}
# Make Extra Table

Generate number of snps for each gene from the weights table.

``` r
extra = rename(extra, c("genename"="ID", "gene"="ensembl_gene_id"))
n.snps = weights %>% group_by(gene) %>% summarise(n.snps.in.model = n())
```

```         
`summarise()` ungrouping output (override with `.groups` argument)
```

``` r
extra = inner_join(extra, n.snps)
```

```         
Joining, by = "gene"
```

``` r
extra <- extra[,c(6,2,10,7,8,9)]
```
:::

::: {#write-to-sqlite-database .section .level1}
# Write to SQLite Database

Create database connection, and write the weights and extra tables to database.

``` r
model_db = "/Users/sabrinami/Github/ARIC/models/ARIC_EA_hg38.db"
conn <- dbConnect(RSQLite::SQLite(), model_db)
dbWriteTable(conn, "weights", weights, overwrite=TRUE)
dbWriteTable(conn, "extra", extra, overwrite=TRUE)
```

To double check, confirm there is a weights and extra table, and show their contents.

``` r
dbListTables(conn)
```

```         
[1] "extra"   "weights"
```

``` r
dbGetQuery(conn, 'SELECT * FROM weights') %>% head
```

```         
             gene        rsid                  varID ref_allele eff_allele
1 ENSG00000254521 rs528743654 chr19_51442871_G_A_b38          G          A
2 ENSG00000254521 rs150832888 chr19_51472073_G_A_b38          G          A
3 ENSG00000254521   rs3752135 chr19_51497370_T_G_b38          T          G
4 ENSG00000254521   rs3826667 chr19_51500820_C_T_b38          C          T
5 ENSG00000254521   rs3810109 chr19_51501297_C_T_b38          C          T
6 ENSG00000254521   rs3810114 chr19_51503097_T_C_b38          T          C
        weight
1  0.002895501
2  0.010318968
3 -0.126489008
4 -0.130910477
5 -0.039422600
6 -0.022390375
```

``` r
dbGetQuery(conn, 'SELECT * FROM extra') %>% head
```

```         
             gene genename n.snps.in.model pred.perf.R2 pred.perf.pval
1 ENSG00000254521 SIGLEC12              14  0.315496028   0.000000e+00
2 ENSG00000197943    PLCG2              68  0.051123646   1.694797e-84
3 ENSG00000230124    ACBD6              11  0.007350099   1.816883e-13
4 ENSG00000198931     APRT              51  0.013318563   4.921077e-23
5 ENSG00000111674     ENO2              11  0.012191463   3.150181e-21
6 ENSG00000168610    STAT3              32  0.085432419  2.835291e-142
  pred.perf.qval
1             NA
2             NA
3             NA
4             NA
5             NA
6             NA
```

Lastly, disconnect from database connection

``` r
dbDisconnect(conn)
```

\

Session information

::: {#workflowr-sessioninfo .collapse}
``` r
sessionInfo()
```

```         
R version 4.0.3 (2020-10-10)
Platform: x86_64-apple-darwin17.0 (64-bit)
Running under: macOS Big Sur 10.16

Matrix products: default
BLAS:   /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRblas.dylib
LAPACK: /Library/Frameworks/R.framework/Versions/4.0/Resources/lib/libRlapack.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] biomaRt_2.44.4    data.table_1.13.2 forcats_0.5.0     stringr_1.4.0    
 [5] dplyr_1.0.2       purrr_0.3.4       readr_1.4.0       tidyr_1.1.2      
 [9] tibble_3.0.4      ggplot2_3.3.2     tidyverse_1.3.0   RSQLite_2.2.1    

loaded via a namespace (and not attached):
 [1] Biobase_2.48.0       httr_1.4.2           bit64_4.0.5         
 [4] jsonlite_1.7.1       modelr_0.1.8         assertthat_0.2.1    
 [7] askpass_1.1          BiocFileCache_1.12.1 highr_0.8           
[10] stats4_4.0.3         blob_1.2.1           cellranger_1.1.0    
[13] yaml_2.2.1           progress_1.2.2       pillar_1.4.6        
[16] backports_1.1.10     glue_1.4.2           digest_0.6.27       
[19] promises_1.1.1       rvest_0.3.6          colorspace_1.4-1    
[22] htmltools_0.5.0      httpuv_1.5.4         XML_3.99-0.5        
[25] pkgconfig_2.0.3      broom_0.7.2          haven_2.3.1         
[28] scales_1.1.1         later_1.1.0.1        git2r_0.27.1        
[31] openssl_1.4.3        generics_0.0.2       IRanges_2.22.2      
[34] ellipsis_0.3.1       withr_2.3.0          BiocGenerics_0.34.0 
[37] cli_2.1.0            magrittr_1.5         crayon_1.3.4        
[40] readxl_1.3.1         memoise_1.1.0        evaluate_0.14       
[43] fs_1.5.0             fansi_0.4.1          xml2_1.3.2          
[46] tools_4.0.3          prettyunits_1.1.1    hms_0.5.3           
[49] lifecycle_0.2.0      S4Vectors_0.26.1     munsell_0.5.0       
[52] reprex_0.3.0         AnnotationDbi_1.50.3 compiler_4.0.3      
[55] rlang_0.4.8          grid_4.0.3           rstudioapi_0.11     
[58] rappdirs_0.3.1       rmarkdown_2.5        gtable_0.3.0        
[61] curl_4.3             DBI_1.1.0            R6_2.4.1            
[64] lubridate_1.7.9      knitr_1.30           bit_4.0.4           
[67] workflowr_1.6.2      rprojroot_1.3-2      stringi_1.5.3       
[70] parallel_4.0.3       Rcpp_1.0.5           vctrs_0.3.4         
[73] dbplyr_1.4.4         tidyselect_1.1.0     xfun_0.18           
```
:::
:::
:::
