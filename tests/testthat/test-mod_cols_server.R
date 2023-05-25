shiny::testServer(mod_cols_server,
  args = list(reactive(palmerpenguins::penguins)), expr = {

    # Test 1: pkg_data() = clean_names(palmerpenguins::penguins) -----
    expect_equal(
      object = pkg_data(),
      expected = janitor::clean_names(palmerpenguins::penguins))
    cat("\nTest 1 pkg_data() = clean_names(palmerpenguins::penguins) \n")

    # Test 2: pull_numeric_cols(clean_names(palmerpenguins::penguins)) -----
    expect_equal(
      object = pull_numeric_cols(df = pkg_data()),
      expected = c(bill_length_mm = "bill_length_mm",
                   bill_depth_mm = "bill_depth_mm",
                   flipper_length_mm = "flipper_length_mm",
                   body_mass_g = "body_mass_g",
                   year = "year"))
    cat("\nTest 2 pull_numeric_cols(clean_names(palmerpenguins::penguins)) \n")

    # Test 3: pull_binary_cols(clean_names(palmerpenguins::penguins)) -----
    expect_equal(
      object = pull_binary_cols(df = pkg_data()),
      expected = c(sex = "sex"))
    cat("\nTest 3 pull_binary_cols(clean_names(palmerpenguins::penguins)) \n")

    # Test 4: pull_facet_cols(clean_names(palmerpenguins::penguins)) -----
    expect_equal(
      object = pull_facet_cols(df = pkg_data()),
      expected = c(species = "species", island = "island"))
    cat("\nTest 4 pull_facet_cols(clean_names(palmerpenguins::penguins)) \n")
})

shiny::testServer(mod_cols_server,
  args = list(reactive(palmerpenguins::penguins)), expr = {
    # Test 5: x_var() -----
    session$setInputs(
      x_var = "bill_length_mm",
      y_var = "bill_depth_mm",
      col_var = "sex",
      facet_var = "species",
      size = 3,
      alpha = 1/2)
    expect_equal(
      object = input$x_var, expected = "bill_length_mm")
    cat("\nTest 5: x_var \n")
})

shiny::testServer(mod_cols_server,
  args = list(reactive(palmerpenguins::penguins)), expr = {
    # Test 6: y_var -----
    session$setInputs(
      x_var = "bill_length_mm",
      y_var = "bill_depth_mm",
      col_var = "sex",
      facet_var = "species",
      size = 3,
      alpha = 1/2)
    expect_equal(
      object = input$y_var, expected = "bill_depth_mm")
    cat("\nTest 6: y_var \n")
})

shiny::testServer(mod_cols_server,
  args = list(reactive(palmerpenguins::penguins)), expr = {
    # Test 7: col_var -----
    session$setInputs(
      x_var = "bill_length_mm",
      y_var = "bill_depth_mm",
      col_var = "sex",
      facet_var = "species",
      size = 3,
      alpha = 1/2)
    expect_equal(
      object = input$col_var, expected = "sex")
    cat("\nTest 7: col_var \n")
})

shiny::testServer(mod_cols_server,
  args = list(reactive(palmerpenguins::penguins)), expr = {
    # Test 8: facet_var -----
    session$setInputs(
      x_var = "bill_length_mm",
      y_var = "bill_depth_mm",
      col_var = "sex",
      facet_var = "species",
      size = 3,
      alpha = 1/2)
    expect_equal(
      object = input$facet_var, expected = "species")
    cat("\nTest 8: facet_var \n")
})

shiny::testServer(mod_cols_server,
  args = list(reactive(palmerpenguins::penguins)), expr = {
    # Test 9: size -----
    session$setInputs(
      x_var = "bill_length_mm",
      y_var = "bill_depth_mm",
      col_var = "sex",
      facet_var = "species",
      size = 3,
      alpha = 1/2)
    expect_equal(
      object = input$size, expected = 3)
    cat("\nTest 9: facet_var \n")
})

shiny::testServer(mod_cols_server,
  args = list(reactive(palmerpenguins::penguins)), expr = {
    # Test 10: alpha -----
    session$setInputs(
      x_var = "bill_length_mm",
      y_var = "bill_depth_mm",
      col_var = "sex",
      facet_var = "species",
      size = 3,
      alpha = 1/2)
    expect_equal(
      object = input$alpha, expected = 1/2)
    cat("\nTest 10: alpha \n")
})
