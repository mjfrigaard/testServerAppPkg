shiny::testServer(mod_pkg_server, {
  # Test 1: check initial value -----
  testthat::expect_equal(input$pkg, NULL)
  cat("\nTest 1 initial pkg = NULL: >>", is.null(input$pkg), "\n")

  # Test 2 change pkg = 'palmerpenguins': ----
  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_equal(
    object = input$pkg,
    expected = "palmerpenguins")
  cat("\nTest 2 change pkg = 'palmerpenguins' >> ", input$pkg, "\n")

  # Test 3 change pkg: 'NHANES' = ----
  session$setInputs(pkg = "NHANES")
  testthat::expect_equal(
    object = input$pkg,
    expected = "NHANES")
  cat("\nTest 3 change pkg = 'NHANES' >>", input$pkg, "\n")

  # Test 4: check class of returned values ----
  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_true(
    object = is.character(session$returned()))
  cat("\nTest 4 is.character() >>", is.character(session$returned()), "\n")

  # Test 5: check return value ----
  session$setInputs(pkg = "NHANES")
  expect_equal(object = session$returned(),
    expected = "NHANES")
  cat("\nTest 5 session$returned() = 'NHANES' >>", session$returned())
})
