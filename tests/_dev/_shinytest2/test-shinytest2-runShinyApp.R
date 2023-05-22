library(shinytest2)

test_that("pkgDataApp() initial values are consistent", {
  shiny_app <- testServerAppPkg::pkgDataApp(testing = TRUE)
  app <- AppDriver$new(shiny_app, height = 596, width = 1156)
  app$expect_values()
})
