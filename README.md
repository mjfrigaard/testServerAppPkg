
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `tsap`

<!-- badges: start -->
<!-- badges: end -->

The goal of `tsap` is to demonstrate how to test a shiny application
package using [`testthat`](https://testthat.r-lib.org/) and
[`shiny::testServer()`](https://search.r-project.org/CRAN/refmans/shiny/html/testServer.html)

## Installation

You don’t want to install this package, but you might want to download
it as an example (or read through [this
post](https://mjfrigaard.github.io/posts/test-shiny-p2/) to learn about
it’s contents).

# Shiny server tests

Check the shiny `testServer()` tests for the modules in
`tests/testthat/`

``` default
├── test-mod_pkg_server.R
├── test-mod_dataset_server.R
├── test-mod_cols_server.R 
└── test-mod_plot_server.R
```
