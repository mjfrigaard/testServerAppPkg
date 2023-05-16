# Testing (outside of a package)

This is a small example of testing outside of a package environment. You'll find the following files:

```
├── README.md
├── app.R
├── app.Rproj
└── tests
    ├── testthat
    │   └── test-mods.R
    └── testthat.R

3 directories, 5 files
```

## Testing module server function

`app.R` and `tests/testthat/test-mods.R` show how `shiny::testServer()` works in an application *with* modules.  

The `tests/testthat.R` file contains the code to run the tests:

``` r
library(testthat)
source("app.R")
test_dir(path = "/Users/mjfrigaard/projects/dev/app/tests/testthat/")
# testthat::test_file("/Users/mjfrigaard/projects/dev/app/tests/testthat/test-app.R")
testthat::test_file("/Users/mjfrigaard/projects/dev/app/tests/testthat/test-mods.R")
```

Note that this is currently set to test the application with modules.

## Testing shiny server function

To test the application in `app.R` *without* modules, use the following code:   

``` r
# packages --------------------------------------------------------
library(shiny)
library(testthat)
# UI
ui <- fluidPage(
  numericInput(
    inputId = "num",
    label = "The Doubler",
    value = 5),
  textOutput(
    outputId = "txt")
)
# server
server <- function(input, output, session) {
  myreactive <- reactive({
    input$num * 2
  })
  output$txt <- renderText({
    paste0("I am ", myreactive())
  })
}
shinyApp(ui = ui, server = server)
```

``` r
shiny::testServer(server, {
  cat("\n Start:  is.null(input$num) = ", is.null(input$num))
  session$setInputs(num = 1)
  cat("\n Set: session$setInputs(num = 1)")
  cat("\n Check: input$num =", input$num)
  cat("\n Run: expect_equal(myreactive(), 2) \n")
  testthat::expect_equal(myreactive(), 2)
})
```

For more information on testing outside of the package environment, see this discussion on GitHub: https://github.com/r-lib/testthat/issues/659

