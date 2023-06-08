---
title: How to Use Workflowr
author: ''
date: '2020-07-30'
slug: how-to-use-workflowr
categories:
  - how_to
tags: []
---


#Open RStudio

#Type the following:

nameproject = "PNPO-Alcohol-Epilepsy"
githubuser = "hakyimlab"

library(workflowr)
setwd("~/Github")

wflow_git_config(user.name = "Your Name", user.email = "email@domain")

wflow_start(nameproject)
wflow_build()
wflow_view()
wflow_status()
wflow_publish(c("analysis/index.Rmd", "analysis/about.Rmd", "analysis/license.Rmd"), "Publish the initial files for myproject")

#Create a GitHub repository with the same name as the nameproject

wflow_use_github(githubuser, nameproject)

#select 2 since the repo has already been created

#push the content of the new repo to GitHub

git push --set-upstream origin master