---
title: Configuring Windows Subsystem for Linux
author: Ian Waters
date: '2020-08-10'
slug: windows-wsl
categories:
  - how_to
tags: []
---

## **Introduction**

This is a guide to configuring a Windows system to utilize many of the tools that the Im Lab uses. 

## **Windows Subsystem for Linux**   

The native command line options in Windows are not well-integrated for many bioinformatic tools, so an alternative solution is to use Windows Subsystem for Linux (WSL). This allows your windows machine to run a Linux environment. These instructions were written on Windows 10 Version	10.0.19041 Build 19041. You can find further info [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).
 

### Setup

In order to get started with WSL, you first need to enable it.  

1. To do so, search for "features" in your search bar and locate "Turn Windows features on or off."   
2. Find the Windows Subsystem for Linux box and check it. Click OK.   
    + Alternatively, you can activate WSL by opening Windows PowerShell as         Administrator and running: `dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart`   
3. There are two WSL versions as of this document's creation. WSL 2 has some performance improvements and other changes that are discussed [here](https://docs.microsoft.com/en-us/windows/wsl/compare-versions#wsl-2-architecture). If you want to use WSL 1 (not recommended, unless you have a specific reason to or your computer does not support WSL 2), restart now. Otherwise, continue to Step 4.  
    + In order to run WSL 2, your Windows version must be 2004, Build 19041 or higher. You can check your version by using **Windows key + R** then **winver.** If your version does not support WSL 2, update to the latest Windows version.   
5. Once you have enabled the WSL feature in Step 2, enable the 'Virtual Machine Platform' by opening PowerShell and running `dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart`  
6. Restart your computer.  
7. To set WSL 2 as your default version, enter the following into PowerShell `wsl --set-default-version 2`  


### Downloading Linux Distribution 

1. In the Microsoft Store, you can search for various Linux distributions. I use the Ubuntu app.  
2. Install your distribution of choice. 
3. Launch the Linux distribution (it will have to decompress some files the first time you download and then you will be asked to make an account)

    
### Setting WSL Distribution Version  
1. Check the WSL version associated with your Linux Distribution by entering the following in PowerShell `wsl -l -v`  
2. If you see 1 for the WSL version, you can change it using PowerShell `wsl --set-version <distribution name> <versionNumber>`, where <distribution name> is the name you see for the distribution when you use `wsl -l -v` and <versionNumber> is 1 or 2. E.g. `wsl --set-version Ubuntu 2`

Troubleshooting options and further details can be found in the Microsoft WSL documentation [here](https://docs.microsoft.com/en-us/windows/wsl/install-win10).  

### Using the Ubuntu App

You can use Linux commands in the Ubuntu App and this set-up (or another WSL distro) will allow you to use the various Im Lab tools that require Bash. 

Your home directory can be accessed in Widows Explorer by entering `\\wsl$\` in the address bar. Your personal files are stored at \\wsl$\Ubuntu\home\<yourname>. You can change this using a .bashrc file, but it is recommended to keep your projects in the linux directory for faster access.

To refer to files within the Windows Filesystem, use "/mnt/c/" in place of "C:" in the filepath. 

If you need to regularly access a folder in the Windows filesystem, you can use `ln -s /mnt/c/<rest of filepath>` to link the folder to your home directory in the Linux system. Be aware that access will be slower this way than if you just move that folder into the WSL Linux home folder. 

Remember to use Linux versions for programs that you are downloading to run through WSL (e.g. Plink, miniconda)!

## **R Studio**

R Studio is a platform that provides a useful interface to run R commands, packages, etc...  

### Installation 

To install R Studio, follow the instructions [here](https://rstudio.com/products/rstudio/download/). 

### Integrating WSL into R Studio Terminal 

One last step to get you set up with WSL is to integrate your Linux Distribution into the Terminal in R Studio, so that you can run things in Linux instead of the default Windows options. 
To do so, open R Studio > Tools > Terminal > Terminal Options > change New Terminals Open With to 'Bash (Windows Subsystem for Linux)'. 

Now you should be ready to go and able to download and utilize packages and tools used in the Im Lab. 
