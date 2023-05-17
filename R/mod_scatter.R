#' Scatter plot UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_scatter_ui
#'
#' @importFrom shiny NS tagList tags column
#' @importFrom shiny plotOutput verbatimTextOutput
mod_scatter_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::plotOutput(outputId = ns("scatterplot"))
      )
    ),
    shiny::fluidRow(
      shiny::column(
        width = 4,
        shiny::code("names(pkg_data())"),
        shiny::verbatimTextOutput(ns("data"))
      ),
      # include for showing reactive values: ----
      shiny::column(
        width = 4,
        shiny::code("str(var_inputs())"),
        shiny::verbatimTextOutput(ns("vars"))
      ),
      shiny::column(
        width = 4,
        shiny::code("str(plot())"),
        shiny::verbatimTextOutput(ns("plot"))
      )
      # include for showing reactive values: ----
    )
  )
}

#' Scatter plot server module
#'
#' @param id module id
#' @param vars inputs from mod_var_input
#' @param df data for application
#'
#' @return shiny server module
#' @export mod_scatter_server
#'
#' @importFrom shiny NS moduleServer reactive
#' @importFrom shiny renderPlot
#' @importFrom stringr str_replace_all
#' @importFrom ggplot2 labs theme_minimal theme
mod_scatter_server <- function(id, vars, df) {

  shiny::moduleServer(id, function(input, output, session) {

    pkg_data <- shiny::reactive({
      get_pkg_data(package = df()$pkg)[[df()$ds]]
    }) |>
      shiny::bindEvent(c(df()$pkg, df()$ds))

    # include for showing reactive values: ----
    output$data <- shiny::renderPrint({
      print(names(pkg_data()),
        width = 60, max.levels = NULL
      )
    })
    # include for showing reactive values: ----

    var_inputs <- shiny::reactive({
                list(
                  x_var = vars()$x,
                  y_var = vars()$y,
                  col_var = vars()$col,
                  facet_var = vars()$facet,
                  alpha = vars()$alpha,
                  size = vars()$size)
    }) |>
      shiny::bindEvent(c(vars()$x, vars()$y,
                         vars()$col, vars()$facet,
                         vars()$alpha, vars()$size))

    # include for showing reactive values: ----
    output$vars <- shiny::renderPrint({
      print(str(var_inputs()),
        width = 40, max.levels = NULL
      )
    })
    # include for showing reactive values: ----

    # observe({
    #   plot <- shiny::reactive({
    #           gg_points_facet(
    #             df = pkg_data(),
    #             x_var = vars()$x,
    #             y_var = vars()$y,
    #             col_var = vars()$col,
    #             facet_var = vars()$facet,
    #             alpha = vars()$alpha,
    #             size = vars()$size)
    #           })
    #   }) |>
    # shiny::bindEvent(c(pkg_data(), var_inputs()))

      # # include for showing reactive values: ----
      # output$plot <- shiny::renderPrint({
      # print(str(plot()),
      #   width = 40, max.levels = NULL
      # )
      # })
      # # include for showing reactive values: ----

    # observe({
    #   output$scatterplot <- shiny::renderPlot({ plot() })
    # }) |>
    # shiny::bindEvent(plot())

  })
}


    # include for exporting values with shinytest2 ----
    # shiny::exportTestValues(
    #   app_data = app_data(),
    #   plot =  plot()
    # )

    # # safely_export (shinytest2) ----
    # # https://github.com/rstudio/shiny/issues/3768#issuecomment-1398254569
    #   safely_export <- function(r) {
    #     r_quo <- rlang::enquo(r)
    #     rlang::inject({
    #       shiny::reactive({
    #         tryCatch(
    #           !!r_quo,
    #           error = function(e) {
    #             e
    #           }
    #         )
    #       })
    #     })
    #   }
    # # include for safely exporting values with shinytest2 ----
    # shiny::exportTestValues(
    #   app_data = safely_export(app_data()),
    #   plot =  safely_export(plot())
    # )

