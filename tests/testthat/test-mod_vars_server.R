shiny::testServer(mod_vars_server,
  args = list(ds_input = reactive(palmerpenguins::penguins)), expr = {
    testthat::expect_equal(
      object = pkg_data(),
      expected = janitor::clean_names(palmerpenguins::penguins))
    cat("\nTest 1 pkg_data() = clean_names(palmerpenguins::penguins) \n")

    testthat::expect_equal(
      object = pull_numeric_cols(df = pkg_data()),
      expected = c(bill_length_mm = "bill_length_mm",
                   bill_depth_mm = "bill_depth_mm",
                   flipper_length_mm = "flipper_length_mm",
                   body_mass_g = "body_mass_g",
                   year = "year"))
    cat("\nTest 2 pull_numeric_cols(pkg_data()) \n")

    testthat::expect_equal(
      object = pull_binary_cols(df = pkg_data()),
      expected = c(sex = "sex"))
    cat("\nTest 3 pull_binary_cols(pkg_data()) \n")

    testthat::expect_equal(
      object = pull_facet_cols(df = pkg_data()),
      expected = c(species = "species", island = "island"))
    cat("\nTest 4 pull_facet_cols(pkg_data()) \n")
})

# shiny::testServer(mod_vars_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 1: pkg_data() = clean_names(palmerpenguins::penguins) -----
#     testthat::expect_equal(
#       object = pkg_data(),
#       expected = janitor::clean_names(palmerpenguins::penguins))
#     cat("\nTest 1 pkg_data() = clean_names(palmerpenguins::penguins) \n")
# })



# })

# shiny::testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 5: x_var() -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$x_var, expected = "bill_length_mm")
#     cat("\nTest 5: x_var = bill_length_mm >>", session$returned()$x_var, "\n")
# })
#
# shiny::testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 6: y_var -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$y_var, expected = "bill_depth_mm")
#     cat("\nTest 6: y_var = bill_depth_mm >>", session$returned()$y_var, "\n")
# })
#
# shiny::testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 7: col_var -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$col_var, expected = "sex")
#     cat("\nTest 7: col_var = sex >>", session$returned()$col_var, "\n")
# })
#
# shiny::testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 8: facet_var -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$facet_var, expected = "species")
#     cat("\nTest 8: facet_var = species >>", session$returned()$facet_var, "\n")
# })
#
# shiny::testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 9: size -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#        object = session$returned()$size, expected = 3)
#     cat("\nTest 9: size = 3 >>", session$returned()$size, "\n")
# })
#
# shiny::testServer(mod_cols_server,
#   args = list(reactive(palmerpenguins::penguins)), expr = {
#     # Test 10: alpha -----
#     session$setInputs(
#       x = "bill_length_mm",
#       y = "bill_depth_mm",
#       col = "sex",
#       facet = "species",
#       size = 3,
#       alpha = 1/2)
#     testthat::expect_equal(
#       object = session$returned()$alpha, expected = 1/2)
#     cat("\nTest 10: size = 1/2 >>", session$returned()$alpha, "\n")
# })
