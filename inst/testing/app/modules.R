# ui module
mod_abc_ui <- function(id) {
  
  ns <- shiny::NS(id)
  
  shiny::tagList(
    shiny::numericInput(
      inputId = ns("num"),
      label = shiny::h4(
        shiny::code("alphabet number")),
        value = 5, min = 1, max = 26
    ),
    shiny::verbatimTextOutput(
      outputId = ns("txt"))
  )
}

# server module
mod_abc_server <- function(id) {
  
  shiny::moduleServer(id, function(input, output, session) {
    # reactive 
    letter <- shiny::reactive({ LETTERS[input$num] })
    # super script
    sup_scrpt <- shiny::reactive({ 
      num_super_script(x = input$num)
    })
    # output
    output$txt <- shiny::renderPrint({
      paste0("The ", input$num, sup_scrpt(), 
             " letter in the alphabet is: ", letter())
    })
    
  })
}