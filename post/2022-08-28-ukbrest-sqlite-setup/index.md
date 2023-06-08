---
title: ukbREST SQLite Setup
author: Sabrina Mi
date: '2022-08-28'
slug: ukbrest-sqlite-setup
categories:
  - installlation
  - how to
tags: []
---

This post explains how to
1. Query UKBREST in CRI
2. Create an SQLite database from the postgres database 
3. Update the withdrawal list

> The version of ukbREST that runs on SQLite is [HERE](https://github.com/sabrina-mi/ukbrest). If you come across an existing ukbrest repo in CRI, it might be the original version.

```
git clone https://github.com/sabrina-mi/ukbrest

```

> The standard ukbREST setup involves loading UKB CSVs into a Postgres database, but because of CRI limitations, we copied it to an SQLite file.

# Querying ukbREST

The SQLite file is kept in the UKB labshare: `/gpfs/data/ukb-share/sqlite/db`. Before we can make any queries, we need to start the ukbREST server. This program needs to either be kept running all the time in a background terminal, or restarted each time you need to pull queries. If you are querying in CRI, this part needs to be run in the login node, NOT as an interactive job.

```
conda activate /gpfs/data/im-lab/nas40t2/lab_software/miniconda/envs/ukb_env/
export UKBREST_DB_URI="sqlite:////gpfs/data/ukb-share/sqlite/db/ukbrest.db"
cd /gpfs/data/ukb-share/sqlite/ukbrest
/gpfs/data/im-lab/nas40t2/lab_software/miniconda/envs/ukb_env/bin/python \
-m ukbrest.app \
--db-uri sqlite:////gpfs/data/ukb-share/sqlite/db/ukbrest.db \
--debug

```

If program looks like it's hanging and prints something like the line below, the server is running and ready to accept queried.

```
2022-08-28 20:57:36,753 - werkzeug - INFO -  * Running on http://127.0.0.1:5000/ (Press CTRL+C to quit)
```

Flask defaults to `http://127.0.0.1:5000/`, so if you see the error, 
`OSError: [Errno 98] Address already in use`, it means that some other server is running on port 5000. You'll need to find the other process and kill it.


Open up a new terminal, or if you've started the server in CRI, login in a new window. Here's an example query from a [YAML file](example/test.yaml):

```
$ cat test.yaml 
samples_filters:
  - eid not in (select eid from withdrawals)
  - eid > 0
data:
  cause_of_death: c40001_0_0
  
```

```
curl -X POST \
  -H "Accept: text/csv" \
  -F file=@"test.yaml" \
  -F section="data" \
  http://127.0.0.1:5000/ukbrest/api/v1.0/query \
  > test.csv
  
```

Or column query:
```
curl -G \
-HAccept:text/csv \
"http://127.0.0.1:5000/ukbrest/api/v1.0/phenotype" \
--data-urlencode "columns=c3_0_0" > column_query.csv

```
The following error prints after querying if you are running the original version of ukbREST. Replacing with the updated branch and restarting the server should do the trick.

# Creating the SQLite database from Postgres 

We already had a ukbREST server running in Bionimbus, so it was quicker to copy the Postgres database to an SQLite file instead of loading from scratch. This step only needs to be done once.

The script `pg2sqlite.py` takes a list of table names in the Postgres database and copies them to `ukbrest.db`. I've added it to the Github, in [`migration/pg2sqlite.py`](https://github.com/sabrina-mi/ukbrest/blob/master/migration/pg2sqlite.py), but the SQLite path and Postgres URI are hard-coded, if you plan to use it.

```
conda activate ukbrest
cd /mnt/sql
python pg2sqlite.py tables.txt
## find this code here https://github.com/sabrina-mi/ukbrest/blob/master/migration/pg2sqlite.py
```

# Update Withdrawal List Periodically

We decided to copy the Postgres database once, rather than loading data the [documented way](https://github.com/hakyimlab/ANL-ukbREST-queries/tree/master/ukbREST_setup), because the jobs were extremely slow to finish in CRI. However, we will need to update the database every time a new withdrawal list is sent out, so we would want to update the withdrawals table directly from CSV.

Create a folder for withdrawals, and move the CSV there. The data in `ukb-share` was downloaded from UKB Application *19526*, so the CSV should be named something like `w19526_*.csv`

```
conda activate /gpfs/data/im-lab/nas40t2/lab_software/miniconda/envs/ukb_env/
export UKBREST_DB_URI="sqlite:////gpfs/data/ukb-share/sqlite/db/ukbrest.db"
export UKBREST_WITHDRAWALS_PATH="/gpfs/data/ukb-share/withdrawals/"
cd /mnt/software/ukbrest
python -m ukbrest.load_data \
 --load-withdrawals \
 --withdrawals-dir /gpfs/data/ukb-share/withdrawals/ \
 --db-uri sqlite:////gpfs/data/ukb-share/sqlite/db/ukbrest.db \
 --debug
 ```
 
If you are loading new phenotype data in CRI, it gets a little complicated. The main difference is that we have to break up each CSV into multiple jobs, so that CRI doesn't kill it for taking too long. The directory `/gpfs/data/ukb-share/sql/test` includes example PBS scripts to split CSVs into tables with 750 columns (`test_split.sh`) and load the smaller file into `test.db` (`test_load.sh`).

