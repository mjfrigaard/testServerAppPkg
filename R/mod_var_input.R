#' Import variables UI module
#'
#' @param id module id
#' @param pkg_data data for application
#'
#' @return shiny UI module
#' @export mod_var_input_ui
#'
#' @importFrom shiny NS tagList selectInput
#' @importFrom shiny sliderInput textInput
#'
mod_var_input_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::selectInput(
      inputId = ns("x"),
      label = "X variable:",
      choices = c("", NULL),
      selected = NULL
    ),
    shiny::selectInput(
      inputId = ns("y"),
      label = "Y variable:",
      choices = c("", NULL),
      selected = NULL
    ),
    shiny::selectInput(
      inputId = ns("col"),
      label = "Color variable:",
      choices = c("", NULL),
      selected = NULL
    ),
    shiny::selectInput(
      inputId = ns("facet"),
      label = "Facet variable:",
      choices = c("", NULL),
      selected = NULL
    ),
    shiny::sliderInput(
      inputId = ns("alpha"),
      label = "Point opacity:",
      min = 0, max = 1, step = 0.1,
      value = 0.5
    ),
    shiny::sliderInput(
      inputId = ns("size"),
      label = "Point size:",
      min = 0, max = 5,
      step = 0.2,
      value = 2
    ),
    ## include these for showing reactive values to include in tests:  ----
    # shiny::verbatimTextOutput(outputId = ns("return")),
    # shiny::verbatimTextOutput(outputId = ns("vals")),
    shiny::code("str(pkg_data())"),
    shiny::verbatimTextOutput(outputId = ns("data"))
  )
}


#' Import variables Server module
#'
#' @param id module id
#' @param input_data pkg data from `mod_data_input`
#'
#' @return shiny server module
#' @export mod_var_input_server
#'
#' @importFrom shiny NS moduleServer reactive
mod_var_input_server <- function(id, input_data) {

  shiny::moduleServer(id, function(input, output, session) {


    pkg_data <- shiny::reactive({
      get_pkg_data(package = input_data()$pkg)[[input_data()$ds]]
    }) |>
      shiny::bindEvent(c(input_data()$pkg,
                         input_data()$ds))

    # include for showing reactive values: ----
    output$return <- shiny::renderPrint({
      str(input_data()$pkg)
    }, width = 60) |>
      shiny::bindEvent(input_data()$pkg)
    # include for showing reactive values: ----

    # include for showing reactive values: ----
    output$vals <- shiny::renderPrint({
      str(input_data()$ds)
    }, width = 60) |>
      shiny::bindEvent(input_data()$ds)
    # include for showing reactive values: ----

    # include for showing reactive values: ----
    output$data <- shiny::renderPrint({
      str(pkg_data())
    }, width = 60) |>
      shiny::bindEvent(pkg_data())
    # include for showing reactive values: ----

    shiny::observe({
        x_nms <- num_app_inputs(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "x",
        choices = x_nms,
        selected = x_nms[1])
      }) |>
      shiny::bindEvent(pkg_data())

    shiny::observe({
        y_nms <- num_app_inputs(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "y",
        choices = y_nms,
        selected = y_nms[2])
      }) |>
      shiny::bindEvent(pkg_data())

    shiny::observe({
        col_nms <- binary_app_inputs(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "col",
        choices = col_nms,
        selected = col_nms[1])
      }) |>
      shiny::bindEvent(pkg_data())

    shiny::observe({
        facet_nms <- facet_app_inputs(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "facet",
        choices = facet_nms,
        selected = facet_nms[1])
      }) |>
      shiny::bindEvent(pkg_data())

    return(
        shiny::reactive({
          list(
            "x" = input$x,
            "y" = input$y,
            "col" = input$col,
            "facet" = input$facet,
            "alpha" = input$alpha,
            "size" = input$size,
            "plot_title" = make_plot_title(
                            x = input$x,
                            y = input$y,
                            color = input$col))
          }) |>
            shiny::bindEvent(c(input$x, input$y, input$col, input$facet,
                               input$alpha, input$size))
      )




  })
}


