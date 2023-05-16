
# ui module
app_module_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tagList(
    shiny::numericInput(
      inputId = ns("num"),
      label = shiny::h4(
        shiny::code("The Doubler")),
      value = 5
    ),
    shiny::textOutput(
      outputId = ns("txt"))
  )
}

# server module
app_module_server <- function(id) {
  
  shiny::moduleServer(id, function(input, output, session) {
    # reactive 
    myreactive <- shiny::reactive({ input$num * 2 })
    # output
    output$txt <- shiny::renderText({
      paste0("I am ", myreactive())
    })
    
  })
}