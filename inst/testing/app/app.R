# packages --------------------------------------------------------
library(shiny)
library(testthat)


# modules ------------------------------------------------------------------
source("module.R")


# standalone shiny app function
doublerApp <- function() {
  shiny::shinyApp(
    ui = shiny::fluidPage(
      app_module_ui("x")
    ), 
    server = function(input, output, session) { 
      app_module_server("x")
    }
  )
}
doublerApp()