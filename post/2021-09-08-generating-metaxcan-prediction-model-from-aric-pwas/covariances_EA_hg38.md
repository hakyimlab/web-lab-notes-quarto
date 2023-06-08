---
title: Covariances EA hg38
author: Sabrina Mi
date: '2021-09-08'
---


::: {.container-fluid .main-container}
::: {#header .fluid-row}
# covariances_hg38 {#covariances_hg38 .title .toc-ignore}

#### 2021-06-04 {#section .date}
:::

[]{.glyphicon .glyphicon-list aria-hidden="true"} workflowr
[]{.glyphicon .glyphicon-exclamation-sign .text-danger
aria-hidden="true"}

::: {#workflowr-report .collapse}
-   [Summary](#summary){toggle="tab"}
-   [Checks []{.glyphicon .glyphicon-exclamation-sign .text-danger
    aria-hidden="true"}](#checks){toggle="tab"}
-   [Past versions](#versions){toggle="tab"}

::: tab-content
::: {#summary .tab-pane .fade .in .active}
**Last updated:** 2021-09-08

**Checks:** []{.glyphicon .glyphicon-ok .text-success
aria-hidden="true"} 6 []{.glyphicon .glyphicon-exclamation-sign
.text-danger aria-hidden="true"} 1

**Knit directory:** `~/Github/ARIC/` [ ]{.glyphicon
.glyphicon-question-sign aria-hidden="true"
title="This is the local directory in which the code in this file was executed."}

This reproducible [R Markdown](http://rmarkdown.rstudio.com) analysis
was created with [workflowr](https://github.com/jdblischak/workflowr)
(version 1.6.2). The *Checks* tab describes the reproducibility checks
that were applied when the results were created. The *Past versions* tab
lists the development history.

------------------------------------------------------------------------
:::

::: {#checks .tab-pane .fade}
::: {#workflowr-checks .panel-group}
::: {.panel .panel-default}
::: panel-heading
[[]{.glyphicon .glyphicon-exclamation-sign .text-danger
aria-hidden="true"} **R Markdown file:** uncommitted
changes](#strongRMarkdownfilestronguncommittedchanges){toggle="collapse"
parent="#workflowr-checks"}
:::

::: {#strongRMarkdownfilestronguncommittedchanges .panel-collapse .collapse}
::: panel-body
The R Markdown is untracked by Git. To know which version of the R
Markdown file created these results, you'll want to first commit it to
the Git repo. If you're still working on the analysis, you can ignore
this warning. When you're finished, you can run `wflow_publish` to
commit the R Markdown file and build the HTML.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[[]{.glyphicon .glyphicon-ok .text-success aria-hidden="true"}
**Environment:** empty](#strongEnvironmentstrongempty){toggle="collapse"
parent="#workflowr-checks"}
:::

::: {#strongEnvironmentstrongempty .panel-collapse .collapse}
::: panel-body
Great job! The global environment was empty. Objects defined in the
global environment can affect the analysis in your R Markdown file in
unknown ways. For reproduciblity it's best to always run the code in an
empty environment.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[[]{.glyphicon .glyphicon-ok .text-success aria-hidden="true"} **Seed:**
`set.seed(12345)`](#strongSeedstrongcodesetseed12345code){toggle="collapse"
parent="#workflowr-checks"}
:::

::: {#strongSeedstrongcodesetseed12345code .panel-collapse .collapse}
::: panel-body
The command `set.seed(12345)` was run prior to running the code in the R
Markdown file. Setting a seed ensures that any results that rely on
randomness, e.g. subsampling or permutations, are reproducible.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[[]{.glyphicon .glyphicon-ok .text-success aria-hidden="true"} **Session
information:**
recorded](#strongSessioninformationstrongrecorded){toggle="collapse"
parent="#workflowr-checks"}
:::

::: {#strongSessioninformationstrongrecorded .panel-collapse .collapse}
::: panel-body
Great job! Recording the operating system, R version, and package
versions is critical for reproducibility.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[[]{.glyphicon .glyphicon-ok .text-success aria-hidden="true"}
**Cache:** none](#strongCachestrongnone){toggle="collapse"
parent="#workflowr-checks"}
:::

::: {#strongCachestrongnone .panel-collapse .collapse}
::: panel-body
Nice! There were no cached chunks for this analysis, so you can be
confident that you successfully produced the results during this run.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[[]{.glyphicon .glyphicon-ok .text-success aria-hidden="true"} **File
paths:** relative](#strongFilepathsstrongrelative){toggle="collapse"
parent="#workflowr-checks"}
:::

::: {#strongFilepathsstrongrelative .panel-collapse .collapse}
::: panel-body
Great job! Using relative paths to the files within your workflowr
project makes it easier to run your code on other machines.
:::
:::
:::

::: {.panel .panel-default}
::: panel-heading
[[]{.glyphicon .glyphicon-ok .text-success aria-hidden="true"}
**Repository version:** No commits
yet](#strongRepositoryversionstrongNocommitsyet){toggle="collapse"
parent="#workflowr-checks"}
:::

::: {#strongRepositoryversionstrongNocommitsyet .panel-collapse .collapse}
::: panel-body
Great! You are using Git for version control. Tracking code development
and connecting the code version to the results is critical for
reproducibility.

Note that you need to be careful to ensure that all relevant files for
the analysis have been committed to Git prior to generating the results
(you can use `wflow_publish` or `wflow_git_commit`). workflowr only
checks the R Markdown file, but you know if there are other scripts or
data files that it depends on. Below is the status of the Git repository
when the results were generated:

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
        Untracked:  figure/
        Untracked:  models/
        Untracked:  results/
        Untracked:  test_data/
        Untracked:  weights_EA.Rmd
        Untracked:  weights_EA.html

Note that any generated files, e.g. HTML, png, CSS, etc., are not
included in this status report because it is ok for generated content to
have uncommitted changes.
:::
:::
:::
:::

------------------------------------------------------------------------
:::

::: {#versions .tab-pane .fade}
There are no past versions. Publish this analysis with `wflow_publish()`
to start tracking its development.

------------------------------------------------------------------------
:::
:::
:::

::: {#download-data .section .level1}
# Download Data

`covariance_for_model.py` takes genotypes in parquet format. Run
`git clone https://github.com/hakyimlab/summary-gwas-imputation.git`.
The data can be downloaded:
<https://zenodo.org/record/3569954#.XyRiqChKiUk>. Or in CRI:
`/gpfs/data/im-lab/nas40t2/Data/1000G_hg38_EUR_maf0.01_parquet`
:::

::: {#calculating-covariance .section .level1}
# Calculating Covariance

``` bash
CODE=/Users/t.med.scmi/Github/summary-gwas-imputation
DATA=/gpfs/data/im-lab/nas40t2/Data/1000G_hg38_EUR_maf0.01_parquet
MODEL=/gpfs/data/im-lab/nas40t2/sabrina/ARIC
```

`parquet_genotype_pattern` helps identify genotype files by chromosome.
`ARIC_EA_hg38.db` is a PrediXcan format prediction model defined in
hg38. The script can also be submitted as a job in CRI:
`/gpfs/data/im-lab/nas40t2/sabrina/ARIC/covariances_1000G_hg38.sh`

``` bash
python $CODE/covariance_for_model.py \
-parquet_genotype_folder $DATA \
-parquet_genotype_pattern "chr(.*).variants.parquet" \
-model_db $MODEL/ARIC_EA_hg38.db \
-output $MODEL/ARIC_EA_hg38.txt.gz \
-parsimony 1
```

\

[]{.glyphicon .glyphicon-wrench aria-hidden="true"} Session information

::: {#workflowr-sessioninfo .collapse}
``` r
sessionInfo()
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

    loaded via a namespace (and not attached):
     [1] Rcpp_1.0.5       rstudioapi_0.11  knitr_1.30       magrittr_1.5    
     [5] workflowr_1.6.2  R6_2.4.1         rlang_0.4.8      stringr_1.4.0   
     [9] tools_4.0.3      xfun_0.18        git2r_0.27.1     htmltools_0.5.0 
    [13] ellipsis_0.3.1   yaml_2.2.1       digest_0.6.27    rprojroot_1.3-2 
    [17] tibble_3.0.4     lifecycle_0.2.0  crayon_1.3.4     later_1.1.0.1   
    [21] vctrs_0.3.4      promises_1.1.1   fs_1.5.0         glue_1.4.2      
    [25] evaluate_0.14    rmarkdown_2.5    stringi_1.5.3    compiler_4.0.3  
    [29] pillar_1.4.6     backports_1.1.10 httpuv_1.5.4     pkgconfig_2.0.3 
:::
:::
:::
