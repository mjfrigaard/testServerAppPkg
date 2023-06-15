#' Select variables UI module
#'
#' @param id module id
#' @param pkg_data data for application
#'
#' @return shiny UI module
#' @export mod_vars_ui
#'
#' @importFrom shiny NS tagList selectInput
#' @importFrom shiny sliderInput textInput
#'
mod_vars_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      column(
        width = 6,
        shiny::selectInput(
          inputId = ns("x"),
          label = "X variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("y"),
          label = "Y variable:",
          choices = NULL
        )
      ),
      column(
        6,
        shiny::selectInput(
          inputId = ns("col"),
          label = "Color variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("facet"),
          label = "Facet variable:",
          choices = NULL
        )
      )
    )
    # shiny::fluidRow(
    #   column(
    #     width = 6,
    #     shiny::verbatimTextOutput(ns("vals"))
    #   )
    # ),
  )
}


#' Select variables Server module
#'
#' @param id module id
#' @param ds_input pkg data from
#'
#' @section Returned object (`ds_input`):
#'
#' The returned object passed to `ds_input` is the result of:
#'
#' ```
#' get(x = input$dataset, pos = paste0("package:", pkg_input()))
#' ```
#'
#' * Where `pkg_input()` is the return value from `mod_pkg_server()`, and
#' `input$dataset` is the reactive value from `mod_ds_server()`
#'
#'
#' @return shiny server module
#' @export mod_vars_server
#'
#' @importFrom janitor clean_names
#' @importFrom shiny NS moduleServer reactive observe bindCache
#' @importFrom shiny bindEvent renderPrint updateSelectInput
#'
mod_vars_server <- function(id, ds_input) {
  shiny::moduleServer(id, function(input, output, session) {
    pkg_data <- shiny::reactive({
      janitor::clean_names(ds_input())
    }) |>
      shiny::bindEvent(ds_input(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "x",
        choices = num_vars,
        selected = num_vars[1]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "y",
        choices = num_vars,
        selected = num_vars[2]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      col_vars <- pull_binary_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "col",
        choices = col_vars,
        selected = col_vars[1]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    shiny::observe({
      facet_vars <- pull_facet_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "facet",
        choices = facet_vars,
        selected = facet_vars[1]
      )
    }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE
      )

    df_vars <- shiny::reactive({
      # shiny::req(c(input$x, input$y, input$col, input$facet))
      cols <- c(input$x, input$y, input$col, input$facet)
      if (sum(cols %in% names(pkg_data())) == 4) {
        dplyr::select(
          .data = pkg_data(),
          dplyr::all_of(c(
            input$x, input$y,
            input$col, input$facet
          ))
        )
      }
    }) |>
      shiny::bindEvent(
        c(
          pkg_data(),
          input$x, input$y,
          input$col, input$facet
        ),
        ignoreNULL = TRUE
      )

    # shiny::observe({
    #   output$vals <- shiny::renderPrint({
    #     is.data.frame(df_vars())
    #   })
    # }) |>
    #   shiny::bindEvent(
    #     c(
    #       df_vars(),
    #       input$x, input$y,
    #       input$col, input$facet
    #     ),
    #     ignoreNULL = TRUE
    #   )

    return(
      shiny::reactive({
        cols <- c(input$x, input$y, input$col, input$facet)
        if (sum(cols %in% names(pkg_data())) == 4) {
          dplyr::select(
            .data = pkg_data(),
            dplyr::all_of(c(
              input$x, input$y,
              input$col, input$facet
            ))
          )
        }
      }) |>
        shiny::bindEvent(
          c(
            pkg_data(),
            input$x, input$y,
            input$col, input$facet
          ),
          ignoreNULL = TRUE
        )
    )
  })
}
