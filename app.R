# run app for package
pkgload::load_all(
  export_all = FALSE,
  helpers = TRUE,
  attach_testthat = TRUE)
library(tsap)
tsap::pkgDataApp()
rsconnect::deployApp()
