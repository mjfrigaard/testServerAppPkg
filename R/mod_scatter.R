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
      # shiny::column(
      #   width = 6,
      #   shiny::code("mod_scatter: str(scatter_inputs()$df)"),
      #   shiny::verbatimTextOutput(ns("vars"))
      # ),
    # include for showing reactive values: ----
    shiny::column(
        width = 12,
        shiny::code("mod_scatter: str(scatter_inputs())"),
        shiny::verbatimTextOutput(ns("plot"))
      ))
  )
}

#' Scatter plot server module
#'
#' @param id module id
#' @param scatter_inputs inputs from mod_var_select
#'
#' @return shiny server module
#' @export mod_scatter_server
#'
#' @importFrom shiny NS moduleServer reactive renderPrint
#' @importFrom shiny renderPlot isolate bindEvent req
#' @importFrom stringr str_replace_all
#' @importFrom ggplot2 labs theme_minimal theme
mod_scatter_server <- function(id, scatter_inputs) {

  shiny::moduleServer(id, function(input, output, session) {

        output$scatterplot <- shiny::renderPlot({
                gg_color_scatter_facet(
                  df = scatter_inputs()$df,
                  x_var = scatter_inputs()$x_var,
                  y_var = scatter_inputs()$y_var,
                  col_var = scatter_inputs()$col_var,
                  facet_var = scatter_inputs()$facet_var,
                  alpha = scatter_inputs()$alpha,
                  size = scatter_inputs()$size)
                }) |>
          shiny::bindEvent(scatter_inputs())

      # # include for showing reactive values: ----
      # output$vars <- shiny::renderPrint({
      #     shiny::req(scatter_inputs())
      #     print(str(scatter_inputs()$df),
      #       width = 40,
      #       max.levels = NULL)
      #   })
     # include for showing reactive values: ----
      output$plot <- shiny::renderPrint({
        shiny::req(scatter_inputs())
        print(str(scatter_inputs()),
          width = 40, max.levels = NULL)
        })

  })
}
