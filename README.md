
# data.table <a href="https://r-datatable.com"><img src="https://raw.githubusercontent.com/Rdatatable/data.table/master/.graphics/logo.png" align="right" height="140" /></a>

<!-- badges: start -->
[![CRAN status](https://badges.cranchecks.info/flavor/release/data.table.svg)](https://cran.r-project.org/web/checks/check_results_data.table.html)
[![R-CMD-check](https://github.com/Rdatatable/data.table/workflows/R-CMD-check/badge.svg)](https://github.com/Rdatatable/data.table/actions)
[![Codecov test coverage](https://codecov.io/github/Rdatatable/data.table/coverage.svg?branch=master)](https://app.codecov.io/github/Rdatatable/data.table?branch=master)
[![GitLab CI build status](https://gitlab.com/Rdatatable/data.table/badges/master/pipeline.svg)](https://rdatatable.gitlab.io/data.table/web/checks/check_results_data.table.html)
[![downloads](https://cranlogs.r-pkg.org/badges/data.table)](https://www.rdocumentation.org/trends)
[![CRAN usage](https://jangorecki.gitlab.io/rdeps/data.table/CRAN_usage.svg?sanitize=true)](https://gitlab.com/jangorecki/rdeps)
[![BioC usage](https://jangorecki.gitlab.io/rdeps/data.table/BioC_usage.svg?sanitize=true)](https://gitlab.com/jangorecki/rdeps)
[![indirect usage](https://jangorecki.gitlab.io/rdeps/data.table/indirect_usage.svg?sanitize=true)](https://gitlab.com/jangorecki/rdeps)
[![Powered by NumFOCUS](https://img.shields.io/badge/powered%20by-NumFOCUS-orange.svg?style=flat&colorA=E1523D&colorB=007D8A )](http://numfocus.org)
<!-- badges: end -->

`data.table` provides a high-performance version of [base R](https://www.r-project.org/about.html)'s `data.frame` with syntax and feature enhancements for ease of use, convenience and programming speed.

[//]: # (numfocus-fiscal-sponsor-attribution)

The `data.table` project uses a [custom governance agreement](./GOVERNANCE.md) 
and is fiscally sponsored by [NumFOCUS](https://numfocus.org/). Consider making 
a [tax-deductible donation](https://numfocus.org/project/data-table) to help the project 
pay for developer time, professional services, travel, workshops, and a variety of other needs.

<div align="center">
  <a href="https://numfocus.org/project/data-table">
    <img width="25%" 
         src="https://raw.githubusercontent.com/numfocus/templates/master/images/numfocus-logo.png" 
         align="center">
  </a>
</div>
<br>

## Why `data.table`?

* concise syntax: fast to type, fast to read
* fast speed
* memory efficient
* careful API lifecycle management
* community
* feature rich

## Features

* fast and friendly delimited **file reader**: **[`?fread`](https://rdatatable.gitlab.io/data.table/reference/fread.html)**, see also [convenience features for _small_ data](https://github.com/Rdatatable/data.table/wiki/Convenience-features-of-fread)
* fast and feature rich delimited **file writer**: **[`?fwrite`](https://rdatatable.gitlab.io/data.table/reference/fwrite.html)**
* low-level **parallelism**: many common operations are internally parallelized to use multiple CPU threads
* fast and scalable aggregations; e.g. 100GB in RAM (see [benchmarks](https://duckdblabs.github.io/db-benchmark/) on up to **two billion rows**)
* fast and feature rich joins: **ordered joins** (e.g. rolling forwards, backwards, nearest and limited staleness), **[overlapping range joins](https://github.com/Rdatatable/data.table/wiki/talks/EARL2014_OverlapRangeJoin_Arun.pdf)** (similar to `IRanges::findOverlaps`), **[non-equi joins](https://github.com/Rdatatable/data.table/wiki/talks/ArunSrinivasanUseR2016.pdf)** (i.e. joins using operators `>, >=, <, <=`), **aggregate on join** (`by=.EACHI`), **update on join**
* fast add/update/delete columns **by reference** by group using no copies at all
* fast and feature rich **reshaping** data: **[`?dcast`](https://rdatatable.gitlab.io/data.table/reference/dcast.data.table.html)** (_pivot/wider/spread_) and **[`?melt`](https://rdatatable.gitlab.io/data.table/reference/melt.data.table.html)** (_unpivot/longer/gather_)
* **any R function from any R package** can be used in queries not just the subset of functions made available by a database backend, also columns of type `list` are supported
* has **[no dependencies](https://en.wikipedia.org/wiki/Dependency_hell)** at all other than base R itself, for simpler production/maintenance
* the R dependency is **as old as possible for as long as possible**, dated April 2014, and we continuously test against that version; e.g. v1.11.0 released on 5 May 2018 bumped the dependency up from 5 year old R 3.0.0 to 4 year old R 3.1.0

## Installation

```r
install.packages("data.table")

# latest development version (only if newer available)
data.table::update_dev_pkg()

# latest development version (force install)
install.packages("data.table", repos="https://rdatatable.gitlab.io/data.table")
```

See [the Installation wiki](https://github.com/Rdatatable/data.table/wiki/Installation) for more details.

## Usage

Use `data.table` subset `[` operator the same way you would use `data.frame` one, but...

* no need to prefix each column with `DT$` (like `subset()` and `with()` but built-in)
* any R expression using any package is allowed in `j` argument, not just list of columns
* extra argument `by` to compute `j` expression by group

```r
library(data.table)
DT = as.data.table(iris)

# FROM[WHERE, SELECT, GROUP BY]
# DT  [i,     j,      by]

DT[Petal.Width > 1.0, mean(Petal.Length), by = Species]
#      Species       V1
#1: versicolor 4.362791
#2:  virginica 5.552000
```

### Getting started

* [Introduction to data.table](https://cran.r-project.org/package=data.table/vignettes/datatable-intro.html) vignette
* [Getting started](https://github.com/Rdatatable/data.table/wiki/Getting-started) wiki page
* [Examples](https://rdatatable.gitlab.io/data.table/reference/data.table.html#examples) produced by `example(data.table)`

### Cheatsheets

<a href="https://raw.githubusercontent.com/rstudio/cheatsheets/master/datatable.pdf"><img src="https://raw.githubusercontent.com/rstudio/cheatsheets/master/pngs/datatable.png" width="615" height="242"/></a>

## Community

`data.table` is widely used by the R community. It is being directly used by hundreds of CRAN and Bioconductor packages, and indirectly by thousands. It is one of the [top most starred](https://medium.datadriveninvestor.com/most-starred-and-forked-github-repos-for-r-in-data-science-fb87a54d2a6a) R packages on GitHub, and was highly rated by the [Depsy project](http://depsy.org/package/r/data.table). If you need help, the `data.table` community is active on [StackOverflow](https://stackoverflow.com/questions/tagged/data.table).

A list of packages that significantly support, extend, or make use of `data.table` can be found in the [Seal of Approval](https://github.com/Rdatatable/data.table/blob/master/Seal_of_Approval.md) document.

### Stay up-to-date

- click the **Watch** button at the top and right of GitHub project page
- read [NEWS file](https://github.com/Rdatatable/data.table/blob/master/NEWS.md)
- follow [#rdatatable](https://twitter.com/hashtag/rdatatable) and the [r_data_table](https://x.com/r_data_table) account on X/Twitter
- follow [#rdatatable](https://fosstodon.org/tags/rdatatable) and the [r_data_table account](https://fosstodon.org/@r_data_table) on fosstodon
- follow the [data.table community page](https://www.linkedin.com/company/data-table-community) on LinkedIn
- watch recent [Presentations](https://github.com/Rdatatable/data.table/wiki/Presentations)
- read recent [Articles](https://github.com/Rdatatable/data.table/wiki/Articles)
- read posts on [The Raft](https://rdatatable-community.github.io/The-Raft/)

### Contributing

Guidelines for filing issues / pull requests: [Contribution Guidelines](https://github.com/Rdatatable/data.table/blob/master/.github/CONTRIBUTING.md).
