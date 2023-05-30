library(tidyverse)
library(biomaRt)

# connect to BioMart database, choosing gene annotations for rats
ensembl = useMart(biomart="ENSEMBL_MART_ENSEMBL", dataset = "rnorvegicus_gene_ensembl")

# returns the type of information we can query from the dataset
listAttributes(mart=ensembl)$name %>% unique

# query all relevant data and store in a dataframe
orth.rat = getBM( attributes=
                    c("ensembl_gene_id", 
                      "hsapiens_homolog_ensembl_gene",
                      "external_gene_name"),
                  filters = "with_hsapiens_homolog",
                  values =TRUE,
                  mart = ensembl,
                  bmHeader=FALSE)

# write to file
write.table(orth.rat, file="ortholog_genes_rats_humans.tsv", sep=\t, header=TRUE, quote=FALSE)
