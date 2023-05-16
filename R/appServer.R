#' App Server
#'
#' @importFrom shiny reactive renderPrint reactiveValuesToList
#'
#' @export appServer
appServer <- function(input, output, session) {

  mod_var_input_server(id = "vars")

  # selected_vars <- mod_var_input_server(id = "vars")
  # mod_scatter_output_server(
  #   id = "plot",
  #   var_inputs = selected_vars,
  #   app_data = shiny::reactive({ palmerpenguins::penguins })
  # )

  # # include these for showing reactive values to include in tests: ----
  # output$vals <- shiny::renderPrint({
  #   all_vals <- shiny::reactiveValuesToList(
  #     x = input,
  #     all.names = TRUE
  #   )
  #   print(all_vals)
  # })

}
