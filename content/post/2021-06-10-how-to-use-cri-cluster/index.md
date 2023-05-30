---
title: How to use CRI cluster
author: ''
date: '2021-06-10'
slug: how-to-use-cri-cluster
categories:
  - how_to
  - cri
  - gardner
tags: []
---

## Login  
- Type `ssh username@gardner.cri.uchicago.edu`
- Type in your password when prompted 
- Type `yes` if you are prompted to accept a key 

Note: A shortcut to login your tarbell account, please follow the following instruction: <a href= "https://github.com/hakyimlab/internal/wiki/How-to-set-up-SSH-keys-and-configure-custom-connection-options-for-your-SSH-Client%3F"> How-to-set-up-SSH-keys-and-configure-custom-connection-options-for-your-SSH-Client </a>  

## Accessing lab-share resources 
Please follow the instructions to access `/gpfs/data/im-lab/` from the University of Chicago's Network:
 - Open `Finder`
 - Go to menu option `Go` -> Connect to Server
 - Type `smb://bulkstorage.uchicago.edu/im-lab` 
 - Enter your BSD username and password. Make sure to prefix your username with `ADLOCAL\` if from off-campus 

## Storing your data
Home directory/Quota: `/home/<userID>` (10G) - use for temporary personal files such scripts to execute analysis, source code, etc. Data stored here is not backed up. Move important data to lab share. 

Fast Scratch Space: Temporary storage. `/scratch/im-lab` directory on the HPC is used to stage input that is used in analysis jobs as well as temp files from job execution. Scratch data older than 14 days is automatically purged and outputs should be copied out to your lab share if you intend to keep job output.

Lab-Share: `/group/im-lab` Long term storage. Use to store lab data or persistent job outputs. Copy data you intend to keep out of scratch into this space. Do not run jobs out of here. It is not optimized for job execution. Please perform regular maintenance on the lab share by removing unneeded data. If you no longer needs access to the Lab Share, please fill <a href= " https://cri-app02.bsd.uchicago.edu/WebProvisioning/Service.aspx?category=1&type=2"> the revoke resource access form </a> </p>

The `/scratch` area is used like any other area on the filesystem. It differs by
lab shares in the following ways:

* Lab shares (`/group/im-lab`) are stored on an Isilon cluster and the data is backed up to tape
on a daily schedule.
* Lab shares have a cost associated if you provision a certain amount of space.
* Lab shares are more of a general purpose filesystem which is not tuned to
specifically handle HPC workflows.
* There is no quota on /scratch or cost associated with it.
* The data on /scratch is not backed up and should only be stored there on a
temporary basis.
* Scratch is tuned to handle large files, but will perform poorly if you have a
lot of small files.

How I would use scratch space is that I would stage large files there before
running my jobs through the scheduler and I would also set up a working
directory there while the job is executing.

Please contact storage@rt.cri.uchicago.edu to get your own scratch area in tarbell. 

## 

## Common module commands 
- `module avail`               
- `module list`              
- `module load python/2.7.9` (first load `module load gcc/7.3.0`)
- `module spider python` (to search all modules)
- `module clear` 

## Create job submission script 
- `emacs run_metaXcan.pbs` 
```
#!/bin/bash 
#################################
## Resource Manager Directives ##
#################################
### Set the name of the job
#PBS -N job_0_5_1
### Select the shell you would like to script to execute within.
#PBS -S /bin/bash
### walltime=HH:MM:SS
#PBS -l walltime=1:00:00
### Inform the scheduler of the number of CPU cores for your job.
#PBS -l nodes=1:ppn=1
### Inform the scheduler of the amount of memory you expect 
#PBS -l mem=4gb
### Set the destination for your program's output: stdout and stderr. 
#PBS -o logs_0_5/${PBS_JOBNAME}.o${PBS_JOBID}.log
#PBS -e logs_0_5/${PBS_JOBNAME}.e${PBS_JOBID}.err

###################
## Job Execution ##
###################
# The program to be executed 

./MetaXcan.py \
--beta_folder intermediate/beta \
--weight_db_path data/DGN-WB_0.5.db \
--covariance intermediate/cov/covariance.txt.gz \
--gwas_folder data/GWAS \
--gwas_file_pattern ".*gz" \
--compressed \
--beta_column BETA \
--pvalue_column P \
--output_file results/test.csv
```

## Submit jobs 
- `qsub run_metaXcan.pbs` 

## Monitor job status 
- `qstat`
- `showq` 

## Interrupt running jobs after submission 
- `qdel job_id`
- `qdel all` 

## Batch job submissions 
- Prepare batch job submission scripts as follows: 
   ``` 
   #!/bin/bash

    qsub run_metaXcan2.pbs

    sleep 2 

    qsub run_metaXcan2.pbs

    ... 
  ```
- Then run `sh submit_jobs.sh` 

## Running interactive jobs
-  To run an interactive shell, issue:     qsub -I

## Running R

To run R in cri you need to load the following
```
module load gcc/6.2.0  
module load R/4.0.3
```

##### For more detail, please read <a href= "http://cri.uchicago.edu/wp-content/uploads/2015/02/Tarbell-User-Guide.html"> A detailed user guide on how to use our new cluster </a> 


## CRI Support contact
<p> Should you have any problems, please submit <a href= "https://cri-app02.bsd.uchicago.edu/WebProvisioning/Support.aspx">  a support ticket </a> </p> 
<p> Or please contact our customer service line at (773) 834-8475 or at support@rt.cri.uchicago.edu. </p>
