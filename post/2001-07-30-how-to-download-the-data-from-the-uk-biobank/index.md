---
title: How to Download the Data from the UK Biobank
author: ''
date: '2001-07-30'
categories:
  - how_to
tags: []
---


## Background


Application 19526 is the main application from which imlab downloads data. Other ID’s correspond to specific collaborations with other investigators at Uchicago and Argonne.


We have requested data in 8 baskets, with overlapping fields. The composition of the baskets are somewhat haphazard, they were put together as need arose. 
Basket 7947 was the first one with large number of fields, but incomplete.
MRI and IDP’s were requested in two baskets (), not completely overlapping.

Details of applications and baskets and field list are [here](https://docs.google.com/spreadsheets/d/1Ph6PsxLs22B3qYdkvBV7pbUai_GW6EhaI4TorAoyGUM/edit#gid=911891313)


##Requesting a Data Refresh


The button to refresh is not very easy to find, so here are the instructions from the [UK Biobank Accessing Data Guide](https://biobank.ndph.ox.ac.uk/showcase/exinfo.cgi?src=accessing_data_guide):

 > In order to gain access to updated data for fields in a previous data basket a researcher can request a “refresh” of that basket through AMS. A refresh of a dataset is a new
extraction of the fields in the basket, and will include any additional data added to
Showcase when it was updated. It will also remove the data for participants who have
withdrawn since the basket was last released.

 > In order to request a refresh of a basket, a researcher will need to login to the Access
Management System (AMS), navigate to their project (click Projects then View/Update),
then click on the Data tab, and then on the “Go to Showcase to refresh or download data”
button which will lead to the Downloads page. Next click ‘Application’ (at the top of the
page) and then select the basket to be refreshed. 

## Requesting New Data

To request additional data fields, login to the AMS, navigate to the project, then click on the Requests tab. Check "Do you wish to request additional data fields?". Then select fields from Quick Start tab, or Browse and Search buttons.

##Standard data (phenotype data)

* Downloading standard data file (**_ukb7948.enc_**) directly from <a href=http://biobank.ctsu.ox.ac.uk> the UK Biobank website </a> using the MD5 Checksum and password, which are included in the email. The email should also contain the key (**_k1952r7948.key_**) file, which will be used to decrypted the downloaded phenotypic data. 
* Downloading utilities (_**ukbmd5, ukbunpack, ukbconv and encoding.ukb.txt**_) directly from <a href=http://biobank.ctsu.ox.ac.uk/crystal/download.cgi> the UK Biobank website </a>. These data and utility files (from this step and last step) should be saved in the same file directory.
* Verifying the integrity of **_ukb7948.enc_**. The displayed MD5 Checksum of the dataset should be the same as the MD5 Checksum supplied via email. You may need to run chmod +x ukbmd5 beforehand, and repeat for the other utility files. This step created a decrypted file (_**ukb7948.enc.ukb**_)
```
./ukbmd5 ukb7948.enc 
```

* Decrypting _**ukb7948.enc**_ 
```
./ukbunpack ukb7948.enc k1952r7948.key.txt
```

* Converting the decrypted data (**_ukb7948.enc_ukb_**) into various useful formats. 
```
./ukbconv ukb7948.enc_ukb bulk 
./ukbconv ukb7948.enc_ukb docs 
./ukbconv ukb7948.enc_ukb r 
./ukbconv ukb7948.enc_ukb csv 
```
   **csv format**: simple comma-separated-variable output, all fields double-quoted.<br><br>
   **r format**: produces a tab deliminated file and an R script for labeling and putting levels on the variables.<br><br>
   **docs format**: rather than output the data itself, this option generates an html file describing the data, listing the names and types of each field. You can access html file <a href=http://ukbiobank.hakyimlab.org> here </a>. <br><br>
   **bulk format**: a list of IDs for use with the ukbfetch utility (we will not use this file, instead we will download genotype data using gfech utility). 

##Complex data (genetic data)

* Creating the authentication file as .ukbkey 
The authentication file should be named "**_.ukbkey_**" and contain two lines of text, the first containing the Application ID (1952) and the second the truncated password (the first 24 characters). The authentication file should be stored in the home directory of your rcc account. 

```
1952
a1b2c3d4a1b2c3d4a1b2c3d4
```
```
cp .ukbkey ~/ 
```

* Downloading utilities (_**gfetch, genotype_map.csv and gconv**_) directly from <a href=http://biobank.ctsu.ox.ac.uk/crystal/download.cgi> the UK Biobank website </a>. These files should be saved in the same file directory. 

* Downloading genetic data. Datatype is one of "_**cal**_" (calls), "**_imp_**" (imputed data), "**_con_**" (confidences) or "__**int**__" (intensities). It is possible to run more than one _**gfetch**_ download in parallel, however I strongly recommend that you just download only one dataset at a time to avoid overload on either the server side or your limited rcc _**cds**_ provision. Please beware that imputed chromosome X, Y, mitochondria datasets are currently not available. If a download is interrupted, then please delete the incomplete file and restart. 

```
seq 1 22 | parallel -j1 ./gfetch cal {}
./gfetch cal X 
./gfetch cal Y
./gfetch cal MT 

seq 1 22 | parallel -j1 ./gfetch imp {}

seq 1 22 | parallel -j1 ./gfetch con {}
./gfetch con X 
./gfetch con Y
./gfetch con MT 

seq 1 22 | parallel -j1 ./gfetch int {}
./gfetch int X 
./gfetch int Y
./gfetch int MT
```

 * A single sample map (impv1.sample) for the imputed data also was downloaded
```
    ./gfetch imp 1 -m
```

##Complex data (episode-level hospital data)

This data is held within multiple standard relational databases. <br><br>
1. General structure of the hospital data<br>
The HES data has been divided into 5 tables. The master table is `hesin`, which connects to 4 subsidiary tables (`hesin_diag10`, `hesin_diag9`, `hesin_oper`, `hesin_birth`) via the record_id key field.<br><br>
2. Record data can be manipulated and extracted directly using SQL via <a href=http://biobank.ctsu.ox.ac.uk> the UK Biobank website </a>. <br><br>
More detailed information please see <a href="http://biobank.ctsu.ox.ac.uk/showcase/exinfo.cgi?src=AccessingEpisodeData" target="_blank"> How to access episode-level hospital data </a> <br><br>

##Data 

1. Data is in bionimbus. See instructions on how to access [here](https://github.com/hakyimlab/ANL-ukbREST-queries/tree/master/ukbREST_setup) 

```
aws s3 ls --endpoint-url https://bionimbus-objstore.opensciencedatacloud.org \
 --recursive s3://uk-biobank.hakyimlab.org/data/phenotype
```

2. Now also in CRI
`/gpfs/data/ukb-share/genotypes` and `/gpfs/data/im-lab/nas40t2/Data/UKB`

##References

* <a href="http://biobank.ctsu.ox.ac.uk/crystal/exinfo.cgi" target="_blank"> Essential information </a>
* <a href="http://biobank.ctsu.ox.ac.uk/showcase/exinfo.cgi?src=AccessingData" target="_blank"> Accessing your data </a>
* <a href="http://biobank.ctsu.ox.ac.uk/showcase/exinfo.cgi?src=accessing_data_guide" target="_blank"> Using UK Biobank Data </a>
* <a href="http://biobank.ctsu.ox.ac.uk/showcase/exinfo.cgi?src=AccessingBulkRecordData" target="_blank"> How to access bulk data </a>
* <a href="http://biobank.ctsu.ox.ac.uk/showcase/exinfo.cgi?src=AccessingEpisodeData" target="_blank"> How to access episode-level hospital data </a>
* <a href="http://biobank.ctsu.ox.ac.uk/showcase/docs/HospitalEpisodeStatistics.pdf" target="_blank"> Hospital Episode Statistics data in Showcase  </a>
* <a href="http://biobank.ctsu.ox.ac.uk/crystal/exinfo.cgi?src=AccessingGeneticData" target="_blank"> How to access genetic data? </a>
* <a href="http://www.ukbiobank.ac.uk/wp-content/uploads/2014/04/imputation_documentation_May2015.pdf" target="_blank"> A document outlining the methods used to create the imputed dataset</a>