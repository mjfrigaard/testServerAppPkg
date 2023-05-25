library(testthat)
library(tsap)
# run utility function tests ----------------------------------------------
source("tests/testthat/helpers.R")
testthat::test_file("tests/testthat/test-get_col_types.R")
testthat::test_file("tests/testthat/test-check_binary_vec.R")
testthat::test_file("tests/testthat/test-check_facet_vec.R")
testthat::test_file("tests/testthat/test-make_binary_vec.R")
testthat::test_file("tests/testthat/test-make_facet_vec.R")
testthat::test_file("tests/testthat/test-pull_numeric_cols.R")
testthat::test_file("tests/testthat/test-pull_binary_cols.R")
testthat::test_file("tests/testthat/test-pull_facet_cols.R")
testthat::test_file("tests/testthat/test-pull_cat_cols.R")


# run module function tests -----------------------------------------------
testthat::test_file("tests/testthat/test-mod_pkg_server.R")
testthat::test_file("tests/testthat/test-mod_dataset_server.R")
testthat::test_file("tests/testthat/test-mod_cols_server.R")
testthat::test_file("tests/testthat/test-mod_plot_server.R")

# or
devtools::test()
