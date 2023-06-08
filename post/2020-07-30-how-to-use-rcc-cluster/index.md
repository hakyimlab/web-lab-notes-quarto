---
title: How to Use RCC Cluster
author: ''
date: '2020-07-30'
slug: how-to-use-rcc-cluster
categories:
  - how_to
tags: []
---

## Updated RCC documentation 
https://rcc-uchicago.github.io/user-guide/



## RCC account 
Please follow the instruction to request your RCC account: <a href= "https://rcc.uchicago.edu/getting-started/general-user-account-request"> General RCC User Account Request </a> 

```
PI Account Name: pi-haky
Rcc Software: R, RStudio, Python, Python
Rcc Research: My main research goal is to perform biomedical big data analysis and 
develop computation tools to address a wide range of important biomedical research questions.
```

## Login  
- Type `ssh YOUR_CNetID@midway.rcc.uchicago.edu`
- Type in your password when prompted 
- Type `yes` if you are prompted to accept a key 

Note: A shortcut to login your RCC account, please follow the instruction: <a href= "https://github.com/hakyimlab/internal/wiki/How-to-set-up-SSH-keys-and-configure-custom-connection-options-for-your-SSH-Client%3F"> How-to-set-up-SSH-keys-and-configure-custom-connection-options-for-your-SSH-Client </a>  

## Accessing your RCC account From a MAC
Please follow the instructions to access `/project/haky/` from the University of Chicago's Network:
 - Open `Finder`
 - Go to menu option `Go` -> Connect to Server
 - Type `smb://midwaysmb.rcc.uchicago.edu/project/haky` 
 - Make sure to prefix your username with ADLOCAL\ if from off-campus

## Storing your data
Storage Space: `/cds/haky` directory is used for long term data storage at a cheaper price. This storage space is not optimized for computation. 

Tarbell Lab Share-like Space: `/project/haky` directory is used to store lab data or persistent job outputs. Please create your own folder under the directory `/project/haky/im-lab/nas40t2`. Please perform regular maintenance by removing unneeded data. 

##### For more detail, please read <a href= "https://rcc.uchicago.edu/docs/"> RCC User Guide </a> 

## ThinLinc and RStudio access 
 - https://midway-login1.rcc.uchicago.edu/main/
 - https://rstudio.rcc.uchicago.edu/auth-sign-in 

## RCC contact 
Questions and issues should be sent to help@rcc.uchicago.edu or 773-795-2667.

