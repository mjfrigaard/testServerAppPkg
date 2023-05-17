#' App Server
#'
#' @importFrom shiny reactive renderPrint reactiveValuesToList
#'
#' @export appServer
appServer <- function(input, output, session) {

  selected_data <- mod_data_input_server(id = "data")

  selected_vars <- mod_var_input_server(id = "vars",
                                        input_data = selected_data)

  mod_scatter_server(id = "plot",
                     vars = selected_vars,
                     df = selected_data)

  # include for showing reactive values: ----
  output$vals <- shiny::renderPrint({
    shiny::reactiveValuesToList(x = input, all.names = TRUE)
  })
  # include for showing reactive values: ----

}
