shiny::testServer(mod_abc_server, {
  # Test initial value
  testthat::expect_equal(input$num, NULL)
  cat("\n Test 1 initial input$num = NULL: ", is.null(input$num), "\n")
  # set inputs
  session$setInputs(num = 3)
  # Test set inputs
  testthat::expect_equal(input$num, 3)
  cat("\n Test 2 setInputs(num = 3):", input$num, "\n")
  # Test super script
  testthat::expect_equal(object = sup_scrpt(), expected = "rd")
  cat("\n Test 3 sup_scrpt(): = 'rd':", sup_scrpt(), "\n")
  # Test letter
  testthat::expect_equal(object = letter(), expected = "C")
  cat("\n Test 4 letter() = C:", letter(), "\n")
  # Test output
    testthat::expect_equal(object = output$txt,
      expected =  "[1] \"The 3rd letter in the alphabet is: C\"")
    cat("\n Test 5 output$ = 'The 3rd letter in the alphabet is: C': \n",
      output$txt, "\n")
})