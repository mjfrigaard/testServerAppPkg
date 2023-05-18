library(testthat)
library(tstSvrPkgApp)
# run utility function tests ----------------------------------------------
testthat::test_file(path = "tests/testthat/test-binary_app_inputs.R")
testthat::test_file(path = "tests/testthat/test-get_col_types.R")
testthat::test_file(path = "tests/testthat/test-check_binary_vec.R")
testthat::test_file(path = "tests/testthat/test-check_facet_vec.R")
testthat::test_file(path = "tests/testthat/test-make_binary_vec.R")
testthat::test_file(path = "tests/testthat/test-make_facet_vec.R")


# run module function tests -----------------------------------------------
# testthat::test_file("tests/testthat/test-mod_data_input_server.R")
testthat::test_file("tests/testthat/test-mod_var_select_server.R")
