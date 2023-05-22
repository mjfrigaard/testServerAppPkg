
<!-- README.md is generated from README.Rmd. Please edit that file -->

# `testServerAppPkg`

<!-- badges: start -->
<!-- badges: end -->

The goal of `testServerAppPkg` is to demonstrate how to build and test a shiny
application using `usethis`, `shiny::testServer()`, and `shinytest2`.

## Installation

You don’t want to install this package, but you might want to download
it as an example (or read through [this
post](https://mjfrigaard.github.io/posts/testing-shiny/) to learn about
it’s contents).

## Run the app

``` r
testServerAppPkg::pkgDataApp()
```

# Unit tests

Check the unit tests for `gg_base()` and `gg_points()` in

    #> tests/testthat/
    #> ├── test-gg_base.R
    #> └── test-gg_points.R

# Shiny server tests

Check the shiny `testServer()` tests for `mod_var_select_server()` and
`mod_scatter_server()` in

    #> tests/testthat/
    #> ├── test-mod_scatter_server.R
    #> └── test-mod_var_select_server.R
