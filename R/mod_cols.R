#' Select variables UI module
#'
#' @param id module id
#' @param pkg_data data for application
#'
#' @return shiny UI module
#' @export mod_cols_ui
#'
#' @importFrom shiny NS tagList selectInput
#' @importFrom shiny sliderInput textInput
#'
mod_cols_ui <- function(id) {
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
        ),
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
      ),
      shiny::column(
        width = 6,
        shiny::sliderInput(
          inputId = ns("alpha"),
          label = "Point opacity:",
          min = 0, max = 1, step = 0.1,
          value = 0.7
        ),
        shiny::sliderInput(
          inputId = ns("size"),
          label = "Point size:",
          min = 0, max = 5,
          step = 0.2,
          value = 3
        )
      )
    )
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
#' @export mod_cols_server
#'
#' @importFrom janitor clean_names
#' @importFrom shiny NS moduleServer reactive observe bindCache
#' @importFrom shiny bindEvent renderPrint updateSelectInput
#'
mod_cols_server <- function(id, ds_input) {

  shiny::moduleServer(id, function(input, output, session) {

    pkg_data <- shiny::reactive({
                    janitor::clean_names(ds_input())
                      }) |>
                shiny::bindEvent(ds_input(),
                  ignoreNULL = TRUE)

    shiny::observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "x",
        choices = num_vars,
        selected = num_vars[1])
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    shiny::observe({
      num_vars <- pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "y",
        choices = num_vars,
        selected = num_vars[2])
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    shiny::observe({
      col_vars <- pull_binary_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "col",
        choices = col_vars,
        selected = col_vars[1])
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    shiny::observe({
      facet_vars <- pull_facet_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "facet",
        choices = facet_vars,
        selected = facet_vars[1])
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

       return(
          shiny::reactive({
            shiny::req(c(ds_input(),
                         input$x, input$y,
                         input$col, input$facet,
                         input$alpha, input$size))

            list(
              df = janitor::clean_names(ds_input()),
              x_var = input$x,
              y_var = input$y,
              col_var = input$col,
              facet_var = input$facet,
              alpha = input$alpha,
              size = input$size)
            }) |>
          # bind to cache
          shiny::bindCache(c(ds_input(),
                             input$x, input$y,
                             input$col, input$facet,
                             input$alpha, input$size)) |>
          # bind to event
          shiny::bindEvent(c(ds_input(),
                             input$x, input$y,
                             input$col, input$facet,
                             input$alpha, input$size))
        )

  })
}


