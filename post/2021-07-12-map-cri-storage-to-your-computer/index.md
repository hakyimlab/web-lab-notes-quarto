---
title: Mount Gardner file stystem to your computer
author: Festus Nyasimi
date: '2021-07-12'
slug: map-cri-storage-to-your-computer
categories:
  - how to
tags: []
---

This page contains description on how to map CRI storage to your computer. Depending on the operating system you are using there are different approaches. Which are shown below;

## Mac os users
1. from Finder, click 'Go'
2. then click 'connect to server'
3. then connect to `smb://prfs.cri.uchicago.edu/im-lab`

## Linux users
1. Install `sshfs`
```
sudo apt-get install sshfs 
```
2. Create the mount point
```
# Create the mountpoint
[festus@ubuntu ~ ]$ mkdir ~/im-lab
```
3. Invoke sshfs with your credentials
```
# Invoke SSHFS with your SSH credentials and the remote location to mount
[festus@ubuntu ~ ]$ sshfs t.cri.fnyasimi@gardner.cri.uchicago.edu:/gpfs/data/im-lab ~/im-lab

# If you have set up the ssh config you can use it to mount;
[festus@ubuntu ~ ]$ sshfs gardner:/gpfs/data/im-lab ~/im-lab

# Access the mounted filesystem
[festus@ubuntu ~ ]$ ls ~/im-lab/
nas40t2
```
4. Unmount the filesystem
```
# Unmount the remote FS
[festus@ubuntu ~ ]$ fusermount -u ~/im-lab
```
NB: **_sshfs doesn’t expand ~ on a remote machine to the user’s home directory._**

## Windows users
You need to install two programmes, After the installation, you can mount/map directories from any servers that providing SSH connection service to Windows as a network drive.

1. Install two programs - `WinFsp` and `SSHFS-Win`.
2. Clicks mouse right button on "This PC" in file explorer, selects "Map network drive..." on pop menu.
3. Select drive letter and replaces `username` and  `server host name` to yours.
4. Input your authoritative credentials
5. If success, you will see the drive letter mapped to the folder of your remote ssh server. You're ready to access and manipulate remote files and folders now.


## Note
The sshfs system can also be used on Mac os and windows os.


