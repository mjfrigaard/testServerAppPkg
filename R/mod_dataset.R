#' Dataset UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_dataset_ui
#'
#' @importFrom shiny NS tagList selectInput code p verbatimTextOutput
#'
mod_dataset_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
  shiny::selectInput(ns("dataset"),
    label = "Pick a dataset",
    choices = NULL)
    # # include for showing reactive values: ----
    # shiny::code("mod_dataset:"),
    # shiny::p(shiny::code("list(pkg = pkg_input(),")),
    # shiny::p(shiny::code("ds = input$dataset)")),
    # shiny::verbatimTextOutput(
    #   ns("vals")
    #   )

    )
}

#' Dataset server module
#'
#' @param id module id
#' @param pkg_input selected package
#'
#' @return shiny server module
#' @export mod_dataset_server
#'
#'
#' @section Returned object (`pkg_input`):
#'
#' The returned value passed to `pkg_input` is the result of the
#' `get_pkgs_with_dfs()`, which returns a character vector of all packages with
#' a `data.frame` or `tibble` in their exports.
#'
#' `mod_pkg_server` is the precursor to `mod_dataset_server`, and is intended
#' to be return a character vector of packages (see example below):
#'
#' ```
#' pkg <- mod_pkg_server("pkg")
#'
#' mod_dataset_server("ds", pkg_input = pkg)
#' ```
#'
#' @importFrom shiny req moduleServer reactive
#' @importFrom shiny renderPrint observe bindEvent bindCache
mod_dataset_server <- function(id, pkg_input) {

  shiny::moduleServer(id, function(input, output, session) {

    # # include for showing reactive values: ----
    # output$vals <- shiny::renderPrint({
    #   print(
    #   list(pkg = pkg_input(), ds = input$dataset),
    #     width = 40,
    #     max.levels = NULL)
    # })

     shiny::observe({
      df_names <- get_pkg_df_names(pkg = pkg_input())
      shiny::updateSelectInput(session = session,
        inputId = "dataset",
        choices = df_names,
        selected = df_names[1])
    }) |>
      shiny::bindEvent(pkg_input(), ignoreNULL = TRUE)

     shiny::reactive({
          shiny::req(input$dataset,  pkg_input())
                get(x = input$dataset,
                    pos = paste0("package:", pkg_input()))
                }) |>
                  shiny::bindCache(c(pkg_input(), input$dataset)) |>
                  shiny::bindEvent(input$dataset)



  })
}
