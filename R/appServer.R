#' App Server
#'
#' @importFrom shiny reactive renderPrint reactiveValuesToList
#'
#' @export appServer
appServer <- function(input, output, session) {

  pkg_dataset <- mod_data_input_server(id = "data")

  plot_values <- mod_var_select_server(id = "vars",
                        input_data = pkg_dataset)

  mod_scatter_server(id = "plot",
                     scatter_inputs = plot_values)

  # # include for showing reactive values: ----
  # output$vals <- shiny::renderPrint({
  #   shiny::reactiveValuesToList(x = input, all.names = TRUE)
  # })
  # # include for showing reactive values: ----

}
