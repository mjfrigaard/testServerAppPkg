shiny::testServer(mod_var_select_server,
  args = list(input_data =
              reactive(get_pkg_data("palmerpenguins")[["penguins"]])), {
  # Test 1 pkg_data() is.data.frame: ----
  testthat::expect_true(is.data.frame(pkg_data()))
  cat("\nTest 1 pkg_data() is.data.frame: ", is.data.frame(pkg_data()), "\n")

  # Test 2 dim(pkg_data()): ----
  expect_equal(object = dim(pkg_data()), expected = c(344L, 8L))
  cat("\nTest 2 dim(pkg_data()): ", dim(pkg_data()), "\n")
  #
  # Test 3 names(pkg_data()) = names(palmerpenguins::penguins): ----
  expect_equal(
    object = names(pkg_data()),
    expected = names(palmerpenguins::penguins))
  cat("\nTest 3 names(pkg_data()) = names(palmerpenguins::penguins): ", "\n")

  # Test 4 names(pkg_data()) = names(palmerpenguins::penguins): ----
  expect_equal(
    object = num_vars(),
    expected = c(bill_length_mm = "bill_length_mm",
                 bill_depth_mm = "bill_depth_mm",
                 flipper_length_mm = "flipper_length_mm",
                 body_mass_g = "body_mass_g",
                 year = "year"))
  cat("\nTest 4 num_vars() = numeric columns: ", "\n")

  # Test 5 col_vars() = binary columns: ----
  expect_equal(
    object = col_vars(),
    expected = c(sex = "sex"))
  cat("\nTest 5 col_vars() = binary columns: ", "\n")

  # Test 6 facet_vars() = facet columns: ----
  expect_equal(
    object = facet_vars(),
    expected = c(species = "species", island = "island"))
  cat("\nTest 6 facet_vars() = facet columns: ", "\n")

})
