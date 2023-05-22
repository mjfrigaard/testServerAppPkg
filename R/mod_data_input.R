#' Import data UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_data_input_ui
#'
#' @importFrom shiny NS tagList selectInput
#'
mod_data_input_ui <- function(id) {
  df_pkgs <- get_pkgs_with_dfs()
  ns <- shiny::NS(id)
  shiny::tagList(
  selectInput(ns("pkg"),
    label = "Pick a package",
    choices = df_pkgs),
  selectInput(ns("dataset"),
    label = "Pick a dataset",
    choices = NULL)
    )
}

#' Import data server module
#'
#' @param id module id
#'
#' @return shiny server module
#' @export mod_data_input_server
#'
#'
#' @section Using `mod_data_input`:
#'
#' `mod_data_input` is intended to be used with `mod_var_select`.
#'
#' `input$dataset` includes a call to `shiny::observe()`,
#' and `shiny::bindEvent(input$pkg)` to ensure both values are
#' included in the returned object.
#'
#' @importFrom shiny NS moduleServer reactive
mod_data_input_server <- function(id) {

  shiny::moduleServer(id, function(input, output, session) {

    shiny::observe({
      df_names <- get_pkg_df_names(pkg = input$pkg)
      updateSelectInput(session = session,
        inputId = "dataset",
        choices = df_names,
        selected = df_names[1])
    }) |>
      shiny::bindEvent(c(input$pkg),
        ignoreNULL = TRUE)

    shiny::reactive({
        req(c(input$dataset, input$pkg))
      get(x = input$dataset,
          pos = paste0("package:", input$pkg))
      }) |>
      shiny::bindEvent(input$dataset,
        ignoreInit = TRUE)

  })
}
