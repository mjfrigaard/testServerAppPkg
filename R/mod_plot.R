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
      shiny::column(
        width = 12,
        shiny::plotOutput(outputId = ns("graph"))
        )
      )
    # # include for showing reactive values: ----
    # shiny::fluidRow(
    #   shiny::column(
    #       width = 12,
    #       shiny::code("mod_plot: str(plot_inputs())"),
    #       shiny::verbatimTextOutput(ns("plot"))
    #     )
    #   )
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
#' @importFrom stringr str_replace_all
#' @importFrom ggplot2 labs theme_minimal theme
mod_plot_server <- function(id, plot_inputs) {

  shiny::moduleServer(id, function(input, output, session) {

       plot <- shiny::reactive({
                gg_color_scatter_facet(
                  df = plot_inputs()$df,
                  x_var = plot_inputs()$x_var,
                  y_var = plot_inputs()$y_var,
                  col_var = plot_inputs()$col_var,
                  facet_var = plot_inputs()$facet_var,
                  alpha = plot_inputs()$alpha,
                  size = plot_inputs()$size)
        }) |>
         shiny::bindEvent(plot_inputs(),
           ignoreNULL = TRUE)

        output$graph <- shiny::renderPlot({ plot() }) |>
                        shiny::bindCache(plot_inputs(), plot()) |>
                        shiny::bindEvent(plot(),
                                         ignoreNULL = TRUE,
                                         ignoreInit = TRUE)

     # # include for showing reactive values: ----
     #  output$plot <- shiny::renderPrint({
     #    shiny::req(plot_inputs())
     #    print(str(plot_inputs()),
     #      width = 40, max.levels = NULL)
     #    })

  })
}










