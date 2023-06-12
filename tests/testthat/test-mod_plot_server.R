shiny::testServer(app = mod_plot_server,
  args = list(
           reactive(
             list(
              df = palmerpenguins::penguins,
              x_var = "bill_length_mm",
              y_var = "bill_depth_mm",
              col_var = "sex",
              facet_var = "species",
              alpha = 0.5,
              size = 2)
             )
    ), expr = {

  # Test 1 plot_inputs() is.list: ----
  testthat::expect_true(
    object = is.list(plot_inputs()))
  cat("\nTest 1 plot_inputs() [is.list] >>", class(plot_inputs()), "\n")

  # Test 2 is.data.frame(plot_inputs()$df): ----
  testthat::expect_true(
    object = is.data.frame(plot_inputs()$df))
    cat("\nTest 2 [class(plot_inputs()$df)] >>", class(plot_inputs()$df), "\n")

  # Test 3 plot_inputs()$x_var = bill_length_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$x_var, expected = "bill_length_mm")
    cat("\nTest 3 plot_inputs()$x_var = [bill_length_mm] >>", plot_inputs()$x_var, "\n")

  # Test 4 plot_inputs()$y_var = bill_depth_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$y_var, expected = "bill_depth_mm")
    cat("\nTest 4 plot_inputs()$y_var = [bill_depth_mm] >>", plot_inputs()$y_var, "\n")

  # Test 5 plot_inputs()$col_var = bill_depth_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$col_var, expected = "sex")
    cat("\nTest 5 plot_inputs()$col_var = [sex] >>", plot_inputs()$col_var, "\n")

  # Test 6 plot_inputs()$facet_var = bill_depth_mm: ----
  testthat::expect_equal(
    object = plot_inputs()$facet_var, expected = "species")
    cat("\nTest 6 plot_inputs()$facet_var = [species] >>", plot_inputs()$facet_var, "\n")

  # Test 7 plot_inputs()$size = 2: ----
  testthat::expect_equal(
    object = plot_inputs()$size, expected = 2L)
    cat("\nTest 7 plot_inputs()$size = [2] >>", plot_inputs()$size, "\n")

  # Test 8 plot_inputs()$alpha = 0.5: ----
  testthat::expect_equal(
    object = plot_inputs()$alpha, expected = 0.5)
    cat("\nTest 8 plot_inputs()$alpha = [0.5] >>", plot_inputs()$alpha, "\n")

  # Test 9 plot_inputs() names: ----
  testthat::expect_equal(
    object = names(plot_inputs()),
    expected = c("df", "x_var", "y_var",
                 "col_var", "facet_var",
                 "alpha", "size"))
    cat("\nTest 9 [names(plot_inputs())] >>", names(plot_inputs()), "\n")
})

