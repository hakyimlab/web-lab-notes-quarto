---
title: How to Configure Custom SSH Connection
author: ''
date: '2020-07-30'
slug: how-to-configure-custom-ssh-connection
categories:
  - how_to
tags: []
---


This wiki will show you how to set up SSH keys and configure custom connection options for accessing uchicago tarbell. After successful configuration, you can login your tarbell much more simply by running the following command: `ssh tarbell` 

1. Create the RSA key pair:  
  - Open terminal
  - `ssh-keygen -t rsa`  
  - Press enter when you are prompted to `Enter a file in which to sae the key`
  - Type a passport when you are prompted to `Enter passphrase (empty for no passphrase):`
  - Type the same passport when you are prompted to `Enter same passphrase again:`

2. Append your public key to the server: 
  - Append your public key to the server using SSH (replace jiamaoz@tarbell.cri.uchicago.edu with your own one): 
    - `cat ~/.ssh/id_rsa.pub | ssh jiamaoz@tarbell.cri.uchicago.edu "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"`

3. Create and configure the SSH config file: 
  - `touch ~/.ssh/config`
  - `chmod 600 ~/.ssh/config`
  - `emacs ~/.ssh/config` 
  - Enter the following into config file: <br>
     `Host tarbell` <br>
         &nbsp;&nbsp; `HostName tarbell.cri.uchicago.edu` <br>
         &nbsp;&nbsp; `User jiamaoz` <br> 


4. Login your uchicago tarbell:
   - `ssh tarbell` 

Reference:
  - https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2
  - https://www.digitalocean.com/community/tutorials/how-to-configure-custom-connection-options-for-your-ssh-client 
  
  