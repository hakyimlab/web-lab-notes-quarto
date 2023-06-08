---
title: Computing on ANL Servers
author: ''
date: '2020-07-30'
slug: computing-on-anl-servers
categories:
  - how_to
tags: []
---


# Getting Access

To get access to the servers at ANL, you will need at minimum an account with Argonne's MCS division, as well as access to specific computing groups. This process is usually handled by one of the researchers at ANL, as they need to serve as a sponsor for external users.

# Logging In

Once you are granted access, there are a few things to do to log in:
1. Upload your SSH key to [https://accounts.mcs.anl.gov/](https://accounts.mcs.anl.gov/).
2. Log in to the login node: 
```
$ ssh -l user login.mcs.anl.gov
```
3. From there, log into either washington or nucleus. Both are servers used by the ML Lab at Argonne (our project falls under this umbrella). Both servers have access to our encrypted drive, which is mounted at `/vol/bmd/`
```
$ ssh -l user <washington/nucleus>.cels.anl.gov
```
4. Configure your ssh configuration to be able to log in with a single command, and add your public key to the `~/.ssh/authorized_keys` files on the login server, washington, and nucleus.

# Data Storage

The BMD team shares the drive mapped to `/vol/bmd/`. At the time of writing, we have 9.5T of storage. I don't know of a high-speed I/O scratch space on these servers. 

# Computing Resources

These servers do not have a job scheduler, so it is up to the user to run jobs. The compute resources are large enough, and they are used by the other ANL researchers infrequently enough that I haven't run into any collisions yet. 

For running jobs in parallel, we've had some success with the Linux [parallel](https://www.gnu.org/software/parallel/) command. 

## Washington 

16 CPUs, 4 GPUs (being rebuilt, currently not accessible), 1T RAM

## Nucleus 

40 CPUs, 4 GPUs, 250G RAM

# Software

Most of it you'll have to install for yourself. There is a shared software directory at `/vol/bmd/software` where we have shared Conda environments, Spark, Hadoop, ukbREST. 

For some of my specific jobs, I've downloaded and installed programs in my home directory at `~/genomics_utilities`, updated my `~/.bashrc` file with alias statements, and added to the PATH as necessary. If you are installing something you think others will use, feel free to install it to the shared software directory at `/vol/bmd/software`. 

# Data Transfer

For the small stuff, because UChicago and ANL have great networking, I've been able to get away with `scp`. For the larger data transfers, we've been using [Globus](https://www.globus.org/). There is a Globus endpoint mapped to our drive, and it's called Argonne Machine Learning Lab. If you need to use Globus for a big data transfer, I think you need to ask Tom Brettin or Ravi Madduri for access to that endpoint. 

