#' Package UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_pkg_ui
#'
#' @importFrom shiny NS tagList selectInput
#'
mod_pkg_ui <- function(id) {
  df_pkgs <- get_pkgs_with_dfs()
  ns <- shiny::NS(id)
  shiny::tagList(
  shiny::selectInput(ns("pkg"),
    label = "Pick a package",
    choices = df_pkgs)
    )
}

#' Package server module
#'
#' @param id module id
#'
#' @return shiny server module
#' @export mod_pkg_server
#'
#'
#' @section Using `mod_pkg_server`:
#'
#' `mod_pkg` is the intended to be used with `mod_dataset`.
#'
#' ```
#' pkg <- mod_pkg_server("pkg")
#'
#' mod_dataset_server("ds", pkg_input = pkg)
#' ```
#'
#' @importFrom shiny NS moduleServer reactive req
mod_pkg_server <- function(id) {

  shiny::moduleServer(id, function(input, output, session) {

      shiny::reactive({
          shiny::req(c(input$pkg))
            input$pkg
        })

  })
}
