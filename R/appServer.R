#' App Server
#'
#' @importFrom shiny reactive renderPrint reactiveValuesToList
#'
#' @export appServer
appServer <- function(input, output, session) {
  # pkg module ----
  pkg <- mod_pkg_server("pkg")

  # dataset module ----
  dataset <- mod_dataset_server("ds", pkg_input = pkg)

  # column select module ----
  plot_values <- mod_cols_server(id = "cols", ds_input = dataset)

  # plot module ----
  mod_plot_server("plot", plot_inputs = plot_values)

}
