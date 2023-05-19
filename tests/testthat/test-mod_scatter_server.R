shiny::testServer(mod_scatter_server,
  args = list(scatter_inputs =
              reactive(
                list(
                 df = palmerpenguins::penguins,
                 x_var = "bill_length_mm",
                 y_var = "bill_depth_mm",
                 col_var = "sex",
                 facet_var = "species",
                 alpha = 0.5, size = 2L))), {

  # Test 1 scatter_inputs() is.list: ----
  expect_true(is.list(scatter_inputs()))
  cat("\nTest 1 scatter_inputs() is.list: ", is.list(scatter_inputs()), "\n")

  # Test 2 scatter_inputs() names: ----
  testthat::expect_equal(names(scatter_inputs()),
    expected = c("df", "x_var", "y_var",
                "col_var", "facet_var",
                "alpha", "size"))
  cat("\nTest 2 scatter_inputs() names: ", names(scatter_inputs()), "\n")

  # Test 3 plot() class: ----
  expect_equal(class(plot()), c("gg", "ggplot"))
  cat("\nTest 3 plot() class: ", class(plot()), "\n")
  #
  # # view plot
  # suppressWarnings(print(plot()))

})
