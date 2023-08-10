#! /usr/bin/env Rscript

library(tidyverse)
library(data.table)
library(arrow)
library(BEDMatrix)
library(optparse)
set.seed(2023)

option_list <- list(
  make_option(c("--nsim"), type="character", default=1000,
              help="The chromosome you are processing",
              metavar="numeric"),
  make_option(c("--predicted_traits"), type="character", default=NULL,
              help="The predicted molecular trait",
              metavar="character"),
  make_option(c("--plink_genotype"), type="character", default=NULL,
              help="The prefix for the genotype used in prediction in plink format",
              metavar="character"),
  make_option(c("--output_file"), type="character", default=NULL,
              help="The output file with average chi2",
              metavar="character"))

opt_parser <- OptionParser(option_list=option_list)
args <- parse_args(opt_parser)

nsim <- as.numeric(args$nsim)
predicted_traits <- args$predicted_traits
plink_file_path <- args$plink_genotype
output_file <- args$output_file


#####
# cor to chi2
## calculate p-value from correlation
cor2zscore = function(cc,nn) 
{
  zz = atanh(cc) * sqrt(nn-3)
}

cor2pval = function(cc,nn) 
{
  zz=cor2zscore(cc,nn)
  pnorm(-abs(zz))*2
}

cor2chi2 = function(cc,n)
{
  cor2zscore(cc,n)^2
}


# UNDER INVESTIGATION
#cor2chi2 <- function(r,n) {
#  # r: correlation coefficient
#  # n: sample size
#  chi2 <- (n - 2) * r^2 / (1 - r^2)
#  return(chi2)
#}

# simulate the y
gen_y_h2 <- function(nsim,X,h2Y) {
  
  nsamp = nrow(X)
  msnp = ncol(X)

  betamat = matrix(rnorm(msnp*nsim),msnp, nsim)
  epsimat = matrix(rnorm(nsamp*nsim),nsamp, nsim)
  epsimat = scale(epsimat) * sqrt(1 - h2Y)
  gYmat = X %*% betamat
  gYmat = scale(gYmat) * sqrt(h2Y)
  Ymat = gYmat + epsimat

  return(Ymat)
}


# function to calculate chi2
gen_null_chi2_fast <- function(X, expr_mat, h2_Y, nsim = 1000) {
  Ymat_null = gen_y_h2(nsim,X,h2_Y)
  nsamp = nrow(expr_mat)
  calculate_chi(expr_mat, Ymat_null,nsamp)
}
  
calculate_chi <- function(expr_mat, Y_mat,nsamp) {
  # scale both X and Y
  X_scale = expr_mat %>% scale()
  Y_mat_h2 = scale(Y_mat)
  
  # transpose and multiply
  cor_mat = (t(X_scale) %*% Y_mat_h2)/nsamp
  
  # calculate the chi2
  chimat = apply(cor_mat, 2, cor2chi2, n = nsamp)
  # get the mean chi for each row
  mean_chi = apply(chimat, 1, mean)
  
  mean_chi <- data.frame(chi = mean_chi) %>% 
    rownames_to_column(var = "trait")
  
  return(mean_chi)
}


#######
if(grepl("\\.parquet$", predicted_traits)) {
  pred_traits <- read_parquet(predicted_traits)
} else {
  pred_traits <- fread(predicted_traits)
}


if ("indiv" %in% names(pred_traits)) {
  pred_traits <- pred_traits %>%
    column_to_rownames(var = "indiv") %>%
    as.matrix()
} else {
  pred_traits <- pred_traits %>% select(-FID) %>% 
    column_to_rownames(var = "IID") %>%
    as.matrix()
}


# sim the null pheno
X <- BEDMatrix(plink_file_path)
X <- X %>% as.matrix()
colnames(X) <- gsub("\\_.*", "",colnames(X))
# fill missing genotype
sum(is.na(X))

#######
traits_nulls <- data.frame(trait = colnames(pred_traits))

h2_ranges <- seq(0,1,0.05)

for (h in h2_ranges) {
  # handle extremes
  if (h == 0) h=0.01; if (h == 1) h=0.99
  h_out <- glue::glue("h2_{h}")
  tmp_null <- gen_null_chi2_fast(X,pred_traits,h,nsim)
  
  traits_nulls <- traits_nulls %>% 
    left_join(tmp_null, by = "trait") %>% 
    rename(!! h_out := chi)
  
}

fwrite(traits_nulls, 
       file = output_file,
       sep = "\t")


