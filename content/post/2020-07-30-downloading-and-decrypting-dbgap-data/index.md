---
title: Downloading and Decrypting dbGaP Data
author: ''
date: '2020-07-30'
slug: downloading-and-decrypting-dbgap-data
categories:
  - how_to
tags: []
---


This page is about downloading and decrypting data from [NCBI dbGaP](https://www.ncbi.nlm.nih.gov/gap/). I will split up the instructions into Downloading and Decrypting

## Downloading 

To download, one must be approved in the dbGaP controlled data access system, receive an email that the data is ready, and follow the given instructions. 

 - Get approved to download dbGaP data. I did this through [eRA Commons](https://public.era.nih.gov/commons/public/login.do?TARGET=https%3A%2F%2Fpublic.era.nih.gov%2Fcommons%2FcommonsInit.do).
 - Download IBM's Aspera CLI: download is available [here](https://downloads.asperasoft.com/en/downloads/62). Because I was downloading to CRI, I selected the `Linux x86_64` version. 
 - Run the downloaded file. You might have to run `chmod` to make it executable. It should create a directory `.aspera/` in your home directory. 
 - Receive an email about a new dataset available for download. Click on the email's link to see your personal dbGaP Authorized Access: Downloads page. Then click Download, and there will be a pop-up giving you a command to run Aspera to do the download:
```
"%ASPERA_CONNECT_DIR%\bin\ascp" -QTr -l 300M -k 1 -i "%ASPERA_CONNECT_DIR%\etc\asperaweb_id_dsa.openssh" -W <some_long_key> <some_dbGaP_server_address> .
```
   - Change `"%ASPERA_CONNECT_DIR%\bin\ascp"` to `aspera`. If you're running on CRI, the command is already in the PATH
   - Change `"%ASPERA_CONNECT_DIR%\etc\asperaweb_id_dsa.openssh"` to `~/.aspera/etc/asperaweb_id_dsa.openssh`. I'm not entirely sure if specifying a private key is necessary, but this is what I did.
 - Run the command in the directory you want the data to go, or edit the `.` at the end of the command. Wondering where you should put the data? Read all of the section on decrypting, because the data needs to be inside a certain directory to be decrypted.

## Decrypting

I decrypted using NCBI's SRA Toolkit. 

 -  Because I was working on CRI, I downloaded the Linux version from [here](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software). 
 - The project key (necessary for decryption) can be found on the My Projects tab of the dbGaP data portal. Download the key and move it to CRI. 
 - To install and configure the SRA Toolkit, I used this [guide](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc&f=std) which was very helpful. 
 - The guide also walks through how to configure the toolkit, which seems like a lot because I ended up using just one command, `vdb-decrypt`, but it was necessary. 
 - When in the interactive program `vdb-config -i`, you need to do three things: set a home workspace, import the project key (the one you downloaded earlier), and set a project directory for the project corresponding to the key.
 - I have the home workspace in my directory inside our CRI lab share, and the project directory inside the home workspace. `71954` and `71955` are two data downloads corresponding with this project. 
```
ncbi
`-- dbGaP-11644
    |-- files
    |   |-- 71954
    |   `-- 71955
    |-- nannot
    |-- refseq
    |-- sra
    `-- wgs
```
 - To be decrypted, the data must be inside the project directory that you chose, so in this case, all of the data must be inside `dbGaP-11644`.
 - When the project directory is set up and the data is inside, you can use the `vdb-decrypt` command to decrypt the data (SRA data is decrypted differently, and there's a lot of documentation on the NCBI website about how to deal with that data.)


