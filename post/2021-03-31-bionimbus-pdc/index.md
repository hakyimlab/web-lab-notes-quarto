---
title: Bionimbus PDC
author: Sabrina Mi
date: '2021-03-31'
slug: bionimbus-pdc
categories:
  - how_to
tags: []
---

# Table of Contents

1.  [Apply for a Bionimbus Account](#apply-for-a-bionimbus-account)
2.  [Setup and Logging In](#setup-and-logging-in)
3.  [Creating a Virtual Machine](#creating-a-virtual-machine)
4.  [Using S3 Storage](#using-s3-storage)

# Apply for a Bionimbus Account {#apply-for-a-bionimbus-account}

1.  First, you'll need a NIH eRA Commons account. That is administered through UChicago's University Research Administration, here is a link: <https://ura.uchicago.edu/page/era-commons> One of the questions they will ask is what role you will need in the Commons. Here's a link about the different roles: <https://era.nih.gov/files/eRA-Commons-Roles-10-2019.pdf>
2.  After you have an eRA Commons account, Haky must give you "downloader" privileges in dbGaP.
3.  Then, apply for access to Bionimbus: <https://bionimbus.opensciencedatacloud.org/pre_apply/?next=/apply/>. For the question about "Describe your research \[Public Abstract -- 500 words or less\]", we've submitted variants of this in the past: "This research involves storing, querying and maintaining complex data from the UK Biobank. The data will be stored in a relational database hosted on Bionimbus. This study contains PII for over 500k people."

# Setup and Logging In {#setup-and-logging-in}

1.  `cd ~/.ssh`
2.  Check for a file name id_rsa.pub. If it's not there, generate a key by running `ssh-keygen -t rsa`, and enter a password. If you view id_rsa.pub, there should be a block of text starting with ssh-rsa.
3.  Log in to the bionimbus console: <https://bionimbus-pdc.opensciencedatacloud.org/console/>
4.  Go to the Access & Security tab, then Import Keypair.
5.  In the Public Key box, copy and paste the text from id_rsa.pub. Import keypair for both instances and login.
6.  To launch a VM instance, go to the Images & Snapshot tab. Select an Image, then click launch. Name it, and in the Access & Security tab, choose the keypair you just created.
7.  In the terminal, enable key forwarding by editing the config file in \~/.ssh. It should look like this:

```         
Host bionimbus
 HostName bionimbus-pdc.opensciencedatacloud.org
 User username
 IdentityFile ~/.ssh/id_rsa
 ForwardAgent yes
Host bionimbusvm
 HostName instanceIPaddress
 User ubuntu
 IdentityFile ~/.ssh/id_rsa
 ProxyCommand ssh -q -A bionimbus -W %h:%p
 ForwardAgent yes
```

8.  Load your key into the ssh-agent by running `ssh-add ~/.ssh/id_rsa`. Check that your key is loaded by running `ssh-add -l` before you ssh into the login node, and again in the login node to confirm the key has forwarded
9.  Lastly, set up 2FA. In the email sent when your account is created, there should be a secret link to a QR code. Scan the QR or copy the section of the url after 3Fsecret%3D in Google Authenticator.

Reference: \* https://www.opensciencedatacloud.org/support/ssh.html \* https://www.opensciencedatacloud.org/support/2fa.html

# Creating a Virtual Machine {#creating-a-virtual-machine}

On Bionimbus, the computing resources are highly-configurable virtual machines. The workflow is to create a VM, then log in via `ssh`, then transfer data to/from the VM using the S3 storage. Here, we'll show two ways to start up a VM.

## Bionimbus Website

The Bionimbus PDC console [link](https://bionimbus-pdc.opensciencedatacloud.org/console/) is a nice, user-friendly way to set up VMs. The interface makes it pretty much self-explanatory. Just go to the "Instances" tab, and click the "Launch Instance" button in the top right corner. When choosing configurations, make sure to choose the correct SSH key so you have access to the machine you just created.

When the instance is launched, it will show an IP address. To access the instance, you first log into the Bionimbus login node, and then SSH into that address. For instance:

```
ssh -A ubuntu@<ip_address>
```

If you choose an image with an Ubuntu operating system, the user assigned to you is named `ubuntu`.

## Command Line

The Bionimbus website is always having troubles, so a more reliable option is spinning up a VM from the command line. The first step is to log into the Bionimbus login node.

### Choosing an image

```
$ nova image-list
/usr/lib/python2.7/dist-packages/urllib3/util/ssl_.py:97: InsecurePlatformWarning: A true SSLContext object is not available. This prevents urllib3 from configuring SSL appropriately and may cause certain SSL connections to fail. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning.
  InsecurePlatformWarning
+--------------------------------------+---------------------------------------------+--------+--------------------------------------+
| ID                                   | Name                                        | Status | Server                               |
+--------------------------------------+---------------------------------------------+--------+--------------------------------------+
| 76154988-d1c1-4e4f-9ccc-16b6f65f89bb | GSE26494_Ubuntu_14.04_2015-05-29            | ACTIVE |                                      |
| 48df8504-e2f0-418b-b54f-88066b858ebc | Ubuntu-14.04                                | ACTIVE | 7c337e94-abbc-43d8-a67b-5c9b36489297 |
| 3c4c6ac3-2723-48c6-89b6-9510878b17ea | Ubuntu-16.04-20170705                       | ACTIVE | 27605fc7-aed0-4d74-8a67-de422f417967 |
| ddd6a452-0d50-456a-bd4d-0f4fd05cbf78 | Ubuntu-16.04-20170801                       | ACTIVE | ff86aa20-6a4a-4c95-85ff-c9bcff888703 |
| 5d80c155-16db-45da-b9b0-dddeb56b1325 | Ubuntu-16.04-20171003                       | ACTIVE | 7f33c164-7561-4676-abd7-8ed8689e86b8 |
| aa465c1b-0d35-4655-85ec-571e6c06f0a0 | Ubuntu-16.04-raw-20170306                   | ACTIVE | c8f72c89-caa1-4954-9146-14ef0462a60d |
| 6fb5fb36-6dc2-4b49-b772-999a2b6c9287 | Ubuntu-18.04                                | ACTIVE | 8bce91f1-ab13-40f9-a994-8cee7b164e10 |
| ff69d7f8-4ed5-42d8-9b7a-6551498af392 | Ubuntu-18.04                                | ACTIVE | 5493affa-af61-4060-b49d-c9754d554a38 |
| c5dd47f8-6508-4cc9-93a8-4597d4754225 | Ubuntu_18_multipurpose_node                 | ACTIVE | 90ced9c2-943b-4026-a5e0-c364a36440cc |
| 30464444-fb4f-48cb-971b-cb79a73b8949 | centos-7-2017-07-20                         | ACTIVE |                                      |
| cc263d56-d6ca-47fb-8f93-bbd0da576e6a | docker-20160418                             | ACTIVE |                                      |
| 3f841efc-1964-4f0e-8a10-401f6c6ba437 | kubernetes-PoC-image-ubuntu16.04-2018-01-11 | ACTIVE | b582f560-12db-4aaa-b617-8ca1e7a5e9e9 |
| be16c465-0e00-41a9-a15f-7a95e84dd7ca | torque-cluster-node-14.04-20161101          | ACTIVE | a9dbbfaf-53a3-4be5-8d5a-5d0e6cb169ce |
| 73c16451-30c2-4ba3-9dce-ce93c8242c5d | torque-headnode-14.04-20161021              | ACTIVE |                                      |
| fd670f25-c2f4-45c1-9902-cc713dd3b94f | torque-headnode-14.04-20161101              | ACTIVE | 5d93a97f-858d-4e40-a123-a73d8879f5ed |
| fd86aa94-5363-4fe0-9282-51097f92ec7a | ukbREST_server                              | SAVING | be009f2e-a0a2-4e61-89ab-1714d04b1805 |
+--------------------------------------+---------------------------------------------+--------+--------------------------------------+
```

I haven't yet had a use-case where I needed something more specialized than a plain Ubuntu machine, so I've always chosen the most recent Ubuntu image available. At the time of writing, that is Ubuntu-18.04 with image ID `ff69d7f8-4ed5-42d8-9b7a-6551498af392`.

### Choosing a Flavor

Next you need to choose a VM 'flavor'. This is akin to choosing the hardware specs for your machine. There are different configurations with different amounts of memory, disk space, and processors. The command to show all of the flavors is `nova flavor-list`

```
$ nova flavor-list
/usr/lib/python2.7/dist-packages/urllib3/util/ssl_.py:97: InsecurePlatformWarning: A true SSLContext object is not available. This prevents urllib3 from configuring SSL appropriately and may cause certain SSL connections to fail. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning.
  InsecurePlatformWarning
+--------------------------------------+------------------------------+-----------+------+-----------+------+-------+-------------+-----------+
| ID                                   | Name                         | Memory_MB | Disk | Ephemeral | Swap | VCPUs | RXTX_Factor | Is_Public |
+--------------------------------------+------------------------------+-----------+------+-----------+------+-------+-------------+-----------+
| 05df75bf-1f2d-4f34-988d-d57ec13cdb27 | ram16.disk100.eph0.core4     | 16384     | 100  | 0         |      | 4     | 1.0         | True      |
| 0b86bc0b-73c3-4f05-88ce-8c957e1804e6 | ram125.disk50.eph4000.core32 | 128000    | 50   | 4000      |      | 32    | 1.0         | True      |
| 0e0fc4ee-8d40-4fc7-9af4-91d723f85dd0 | ram32.disk100.eph0.core4     | 32768     | 100  | 0         |      | 4     | 1.0         | True      |
| 10                                   | m1.xxlarge                   | 49152     | 10   | 0         |      | 16    | 1.0         | True      |
| 11                                   | m1.xxxlarge                  | 98304     | 10   | 0         |      | 32    | 1.0         | True      |
| 12                                   | hs1.medium                   | 6144      | 20   | 0         |      | 2     | 1.0         | True      |
| 13                                   | hs1.large                    | 12288     | 20   | 0         |      | 4     | 1.0         | True      |
| 14                                   | gm.large                     | 24576     | 30   | 0         |      | 8     | 1.0         | True      |
| 15                                   | ram12.disk40.eph10.core2     | 12288     | 40   | 10        |      | 2     | 1.0         | True      |
| 16                                   | hs3.xlarge                   | 24576     | 40   | 0         |      | 8     | 1.0         | True      |
| 17                                   | gm.xlarge                    | 32768     | 40   | 0         |      | 8     | 1.0         | True      |
| 18                                   | es1.small                    | 3072      | 10   | 1024      |      | 1     | 1.0         | True      |
| 20d675e6-b9b4-4d90-a989-afa5d84d4141 | ram125.disk10.eph0.core32    | 128000    | 10   | 0         |      | 32    | 1.0         | True      |
| 27                                   | es1.xxxlarge                 | 122880    | 40   | 1024      |      | 32    | 1.0         | True      |
| 28                                   | es1.xxlarge                  | 61440     | 40   | 1024      |      | 16    | 1.0         | True      |
| 29                                   | es1.xlarge                   | 30720     | 10   | 1024      |      | 8     | 1.0         | True      |
| 2b6d2383-59fa-4f3b-8b6d-6a82a88ca2c3 | ram16.disk100.eph0.core2     | 16384     | 100  | 0         |      | 2     | 1.0         | True      |
| 2b84186c-c701-484a-8898-4b872db8aef3 | ram8.disk10.eph0.core8       | 8192      | 10   | 0         |      | 8     | 1.0         | True      |
| 2f8d695e-5de6-4cb7-8a39-b8edacacf4b9 | ram64.disk10.eph0.core16     | 65536     | 10   | 0         |      | 16    | 1.0         | True      |
| 30                                   | es1.large                    | 15360     | 10   | 1024      |      | 4     | 1.0         | True      |
| 31                                   | hs3.large                    | 12288     | 40   | 0         |      | 4     | 1.0         | True      |
| 32                                   | hs3.xxlarge                  | 49152     | 40   | 0         |      | 16    | 1.0         | True      |
| 33                                   | br1.large                    | 15360     | 1000 | 0         |      | 4     | 1.0         | True      |
| 34                                   | es4.xxxlarge                 | 98304     | 10   | 4096      |      | 32    | 1.0         | True      |
| 35                                   | ram2.disk10.eph0.core1       | 2048      | 10   | 0         |      | 1     | 1.0         | True      |
| 4eecfa83-2265-426d-aee5-5863d4755d4b | ram2.disk3.eph0.core1        | 2048      | 3    | 0         |      | 1     | 1.0         | True      |
| 57195829-973f-42d5-9eb6-64c9f68b9ad0 | ram12.disk10.eph4096.core8   | 12288     | 10   | 4096      |      | 8     | 1.0         | True      |
| 5b04ebf5-9620-45f8-8260-7f5043b63343 | ram64.disk10.eph1024.core16  | 65536     | 10   | 1024      |      | 16    | 1.0         | True      |
| 6                                    | m1.small                     | 3072      | 10   | 0         |      | 1     | 1.0         | True      |
| 6194655e-7681-4a3a-8ed9-62f012000d97 | ram6.test                    | 6144      | 10   | 1024      |      | 2     | 1.0         | True      |
| 7                                    | m1.medium                    | 6144      | 10   | 0         |      | 2     | 1.0         | True      |
| 72b625a6-64c2-4360-ad99-957d4054f7b4 | ram8.disk10.eph0.core2       | 8192      | 10   | 0         |      | 2     | 1.0         | True      |
| 8                                    | m1.large                     | 12288     | 10   | 0         |      | 4     | 1.0         | True      |
| 84a51f22-88f5-418c-8a2f-2ac5062fb546 | ram6.disk10.eph1024.core2    | 6144      | 10   | 1024      |      | 2     | 1.0         | True      |
| 877502af-9358-4332-93d0-c182e9b80bfc | ram4.disk10.eph0.core4       | 4096      | 10   | 0         |      | 4     | 1.0         | True      |
| 8e45fe50-18b0-4f4a-b5b0-60d7fe3dd0e9 | ram125.disk10.eph4096.core32 | 128000    | 10   | 4096      |      | 32    | 1.0         | True      |
| 9                                    | m1.xlarge                    | 24576     | 10   | 0         |      | 8     | 1.0         | True      |
| 9ba2e74e-dc4d-4d3b-9ca3-481294d6b06b | ram32.disk10.eph1024.core16  | 32768     | 10   | 1024      |      | 16    | 1.0         | True      |
| b41506d4-4f8f-4aae-98ed-f77f71e44f41 | ram16.disk10.eph512.core4    | 16384     | 10   | 512       |      | 4     | 1.0         | True      |
| bf7e81f3-39ae-4b9b-ad65-e7252614fa43 | ram60.disk10.eph0.core16     | 61440     | 10   | 0         |      | 16    | 1.0         | True      |
| c5195a4d-6d70-4e83-9bbe-04dc7d7a7f5c | ram16.disk10.eph2048.core4   | 16384     | 10   | 2048      |      | 4     | 1.0         | True      |
| ef18330e-41d3-4cbb-9a78-67a9afca182c | ram60.disk10.eph10240.core16 | 61440     | 10   | 10240     |      | 16    | 1.0         | True      |
+--------------------------------------+------------------------------+-----------+------+-----------+------+-------+-------------+-----------+
```

A quick explanation of the columns: - `Memory_MB` is the amount of memory allocated to the VM - `Disk` is the amount of disk storage mounted on `/` - `Ephemeral` is the amount of disk storage mounted to a separate drive (usually `/mnt/`). This storage goes away if a snapshot is taken of the VM. - `VCPUs` is the number of CPUs allocated.

Unfortunately, not all of these flavors currently work. As of May 2020, I was able to confirm that the `m1.xlarge`, `es1.xlarge`, and `es1.xxlarge` flavors were all working.

For our demo, we will use the `es1.xlarge` flavor, which has flavor ID `29`.

### Choosing a Keypair

You'll need to specify a keypair to give access to the VM. You can run the command `nova keypair-list` to show which keypairs are available for you to use.

If you need to import a keypair, there's a command for that too. NOTE: I haven't used this command, I am just reading the documentation [here](https://docs.openstack.org/newton/user-guide/cli-nova-configure-access-security-for-instances.html).

First, `scp` your PUBLIC ssh key to the bionimbus login node. I'll assume that the public key is at `~/.ssh/id_rsa.pub`. Then, you can use the `nova keypair-add` command:

```
$ nova keypair-add --pub-key ~/.ssh/id_rsa.pub KEY_NAME
```

For our demonstration, I'll use the keypair named `owen-macbook`.

### Starting the VM

So we chose an image, a flavor, and a keypair to configure the VM. Now, we need to choose a name; let's say `test_node`. Here's the command to create the VM and start it up:

```
nova boot \
test_node \
--image ff69d7f8-4ed5-42d8-9b7a-6551498af392 \
--flavor 29 \
--key_name owen-macbook
```

The output looked like this:

```         
/usr/lib/python2.7/dist-packages/urllib3/util/ssl_.py:97: InsecurePlatformWarning: A true SSLContext object is not available. This prevents urllib3 from configuring SSL appropriately and may cause certain SSL connections to fail. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning.
  InsecurePlatformWarning
+--------------------------------------+-----------------------------------------------------+
| Property                             | Value                                               |
+--------------------------------------+-----------------------------------------------------+
| OS-DCF:diskConfig                    | MANUAL                                              |
| OS-EXT-AZ:availability_zone          |                                                     |
| OS-EXT-STS:power_state               | 0                                                   |
| OS-EXT-STS:task_state                | scheduling                                          |
| OS-EXT-STS:vm_state                  | building                                            |
| OS-SRV-USG:launched_at               | -                                                   |
| OS-SRV-USG:terminated_at             | -                                                   |
| accessIPv4                           |                                                     |
| accessIPv6                           |                                                     |
| adminPass                            | HWCbS63SiHaf                                        |
| config_drive                         |                                                     |
| created                              | 2020-08-25T14:51:22Z                                |
| flavor                               | es1.xlarge (29)                                     |
| hostId                               |                                                     |
| id                                   | f3c8270c-f71c-4644-b708-da3c0df6ea8d                |
| image                                | Ubuntu-18.04 (ff69d7f8-4ed5-42d8-9b7a-6551498af392) |
| key_name                             | owen-macbook                                        |
| metadata                             | {}                                                  |
| name                                 | test_node                                           |
| os-extended-volumes:volumes_attached | []                                                  |
| progress                             | 0                                                   |
| security_groups                      | default                                             |
| status                               | BUILD                                               |
| tenant_id                            | 18a7bd7295044b64a8117e0eb53e8830                    |
| updated                              | 2020-08-25T14:51:22Z                                |
| user_id                              | b28b67ef34e74aefae0bafe4c5bb328f                    |
+--------------------------------------+-----------------------------------------------------+
```

And when I ran `nova list` to see all of the VMs, it showed up:

```
$ nova list
/usr/lib/python2.7/dist-packages/urllib3/util/ssl_.py:97: InsecurePlatformWarning: A true SSLContext object is not available. This prevents urllib3 from configuring SSL appropriately and may cause certain SSL connections to fail. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning.
  InsecurePlatformWarning
+--------------------------------------+--------------------+--------+------------+-------------+-----------------------+
| ID                                   | Name               | Status | Task State | Power State | Networks              |
+--------------------------------------+--------------------+--------+------------+-------------+-----------------------+
| f4107261-a2eb-4989-910c-6276e3dd6c39 | owen_macbook       | ACTIVE | -          | Running     | private=172.16.149.42 |
| 18687472-6184-4bab-b6da-404748d45eef | sabrina_macbook    | ACTIVE | -          | Running     | private=172.16.168.45 |
| f3c8270c-f71c-4644-b708-da3c0df6ea8d | test_node          | ACTIVE | -          | Running     | private=172.16.136.46 |
| 9bb71982-f41b-422d-8aa2-30bf38d9d8c3 | ukbREST            | ACTIVE | -          | Running     | private=172.16.179.43 |
| ed5c2621-1ec3-4408-813d-91932fda734c | ukbREST_1          | ACTIVE | -          | Running     | private=172.16.171.45 |
| 0636df1d-3cb2-40e7-be8a-936d399e556f | ukbREST_query_node | ACTIVE | -          | Running     | private=172.16.169.45 |
| d603dc2a-a899-469d-80c4-c68e0a120bb5 | ukbREST_sabrina    | ACTIVE | -          | Running     | private=172.16.135.46 |
+--------------------------------------+--------------------+--------+------------+-------------+-----------------------+
```

### Shutting off the VM

To shut off the VM, the command is `nova stop <VM name>`, and to delete it permanently, the command is `nova delete <VM name>`.

# Using S3 Storage {#using-s3-storage}

The s3 storage bucket is at `s3://uk-biobank.hakyimlab.org/`. We've found that a reliable way to get files in and out of s3 storage is to use AWS S3 CLI [link](https://docs.aws.amazon.com/cli/latest/reference/), but a very specific AWS (`awscli==1.11.56`) package version is needed. To help with this, you can use this conda environment file:

```
name: aws
channels:
  - conda-forge
  - defaults
dependencies:
  - _libgcc_mutex=0.1=main
  - ca-certificates=2020.4.5.1=hecc5488_0
  - certifi=2019.11.28=py27h8c360ce_1
  - colorama=0.3.7=py27_0
  - docutils=0.16=py27h8c360ce_1
  - futures=3.3.0=py27h8c360ce_1
  - jmespath=0.9.5=py_0
  - libedit=3.1.20181209=hc058e9b_0
  - libffi=3.3=he6710b0_1
  - libgcc-ng=9.1.0=hdf63c60_0
  - libstdcxx-ng=9.1.0=hdf63c60_0
  - ncurses=6.2=he6710b0_1
  - pip=19.3.1=py27_0
  - pyasn1=0.4.8=py_0
  - python=2.7.18=h15b4118_1
  - python-dateutil=2.8.1=py_0
  - python_abi=2.7=1_cp27mu
  - pyyaml=3.12=py27_1
  - readline=8.0=h7b6447c_0
  - rsa=3.4.2=py_1
  - s3transfer=0.1.13=py27_1001
  - setuptools=44.0.0=py27_0
  - six=1.14.0=py_1
  - sqlite=3.31.1=h62c20be_1
  - tk=8.6.8=hbc83047_0
  - wheel=0.33.6=py27_0
  - yaml=0.2.4=h516909a_0
  - zlib=1.2.11=h7b6447c_3
  - pip:
    - awscli==1.11.56
    - botocore==1.5.19
prefix: /home/ubuntu/anaconda3/envs/aws
```

### Credentials

Before accessing the s3 bucket, you need to configure AWS with your credentials; I believe the command is `aws configure`. This will ask for an access key ID and a secret access key. Both of these keys can be found in the `~/S3_creds.txt` file on the Bionimbus login node. They are automatically generated for each account. It will also ask for a region; I've used `us-east-1`.

### Sample Commands

Listing data:

```
aws s3 ls --human-readable \
--endpoint-url https://bionimbus-objstore.opensciencedatacloud.org \
s3://uk-biobank.hakyimlab.org/data/
```

Copying data to s3:

```
aws s3 cp \
--endpoint-url https://bionimbus-objstore.opensciencedatacloud.org \
/data/path/on/your/computer/file.txt
s3://uk-biobank.hakyimlab.org/data/path/in/s3/
```

Copying data from s3:

```
aws s3 cp --recursive \
--endpoint-url https://bionimbus-objstore.opensciencedatacloud.org \
s3://uk-biobank.hakyimlab.org/data/path/in/s3/
./ 
```

If you're unsure about a command copying data to/from, you can always use the `--dryrun` flag, which lists the operations, but doesn't complete them.

# Creating an Image

A "snapshot" preserves the state and data of a virtual machine at a given point in time. For our purposes, we create an image from our ukbREST instance. When we start up a new server from the image, all of the data is intact, saving us many steps in the setup process.

First, choose an instance to take a snapshot of. The instance ID can be found by running `nova list`. Run `nova image-create <INSTANCE ID> <NEW UNIQUE NAME>`.

For example, I created an image from `ukbrest_natasha` with the date in the name.

```
nova image-create dd5194af-514a-4227-bce1-e7768f0023b7 ukbrest-image-2021-03-30

```

The image appears at the bottom of the list when we run `nova image-list`.

```
+--------------------------------------+---------------------------------------------+--------+--------------------------------------+
| ID                                   | Name                                        | Status | Server                               |
+--------------------------------------+---------------------------------------------+--------+--------------------------------------+
| 76154988-d1c1-4e4f-9ccc-16b6f65f89bb | GSE26494_Ubuntu_14.04_2015-05-29            | ACTIVE |                                      |
| 48df8504-e2f0-418b-b54f-88066b858ebc | Ubuntu-14.04                                | ACTIVE | 7c337e94-abbc-43d8-a67b-5c9b36489297 |
| 3c4c6ac3-2723-48c6-89b6-9510878b17ea | Ubuntu-16.04-20170705                       | ACTIVE | 27605fc7-aed0-4d74-8a67-de422f417967 |
| ddd6a452-0d50-456a-bd4d-0f4fd05cbf78 | Ubuntu-16.04-20170801                       | ACTIVE | ff86aa20-6a4a-4c95-85ff-c9bcff888703 |
| 5d80c155-16db-45da-b9b0-dddeb56b1325 | Ubuntu-16.04-20171003                       | ACTIVE | 7f33c164-7561-4676-abd7-8ed8689e86b8 |
| aa465c1b-0d35-4655-85ec-571e6c06f0a0 | Ubuntu-16.04-raw-20170306                   | ACTIVE | c8f72c89-caa1-4954-9146-14ef0462a60d |
| 6fb5fb36-6dc2-4b49-b772-999a2b6c9287 | Ubuntu-18.04                                | ACTIVE | 8bce91f1-ab13-40f9-a994-8cee7b164e10 |
| ff69d7f8-4ed5-42d8-9b7a-6551498af392 | Ubuntu-18.04                                | ACTIVE | 5493affa-af61-4060-b49d-c9754d554a38 |
| c5dd47f8-6508-4cc9-93a8-4597d4754225 | Ubuntu_18_multipurpose_node                 | ACTIVE | 90ced9c2-943b-4026-a5e0-c364a36440cc |
| 30464444-fb4f-48cb-971b-cb79a73b8949 | centos-7-2017-07-20                         | ACTIVE |                                      |
| cc263d56-d6ca-47fb-8f93-bbd0da576e6a | docker-20160418                             | ACTIVE |                                      |
| 3f841efc-1964-4f0e-8a10-401f6c6ba437 | kubernetes-PoC-image-ubuntu16.04-2018-01-11 | ACTIVE | b582f560-12db-4aaa-b617-8ca1e7a5e9e9 |
| be16c465-0e00-41a9-a15f-7a95e84dd7ca | torque-cluster-node-14.04-20161101          | ACTIVE | a9dbbfaf-53a3-4be5-8d5a-5d0e6cb169ce |
| 73c16451-30c2-4ba3-9dce-ce93c8242c5d | torque-headnode-14.04-20161021              | ACTIVE |                                      |
| fd670f25-c2f4-45c1-9902-cc713dd3b94f | torque-headnode-14.04-20161101              | ACTIVE | 5d93a97f-858d-4e40-a123-a73d8879f5ed |
| fd86aa94-5363-4fe0-9282-51097f92ec7a | ukbREST_server                              | SAVING | be009f2e-a0a2-4e61-89ab-1714d04b1805 |
| 9f8adb72-5c85-4071-9974-4fd3113ca8e2 | ukbrest-image-2021-03-30                    | ACTIVE | dd5194af-514a-4227-bce1-e7768f0023b7 |
+--------------------------------------+---------------------------------------------+--------+--------------------------------------+

```

When the image is first created, its status will be `SAVING`. Once it updates to `ACTIVE` (may take some time), we can launch an instance.

I started up a VM with the same command as earlier, replacing the `--image` parameter with the ukbrest image ID.

```
nova boot ukbrest-started-2021-03-30 \
--image 9f8adb72-5c85-4071-9974-4fd3113ca8e2 \
--flavor 0b86bc0b-73c3-4f05-88ce-8c957e1804e6 \
--key_name instances_keypair

```

It appears at the bottom when I run `nova list`. (It may also take some time for the instance status to become `ACTIVE`).

```
+--------------------------------------+----------------------------+---------+------------+-------------+-----------------------+
| ID                                   | Name                       | Status  | Task State | Power State | Networks              |
+--------------------------------------+----------------------------+---------+------------+-------------+-----------------------+
| 9bb71982-f41b-422d-8aa2-30bf38d9d8c3 | ukbREST                    | SHUTOFF | -          | Shutdown    | private=172.16.179.43 |
| 4e4f6ada-fd3d-4855-b704-488397ca45c4 | ukbREST_jamie              | SHUTOFF | -          | Shutdown    | private=172.16.151.46 |
| b245f419-2e63-4da8-90ef-4e9952c54793 | ukbrest-started-2021-03-30 | ACTIVE  | -          | Running     | private=172.16.159.46 |
| dd5194af-514a-4227-bce1-e7768f0023b7 | ukbrest_natasha            | ACTIVE  | -          | Running     | private=172.16.145.46 |
+--------------------------------------+----------------------------+---------+------------+-------------+-----------------------+

```

Before we terminate the original `ukbrest_natasha`, we check that the `ukbrest-started-2021-03-30` VM works properly.
