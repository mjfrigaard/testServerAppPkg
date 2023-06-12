#' Plot UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_plot_ui
#'
#' @importFrom shiny NS tagList tags column fluidRow
#' @importFrom shiny plotOutput verbatimTextOutput
mod_plot_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(width = 12,
        shiny::plotOutput(outputId = ns("graph")
          )
        )
      )
    )
}

#' Plot server module
#'
#' @param id module id
#' @param cols columns from `mod_cols`
#' @param df `data.frame` from `mod_ds`
#'
#' @return shiny server module
#' @export mod_plot_server
#'
#' @importFrom shiny NS moduleServer reactive renderPrint
#' @importFrom shiny renderPlot isolate bindEvent req
#' @importFrom ggplot2 labs theme_minimal theme
mod_plot_server <- function(id, plot_inputs) {

  shiny::moduleServer(id, function(input, output, session) {

       shiny::observe({
           output$graph <- shiny::renderPlot({
              gg_color_scatter_facet(
                  df = plot_inputs()$df,
                  x_var = plot_inputs()$x_var,
                  y_var = plot_inputs()$y_var,
                  col_var = plot_inputs()$col_var,
                  facet_var = plot_inputs()$facet_var,
                  alpha = plot_inputs()$alpha,
                  size = plot_inputs()$size)
             })
       }) |>
          shiny::bindEvent(plot_inputs(),
                           ignoreNULL = TRUE)

  })
}










