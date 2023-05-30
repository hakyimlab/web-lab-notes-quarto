---
title: Using R_Markdown
author: Ian Waters
date: '2020-07-08'
slug: using-r-markdown
categories:
  - how_to
tags: []
---


# R Markdown Introduction


## Description
R Markdown is a authoring framework that allows for reproducible documentation of data science within the context of R Studio. This is an introduction designed to teach you how to use R Markdown in a few minutes. Further info and some of the examples used below can be found here: http://rmarkdown.rstudio.com

## Format 
R Markdown allows you to incorporate text, inline code, code chunks, and results into a single document. You can then create html pages, pdfs, word docs, and other file formats discussed below. 


# Using R Markdown


## Installing 
To install R Markdown, you can navigate to *tools -> install packages -> rmarkdown* in R Studio. Alternatively, you can run the console command: install.packages("rmarkdown")

## Creating a File
To create a new R Markdown file, go to *file -> New File -> R Markdown*. There, you can create a blank file or choose a template. R Markdown files are plain text files with the .Rmd extension. If this is your first time using R Markdown, we suggest using the .html template by entering a Title and Author Name and clicking Ok. 

## Header
The first few lines of every R Markdown file make up a YAML header enclosed by three "-"s on each end. If you created a new file from above, you will see that your header contains the title, author, date, and output. Other document settings can also be modified in the header, but these will be discussed later. 

## Text Formatting Tips
Text written in R Markdown uses the Markdown syntax. There are a number of annotations that will result in formatted text upon file rendering. A helpful reference guide can be found [here](https://rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf) and can be accessed by going to *Help -> Markdown Quick Reference*  
Below are some formatting examples that you can try. You can preview using the Knit button in the toolbar, which will be discussed in further detail below.    
`*italic*` or `_italic_`  
`**bold**` or `__bold__`  
`superscript^2^` and `subscript~2~`  
`~~strikethrough~~`  
code blocks can be made with "``"  

line breaks require two or more spaces at the end of the line  
links: `[text for link](www.rstudio.com)`  
`# Example Header` for largest header, add more # for smaller headers. Note: you must include the space after the # or it will not format correctly  
For further syntax tips (including lists, images, etc...), take a look at the reference documents linked above.  

## Code Chunks 
You can incorporate code chunks into your R Markdown files using:   
* The ![](https://d33wubrfki0l68.cloudfront.net/b8b19518e688e3ca1390e0a1588916f04908d33f/8a4dc/images/notebook-insert-chunk.png) button in the toolbar    
* Ctrl + Alt + I (OS X: Cmd + Option +I)  
* Chunk delimiters like below 


