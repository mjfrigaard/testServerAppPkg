# shiny::testServer(mod_dataset_server,
#   args = list(pkg_input = "palmerpenguins"), expr = {
#     # Test 1: check initial value -----
#   testthat::expect_equal(
#     object = get_pkg_df_names(pkg_input()),
#     expected = c("penguins", "penguins_raw"))
#   cat("\nTest 1 pkg_input() = 'palmerpenguins': >>", pkg_input(), "\n")
# })
shiny::testServer(mod_dataset_server,
  args = list(pkg_input = reactive("palmerpenguins")), expr = {
    # Test 1: check initial value -----
  testthat::expect_equal(
    object = get_pkg_df_names(pkg_input()),
    expected = c("penguins", "penguins_raw"))
  cat("\nTest 1 pkg_input() = 'palmerpenguins': >>", pkg_input(), "\n")

  # Test 2: check input value changes -----
  session$setInputs(dataset = "penguins_raw")
  expect_equal(object = input$dataset,
    expected = "penguins_raw")
  cat("\nTest 2 input value changes: penguins_raw >> ", input$dataset, "\n")

  # Test 3: check class of returned value -----
  session$setInputs(dataset = "penguins")
  expect_equal(object = class(session$returned()),
    expected = c("tbl_df", "tbl", "data.frame"))
  cat("\nTest 3 class = tibble/data.frame: >>", class(session$returned()), "\n")
})

shiny::testServer(mod_dataset_server,
  args = list(pkg_input = reactive("NHANES")), expr = {
    # Test 1: check initial value -----
  testthat::expect_equal(
    object = get_pkg_df_names(pkg_input()),
    expected = c("NHANES", "NHANESraw"))
  cat("\nTest 1 pkg_input() = 'NHANES': >>", pkg_input(), "\n")

  # Test 2: check input value changes -----
  session$setInputs(dataset = "NHANESraw")
  expect_equal(object = input$dataset,
    expected = "NHANESraw")
  cat("\nTest 2 input value changes: penguins_raw >> ", input$dataset, "\n")

  # Test 3: check class of returned value -----
  session$setInputs(dataset = "NHANES")
  expect_equal(object = class(session$returned()),
    expected = c("tbl_df", "tbl", "data.frame"))
  cat("\nTest 3 class = tibble/data.frame: >>", class(session$returned()), "\n")
})
