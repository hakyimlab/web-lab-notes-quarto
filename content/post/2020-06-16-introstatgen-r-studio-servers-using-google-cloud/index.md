---
title: IntroStatGen R Studio Servers using Google Cloud
author: Owen Melia
date: '2020-06-16'
slug: introstatgen-r-studio-servers-using-google-cloud
categories:
  - how_to
tags: []
---

# IntroStatGen R Studio Servers

For the one-day seminar, we had a hands-on [lab](https://github.com/hakyimlab/QGT-Columbia-HKI) where we decided we needed to set up R Studio Servers. The servers needed pre-loaded data, access to a terminal, pre-compiled binaries for torus and fastenloc, and the correct python/R/Linux environments to run all of our analyses. Here's a guide about how we set up that server. 

## Using Google Cloud Compute Engine

To set everything up, we had a basic workflow:
1. Create a new VM.
1. Configure the VM as an RStudio server with everything installed, downloaded, etc.
1. Take a snapshot of this VM. 
1. Spin up a bunch of new VMs from this snapshot. 

Most of the time (and therefore most of this document) was spent on step 2. Installing, compiling, configuring, uploading, and permissions-ing was the long part. Anyway, you won't have to do all of that if you want to use the most current snapshot. It's called [rstudio-final-2020-06-12](https://console.cloud.google.com/compute/snapshotsDetail/projects/introstatgen/global/snapshots/rstudio-final-2020-06-12?project=introstatgen). 

To spin up multiple VMs, we used Google's command line tools. Most commands in the Google Cloud Console can be replicated in the command line, and just before creating a VM or Snapshot in the Console, you can find a link which gives you the analogous command. Here is what we used to spin up an array:
```
$ cat gcloud_init.sh
gcloud compute --project "introstatgen" disks create "qgt-${1}" \
    --size "50" --zone "us-central1-a" \
    --source-snapshot "rstudio-final-2020-06-12" --type "pd-standard"

gcloud beta compute --project=introstatgen instances create qgt-${1} \
    --zone=us-central1-a --machine-type=custom-1-6656 --subnet=default \
    --network-tier=PREMIUM --maintenance-policy=MIGRATE \
    --service-account=10877517008-compute@developer.gserviceaccount.com \
    --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
     --tags=http-server --disk=name=qgt-${1},device-name=qgt-${1},mode=rw,boot=yes,auto-delete=yes --reservation-affinity=any
$ for i in {0..35} ; do bash gcloud_init.sh $i ; done
```
Which made 36 different servers, each with RStudio available on port 8787. To get a sense of the size of the servers, they were initiated with 50GB of disk space, 6.5 GB of RAM, and 1 processor. When we used Google Cloud's smallest VM (which only had ~3GB RAM) there was a memory error when running S-MultiXcan.

## R Studio Server

This tutorial [link](https://grantmcdermott.com/2017/05/30/rstudio-server-compute-engine/) was pretty helpful. One thing which took some figuring out was that the command listed under the _Install R on your VM_ heading. The command listed downloaded a version of R incompatible with the Ubuntu version running on the VM. But this [link](https://cran.r-project.org/bin/linux/ubuntu/README) had useful information as well as a directory of the R/Ubuntu versions for download.

The download and installation process for R Studio Server was documented very well on their [website](https://rstudio.com/products/rstudio/download-server/). R Studio ran automatically after the download, so I didn't even need a startup script for the VM clones. It just runs automatically, I guess. 

# Add a Student User

Students were asked to access the RStudio server using the account `student` with a given password. This corresponds to a user account on the VM, which can be created using the command `sudo adduser student`. Then, a password is specified, and these credentials can be used to log into the RStudio server. 

**NOTE** because this user does not have sudo privileges, _everything_ in the user's home directory `/home/student/` needs to be readable and writeable (preferrably owned) by `student`. This can be done with a combination of `sudo chown student ...` and `sudo -iu student`; the latter logs in as the `student` user. 

## Add Python Environment

We used Anaconda. The installation was performed when logged in as the `student` user. Doing it as my own user and then changing permissions was a nightmare. The installer script can be downloaded using something like `curl -O https://repo.anaconda.com/archive/Anaconda3-2019.03-Linux-x86_64.sh`. Check [here](https://www.anaconda.com/products/individual) for the latest version. 

A conda environment was defined using a yaml environment file [link](https://github.com/hakyimlab/MetaXcan/blob/master/software/conda_env.yaml)

## Add fastenloc and torus

[Fastenloc](https://github.com/xqwen/fastenloc) and [torus](https://github.com/xqwen/torus) can be compiled pretty easily on Ubuntu. One may need to install a few libraries using `apt`. Make sure to compile static versions, because these binaries should end up in a folder at `/home/student/bin/`, and the `student` user may not have the necessary permissions to find linked libraries. 

After compiling static versions, move them to `/home/student/bin/`; make sure to change owner to `student` and make them executable by `student`. It is also good to automatically add `/home/student/bin` to the `PATH` variable, which can be achieved by modifying the file at `/home/student/.bashrc`.

## Add Data

We used Box (this repo [here](https://uchicago.box.com/s/zhapf2zfxcpj7thvq4sjnqale3emleum)) to gather and store data for this version of the class, and I didn't find a good way to add/update data from Box to the VM. I ended up downloading from Box to my machine, and then `scp`-ing it to the VM. This means that each time the data in Box changed, I had to re-upload or manually update the data on the VM. Not pretty. I hope (hope) there is some way to download from Box out there, and a custom download script could be added to the VM creation script, so that a fresh version of the Box repository is added with each new VM. 

The data should end up in `/home/student/` and should be owned, readable, and writeable by the student. 

## Add Lab Documents

Log in as the student, and clone the lab documents [link again](https://github.com/hakyimlab/QGT-Columbia-HKI) into the student's home directory. 

## Make the Server Image Publicly Available

In addition to the snapshot, there is a publicly available image named `intro-stat-gen-rstudio-server-2020-06-16`. It was made publicly available by this command (suggested by this [page](https://cloud.google.com/compute/docs/images/managing-access-custom-images#share-images-publicly) )
```
gcloud compute images add-iam-policy-binding intro-stat-gen-rstudio-server-2020-06-16 \
    --member='allAuthenticatedUsers' \
    --role='roles/compute.imageUser
```


