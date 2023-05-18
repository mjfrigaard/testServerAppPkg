#' Scatter plot UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_scatter_ui
#'
#' @importFrom shiny NS tagList tags column fluidRow
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
    # include for showing reactive values: ----
    shiny::fluidRow(
      shiny::column(
        width = 6,
        shiny::code("mod_scatter: str(plot_data())"),
        shiny::verbatimTextOutput(ns("vars"))
      ),
    # include for showing reactive values: ----
    shiny::column(
        width = 6,
        shiny::code("mod_scatter: names(plot_data())"),
        shiny::verbatimTextOutput(ns("plot"))
      )
    )
  )
}

#' Scatter plot server module
#'
#' @param id module id
#' @param plot_data inputs from mod_var_select
#'
#' @return shiny server module
#' @export mod_scatter_server
#'
#' @importFrom shiny NS moduleServer reactive renderPrint
#' @importFrom shiny renderPlot isolate bindEvent req
#' @importFrom stringr str_replace_all
#' @importFrom ggplot2 labs theme_minimal theme
mod_scatter_server <- function(id, plot_data) {

  shiny::moduleServer(id, function(input, output, session) {

      shiny::observe({
              shiny::req(plot_data())
        output$scatterplot <- shiny::renderPlot({
              gg_color_scatter_facet(
                df = plot_data()$df,
                x_var = plot_data()$x_var,
                y_var = plot_data()$y_var,
                col_var = plot_data()$col_var,
                facet_var = plot_data()$facet_var,
                alpha = plot_data()$alpha,
                size = plot_data()$size)
          })
      }) |>
        shiny::bindEvent(plot_data(),
          ignoreNULL = TRUE, ignoreInit = TRUE)

        # include for showing reactive values: ----
        output$vars <- shiny::renderPrint({
          print(str(plot_data()$df),
            width = 40, max.levels = NULL)})

        # include for showing reactive values: ----
        output$plot <- shiny::renderPrint({
        print(names(plot_data()),
          width = 40, max.levels = NULL)})

  })
}
