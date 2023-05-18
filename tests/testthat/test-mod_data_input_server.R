shiny::testServer(mod_data_input_server, {
  # Test 1: check initial value
  testthat::expect_equal(input$pkg, NULL)
  cat("\nTest 1 initial input$pkg = NULL: ", is.null(input$pkg), "\n")

  # Test 2: check for changes in input$pkg
  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_equal(
    object = input$pkg,
    expected = "palmerpenguins")
  cat("\nTest 2 change input$pkg = 'palmerpenguins': ", input$pkg, "\n")

  # Test 3: check get_pkg_data()
  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_equal(
    object = pkg_data_nms(),
    expected = names(get_pkg_data(package = "palmerpenguins")))
  cat("\nTest 3 get_pkg_data('palmerpenguins'): ", pkg_data_nms(), "\n")

  # Test 4: check class of returned values
  session$setInputs(pkg = "palmerpenguins", data = "penguins")
  expect_equal(object = class(session$returned()),
    expected = c("tbl_df", "tbl", "data.frame"))
  cat("\nTest 4 class(session$returned()): ", class(session$returned()), "\n")

  # Test 5: check dimensions of returned values
  session$setInputs(pkg = "NHANES", data = "NHANES")
  expect_equal(object = dim(session$returned()),
    expected = c(10000L, 76L))
  cat("\nTest 5 dim(session$returned()): ", dim(session$returned()), "\n")
})
