shiny::testServer(mod_doubler_server, {
  cat("\n Start:  is.null(input$num) = ", is.null(input$num))
  session$setInputs(num = 1)
  cat("\n Check: input$num =", input$num, "\n")
  testthat::expect_equal(
    object = myreactive(), 
    expected = 2)
})