---
title: Heritability Calculation
author: Natasha Santhanam
date: '2021-06-03'
slug: heritability-calculation
categories: []
tags: []
---
How to calculate Heritability using GCTA 

If you're data is already in a PLINK form then it's quite easy to use GCTA. You need to first create the genetic relatedness matrix (GRM) - make sure you've already done quality control on the genotype data since a high rate of missing SNPS will lead to negative eigenvalues in the GRM.

gcta --bfile ./plink_files --maf 0.01 --make-grm --out test --thread-num 10

The command above will produce the GRM genomewide. The genetic relationship matrix will be saved in the files test.grm.bin, test.grm.N.bin and test.grm.id in whatever directory you're standing in. For datasets with an extremely large number of SNPs and large sample size (e.g. 1000G imputed data) you can use the flag --chr to calculate the GRM for each autosome. If you want to remove an relatedness, you can also use the flag --grm-cutoff (make sure what your cutoff is and that its not too strict)

For REML analysis, you next use the command below. GCTA uses the first column in the phenotype file as the phenotype it's testing. If you want to use another column you can use the --mpheno flag. 

gcta6  --reml  --grm test  --pheno test_cc.phen  --out test_cc

Above is all for genomewide heritability. If you want to calculate cis-heritability, you need to make individual GRMs for each gene and only include the cis-snps. You would then run the above gcta command in a loop for each GRM. Here's an example:

  > `for(i in 1:length(genelist)){
  cat(i,"/",length(genelist),"\n")
  gene <- genelist[i]
  geneinfo <- gtf[match(gene, gtf$gene_id),]
  chr <- geneinfo[1]
  c <- chr$chr
  start <- geneinfo$start - 1e6 ### 1Mb lower bound for cis-eQTLS
  end <- geneinfo$end + 1e6 ### 1Mb upper bound for cis-eQTLs
  chrsnps <- subset(bim,bim[,1]==c) ### pull snps on same chr
  cissnps <- subset(chrsnps,chrsnps[,4]>=start & chrsnps[,4]<=end) ### pull cis-SNP info
  snplist <- cissnps[,2]    
  write.table(snplist, file= gt.dir %&% "tmp.cis.SNPlist",quote=F,col.names=F,row.names=F)
  runGCTAgrm <- "gcta --bfile " %&%  box.dir %&% "tmp --make-grm-bin --extract " %&% gt.dir %&% "tmp.cis.SNPlist" %&% " --out   " %&% grm.dir %&%  gene
  system(runGCTAgrm)
  }`



Another reminder to perform quality control on your genotype data before going forth in calculating heritability. For example, here is genotype data with a high rate of missing SNPS

0%        25%        50%        75%       100% 
___
0.07913669 0.09352518 0.10791367 0.12230216 0.71223022

Almost half of the samples contain only 10% of all snps. This genotype data would not be right to use for GCTA since the program will have issues calculating the GRM. It is better ot instead imput the genotype and then use that
