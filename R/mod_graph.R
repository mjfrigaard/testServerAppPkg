#' Plot UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_graph_ui
#'
#' @importFrom shiny NS tagList tags column fluidRow
#' @importFrom shiny plotOutput verbatimTextOutput
mod_graph_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    # shiny::fluidRow(
    #   shiny::column(
    #     width = 12,
    #     shiny::verbatimTextOutput(outputId = ns("vals"))
    #   )
    # ),
    shiny::fluidRow(
      shiny::column(
        width = 6,
        shiny::sliderInput(
          inputId = ns("alpha"),
          label = "Point opacity:",
          min = 0, max = 1, step = 0.1,
          value = 0.7)
        ),
      shiny::column(
        width = 6,
        shiny::sliderInput(
          inputId = ns("size"),
          label = "Point size:",
          min = 0, max = 5,
          step = 0.2,
          value = 3)
        )
    ),
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::plotOutput(outputId = ns("graph"))
      )
    )
  )
}

#' Plot server module
#'
#' @param id module id
#' @param graph_inputs a `data.frame` from `mod_vars`
#'
#' @return shiny server module
#' @export mod_graph_server
#'
#' @importFrom shiny NS moduleServer reactive renderPrint
#' @importFrom shiny renderPlot isolate bindEvent req
#' @importFrom ggplot2 labs theme_minimal theme
mod_graph_server <- function(id, graph_inputs) {

  shiny::moduleServer(id, function(input, output, session) {

        output$vals <- shiny::renderPrint({
            c(input$alpha, input$size)
           }) |>
          shiny::bindEvent(graph_inputs(),
                           ignoreNULL = TRUE)

          shiny::observe({
              output$graph <- shiny::renderPlot({
                 gg_scatter_color_facet(
                     df = graph_inputs(),
                     x_var = names(graph_inputs())[1],
                     y_var = names(graph_inputs())[2],
                     col_var = names(graph_inputs())[3],
                     facet_var = names(graph_inputs())[4],
                     alpha = input$alpha,
                     size = input$size)
                })
              }) |>
             shiny::bindEvent(graph_inputs(),
                              input$alpha, input$size,
                              ignoreNULL = TRUE)

  })
}










