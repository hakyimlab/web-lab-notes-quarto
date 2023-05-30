---
title: How to Prepare a Post Implementation Report?
author: ''
date: '2020-07-30'
slug: how-to-prepare-a-post-implementation-report
categories:
  - how_to
tags: []
---


This is a guide on how to prepare a Post-Implementation Report for cloud credits, for future reference.
This guide is based on the one prepared for the deadline of February 28th 2019.

A Post-Implementation Report (PIR) provides data to compare the Cloud Credits model to traditional
mechanisms of funding computation-based scientific research. Comparisons based on information
collectively derived from PIRs include cost-benefit, scalability, research productivity, and the shared
collection of valuable reusable digital objects.

## Procedure
You are required to provide information in this PIR only on digital objects that you pledged to share in
your credit request application(s). However, should you wish to share additional digital objects not
originally described in your credit application but deemed valuable to the research community, please do
so. PIR are submitted online via the Commons Credits Portal.

### Types of Digital Objects
1. Data: Digital data contains quantitative or qualitative facts, such as numbers, words,
measurements, observations, or descriptions of entities. 
2. Application (or tool): A digital application has features, functions, and interfaces that
constrain it to a need, context, or purpose, making it valuable. A digital tool performs a set of
functions that are generally useful but not tied to any circumstance, problem, or approach.
Tools typically have widespread utility.
3. Workflow (or pipeline): A digital workflow is a series of activities that are necessary to
complete a task. Each step in a workflow has a specific step before it (except for the first step)
and a specific step after it (except for the last step).

If you have a collection of digital objects with similar characteristics, they can be grouped into a single object of type "set".

### Where to store the object
A digital object must be made available in a repository. It can be a domain-specific repository (e.g. ), a general public repository such as Figshare, a institutional repository or the native cloud environment where the object was generated.

### Indexing the object
The digital object must be indexed. To do this, its metadata must be submitted through CEDAR (see instructions [here](https://github.com/metadatacenter/pipelines/wiki/CEDAR-CCP-Pipeline.))
Some remarks when filling in the metadata form:
- Google Cloud Storage's URI (i.e. `gs://bucket/...`) can be used as a digital object identifier. If uploading to Figshare, a DOI can be requested from the repository.
- The fields "distribution ID" and "ID" might differ: for example, if a same object was published in different repositories, the field "distribution ID" would account for the particular.
- The link to a landing page explaining the content of the object must be provided. It could be, for example, an html file uploaded to the same folder where the object is stored.
- If the paper associated to the object is not published yet, the field "Title" can be filled in with "Pending".

When the form is ready to submit, set the "Ready to Index" field to True. This will tell bioCADDIE that it can start indexing the object.
After a suitable time was passed (indexing can take up to two days), search the [Datamed](https://datamed.org/) web site for your object to verify its metadata was successfully added.

