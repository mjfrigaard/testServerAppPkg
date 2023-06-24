# for testing these need to be on the search list!
require(palmerpenguins)
require(NHANES)
require(testthat)
require(tsap)
shiny::testServer(mod_ds_server,
  args = list(pkg_input = reactive("palmerpenguins")), expr = {

  testthat::expect_equal(
    object = pkg_input(),
    expected = "palmerpenguins")
  cat("\nTest 1 pkg_input() = 'palmerpenguins' >>", pkg_input(), "\n")

  testthat::expect_equal(
    object = get_pkg_df_names(pkg_input()),
    expected = c("penguins", "penguins_raw"))
  cat("\nTest 2 data in palmerpenguins = >>", get_pkg_df_names(pkg_input()), "\n")

    session$setInputs(dataset = "penguins")
    expect_equal(object = input$dataset,
      expected = "penguins")
    cat("\nTest 3 input value = 'penguins' >> ", input$dataset, "\n")

    session$setInputs(dataset = "penguins")
    expect_true(object = is.data.frame(session$returned()))
    cat("\nTest 4 is.data.frame = >>", is.data.frame(session$returned()), "\n")

    penguins <- palmerpenguins::penguins
    session$setInputs(dataset = "penguins")
    expect_equal(object = names(session$returned()),
      expected = names(penguins))
    cat("\nTest 5 names = >>", identical(names(session$returned()), names(penguins)))
})

