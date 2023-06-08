---
title: Installing R packages without admin access
author: Berkely Statistics
date: '2021-07-29'
slug: installing-r-packages-without-admin-access
categories:
  - how to
tags: []
---

# How do I install R packages?

** Note that this content was copied from the Berkely Statistics Website [Original article linked here](https://statistics.berkeley.edu/computing/R-packages)

**Library Path Management**

First, note that in general, the administrators of the High Performance Computing clusters will install an R package on the system.

However, you can also install packages locally within your home directory. So if you need a package quickly or on a one-time basis, or if the package is particularly specialized, you might install it locally.

By default, R searches a set of paths when you request actions involving libraries. The first path is used by default when invoking functions such as `install.packages()` leading to messages like this:

```
mkdir: cannot create directory  '/server/linux/lib/R/site-library/00LOCK': Permission denied ERROR: failed to lock directory  '/server/linux/lib/R/site-library' for modifying
```

Fortunately, R provides a number of methods for controlling the library path to accommodate just about any user's need.

## Temporarily changing the library path

You can modify R's notion of your library path on a one-time basis by specifying the `lib=` argument to `install.packages`. Suppose there is a directory called `MyRlibs` in your home directory. The command:

```
install.packages('caTools',lib='~/MyRlibs')
```

will install the specified package in your local directory. To access it, the `lib.loc=` argument of `library` must be used:

```
library('caTools',lib='~/MyRlibs')
```

One problem with this scheme is that if a local library invokes the `library()` function, it won't know to also search the local library

## Changing the library path for a session

The `.libPaths()` function accepts a 
character vector naming the libraries which are to be used as a search 
path. Note that it does not automatically retain directories which are 
already on the search path. Since the `.libPaths()` function returns the current search path when called with no arguments, a call like

```
.libPaths(c('~/MyRlibs',.libPaths()))
```

will put your local directory at the beginning of the search path. This means that `install.packages()` will automatically put packages there, and the `library()` function will find libraries in your local directory without additional arguments.

## Permanently changing the library path

The environmental variable `R_LIBS` is set
 by the script that invokes R, and can be overridden (in a shell startup
 file, for example) to customize your library path. This variable should
 be set to a colon-separated string of directories to search. Since it's
 always set inside of an R session, the easiest way to get a starting 
point for it is to use `Sys.getenv()`:

```
> Sys.getenv('R_LIBS')
[1] "/usr/local/linux/lib/R/site-library:/usr/local/lib/R/site-library:/usr/lib/R/site-library:/usr/lib/R/library"
```

You could then make a copy of this path, modify it, and set the `R_LIBS` environmental variable to that value in the shell or a startup script.