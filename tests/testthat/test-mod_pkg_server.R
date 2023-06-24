shiny::testServer(mod_pkg_server, {

  testthat::expect_equal(input$pkg, NULL)
  tscmt("mod_pkg_server", "initial pkg = NULL")

  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_equal(
    object = input$pkg,
    expected = "palmerpenguins")
  tscmt("mod_pkg_server", "change pkg = palmerpenguins")

  session$setInputs(pkg = "NHANES")
  testthat::expect_equal(
    object = input$pkg,
    expected = "NHANES")
  tscmt("mod_pkg_server", "change pkg = NHANES")

  session$setInputs(pkg = "palmerpenguins")
  testthat::expect_true(
    object = is.character(session$returned()))
  tscmt("mod_pkg_server", "is.character")

  session$setInputs(pkg = "NHANES")
  expect_equal(object = session$returned(),
    expected = "NHANES")
  tscmt("mod_pkg_server", "returned")
})
