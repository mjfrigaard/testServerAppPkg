# Testing (outside of a package)

This is a small example of testing outside of a package environment. You'll find the following files:

```
├── README.md
├── app.R
├── app.Rproj
├── modules.R
├── utils.R
└──  tests/
      ├── testthat/
      │   └── test-mod_abc_server.R
      └── testthat.R

3 directories, 7 files
```

## Testing module server functions

`app.R` and `tests/testthat/test-mod_abc_server.R` show how `shiny::testServer()` works in an application *with* modules.  

The `tests/testthat.R` file contains the code to run the tests:

``` r
library(testthat)
source("app.R")
test_dir(path = "tests/testthat/")
testthat::test_file("tests/testthat/test-mod_abc_server.R")
```

Note that this is currently set to test the application with modules.

## Testing shiny server function

For more information on testing outside of the package environment, see this discussion on GitHub: https://github.com/r-lib/testthat/issues/659

