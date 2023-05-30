---
title: Installing tensorqtl module
author: Festus Nyasimi
date: '2020-11-11'
slug: installing-tensorqtl-module
categories:
  - installlation
tags:
  - how to
description: ''
topics: []
---

Installing tensorqtl requires pytorch which is based on gpus but there is also a cpu based version. 

CRI has set up pytorch for cpus as in a conda environment and that is what I am going to use to set up tensorqtl.

I will install the tensorqtl in im-lab share space for lab use. 

## Steps for installation
1. **Create a directory for the environment**

      ```bash
      mkdir -p /gpfs/data/im-lab/nas40t2/bin/envs
      cd /gpfs/data/im-lab/nas40t2/bin/envs
      ```

2. **Copy the pytorch environment into this new directory and name it tensorqtl**

    ```bash
    cp -r /apps/software/gcc-6.2.0/miniconda3/4.7.10/envs/pytorch-1.4.0-cpu_py37 tensorqtl
    ```

    Now we have the pytorch setup environment next we are going to set up tensorqtl

3. **Checking if requirements are available**

    Activate the conda environment

    ```bash
    conda activate /gpfs/data/im-lab/nas40t2/bin/envs/tensorqtl
    ```

    In this environment when you test the **pip** command its not executable because the     environment has python2. We need to upgrade the environment to use **python3**.

4. **Test the availability of pip and python3 using the following commands**

    ```bash
    python3 --version
    pip3 --version
    pip --version
    ```

    If you get error then you definitely need to set up these tools

5. **Set up python3**

    Install python3 which works with the set up pip

    ```bash
    conda install python==3.8.0
    ```

6. **Install tensorqtl**

    Tensorqtl is available from pip

    ```bash
    pip install tensorqtl
    ```

    Once installation is successful install the dependecies

7. **Install the _rpy2_ dependency**

    ```bash 
    conda install rpy2
    ```

8. **Test tensorqtl**

    ```bash
     python3 -m tensorqtl --help
    ```

9. **Clean up**

    Conda caches all these packages which consume a lot of disk space. The need to be removed;

    ```bash
     conda clean --all
    ```

**NB:** This environment is available for lab use. To activate the the environment for use just activate it

  ```bash
    conda activate /gpfs/data/im-lab/nas40t2/bin/envs/tensorqtl
  ```

**_Happy QTL mapping!!!_**
