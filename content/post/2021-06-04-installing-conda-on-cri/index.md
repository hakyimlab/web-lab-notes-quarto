---
title: Installing Conda on CRI
author: Natasha Santhnam
date: '2021-06-04'
slug: installing-conda-on-cri
categories:
  - installlation
tags: []
---

CRI has versions of miniconda already downloaded through the module commands. However, those sometimes do not work so it is best to just install conda for yourself on CRI. The whole process is quite simple and should only take a few minutes.

First download the conda installer from their [website](https://docs.conda.io/en/latest/miniconda.html) 

You can download using 
```
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

In your terminal run:

  bash Miniconda3-latest-Linux-x86_64.sh
  

Make sure to follow the prompts on the installer screens. At the end, it'll ask you where to install miniconda. If you have a software directory in your folder, you can tell miniconda to install there.
  /gpfs/data/im-lab/nas40t2/<name>/software/miniconda

Finally, you can test your installation by running the command 
  conda list

You can run the lab version of conda by typing 
  /gpfs/data/im-lab/nas40t2/lab_software/miniconda/bin/conda -h
