---
title: CRI Gardner upgrade news
author: Haky Im
date: '2020-11-30'
slug: cri-gardner-upgrade-news
categories:
  - news
tags: []
description: ''
topics: []
---

## cri gardner upgrade

* Operating System Upgrade - The operating system will be upgraded from
    Red Hat Linux 6.7 to 7.6. This will provide a kernel that will allow
    for a more modern software ecosystem. For example, software such as
    tensorflow will not run on Red Hat 6.

* GPFS Upgrade - GPFS storage clients will be upgrade from GPFS 4.2 to
    GPFS 5. This will provide a performance increase for metadata
    operations such as creating, listing, and deleting files.

* SLURM Scheduling - The Torque/Moab scheduling on the system will be
    replaced with SLURM. SLURM is an open-source scheduler that has become
    a de facto standard across many HPC sites.

* Deep Learning capabilities - Last year, the CRI purchased two deep
    learning servers with 8 NVidia V100s per server. These servers have
    been open to users who requested the capabilites. With the upgrade, the
    deep learning systems will be added to the general scheduling queue.

* Increased container capabilities - With the upgrade to Red Hat 7, we
    will be able to provide the ability for users to create their own
    singularity containers.

* Authentication/Authorization - We are running
    authentication/authorization clients that are rather outdated at the
    moment. Upgrading those clients should provide a more stable environment
    when logging into the cluster and accessing files.

* Upgraded compilers - The compilers on the cluster will be upgraded to
    the latest version. This will be gcc-10.2.0, llvm-11.0, intel-2020.2,
    and nvhpc-20.9. The compilers will provide implementation of the latest
    standards for C, C++, and Fortran.

* Enhanced accounting - We will be provided accounting on both jobs
    submitted to the cluster as well as software use across the
    environment.
