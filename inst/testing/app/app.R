# packages --------------------------------------------------------
library(shiny)
library(testthat)

# utils ------------------------------------------------------------------
source("utils.R")

# modules ------------------------------------------------------------------
source("modules.R")


# standalone shiny app function
abcApp <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      mod_abc_ui("x")
    ), 
    server = function(input, output, session) { 
      mod_abc_server("x")
    }
  )
}
abcApp()