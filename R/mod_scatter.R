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
        width = 8,
        shiny::code("mod_scatter: names(var_inputs())"),
        shiny::verbatimTextOutput(ns("vars"))
      ),
    # include for showing reactive values: ----
    shiny::column(
        width = 4,
        shiny::code("mod_scatter: class(plot())"),
        shiny::verbatimTextOutput(ns("plot"))
      )
    )
  )
}

#' Scatter plot server module
#'
#' @param id module id
#' @param plot_data inputs from mod_var_input
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

      plot <- shiny::reactive({
                gg_color_scatter_facet(
                        df = plot_data()$df,
                        x_var = plot_data()$x,
                        y_var = plot_data()$y,
                        col_var = plot_data()$col,
                        facet_var = plot_data()$facet,
                        alpha =  plot_data()$alpha,
                        size = plot_data()$size)}) |>
                      shiny::bindEvent(
                        c(plot_data()$df,
                          plot_data()$x, plot_data()$y,
                          plot_data()$col, plot_data()$facet,
                          plot_data()$alpha, plot_data()$size),
                          ignoreNULL = TRUE)

        # include for showing reactive values: ----
        output$vars <- shiny::renderPrint({
          print(names(plot()),
            width = 40, max.levels = NULL)})


        # include for showing reactive values: ----
        output$plot <- shiny::renderPrint({
        print(class(plot()),
          width = 40, max.levels = NULL)})

      shiny::observe({
        output$scatterplot <- shiny::renderPlot({
          shiny::req(plot())
              plot()
          })
      }) |>
        shiny::bindEvent(plot(),
          ignoreNULL = TRUE, ignoreInit = FALSE)

  })
}
