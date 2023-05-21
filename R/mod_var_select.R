#' Select variables UI module
#'
#' @param id module id
#' @param pkg_data data for application
#'
#' @return shiny UI module
#' @export mod_var_select_ui
#'
#' @importFrom shiny NS tagList selectInput
#' @importFrom shiny sliderInput textInput
#'
mod_var_select_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      column(width = 6,
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
          )
        ),
      column(width = 6,
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
          )
        )
    )
    # shiny::fluidRow(
    #   column(width = 12,
    # #    ## include these for showing reactive values to include in tests:  ----
    #     shiny::code("mod_var_select: str(pkg_data())"),
    #     shiny::verbatimTextOutput(outputId = ns("return")),
    #   )
    # )
  )
}


#' Select variables Server module
#'
#' @param id module id
#' @param input_data pkg data from `mod_data_input`
#'
#' @section Use:
#' The returned list includes:
#'
#' * `df` is the same object that is stored in `pkg_data()`, which is built
#'    from the `input$pkg` and `input$ds`.
#' * `x`: the x axis variable
#' * `y`: the y axis variable
#' * `col`: the color variable
#' * `facet`: the facet variable
#' * `alpha`: the alpha (opacity) for the points
#' * `size`: the size of the points
#'
#' @return shiny server module
#' @export mod_var_select_server
#'
#' @importFrom shiny NS moduleServer reactive observe
#' @importFrom shiny bindEvent renderPrint updateSelectInput isolate observe
#'
mod_var_select_server <- function(id, input_data) {

  shiny::moduleServer(id, function(input, output, session) {

    pkg_data <- shiny::reactive({
      req(input_data())
        input_data()
        }) |>
        shiny::bindEvent(input_data(),
          ignoreNULL = TRUE, ignoreInit = FALSE)

    num_vars <- shiny::reactive({
                 req(input_data())
                pull_numeric_cols(df = pkg_data())
                }) |>
                shiny::bindEvent(input_data(),
                                 ignoreNULL = TRUE,
                                 ignoreInit = FALSE)

    col_vars <- shiny::reactive({
                  req(input_data())
                pull_binary_cols(df = pkg_data())
                }) |>
                 shiny::bindEvent(input_data(),
                                  ignoreNULL = TRUE,
                                  ignoreInit = FALSE)

    facet_vars <- shiny::reactive({
                  req(input_data())
                pull_facet_cols(df = pkg_data())
                }) |>
                 shiny::bindEvent(input_data(),
                                  ignoreNULL = TRUE,
                                  ignoreInit = FALSE)

    # # include for showing reactive values: ----
    # output$return <- shiny::renderPrint({
    #   print(str(pkg_data()),
    #     width = 60,
    #     max.levels = NULL)
    # })
    shiny::observe({
      shiny::updateSelectInput(session,
        inputId = "x",
        choices = num_vars(),
        selected = num_vars()[1])
      }) |>
      shiny::bindEvent(num_vars())

    shiny::observe({
      shiny::updateSelectInput(session,
        inputId = "y",
        choices = num_vars(),
        selected = num_vars()[2])
      }) |>
      shiny::bindEvent(num_vars())

    shiny::observe({
      shiny::updateSelectInput(session,
        inputId = "col",
        choices = col_vars(),
        selected = col_vars()[1])
      }) |>
      shiny::bindEvent(col_vars())

    shiny::observe({
      shiny::updateSelectInput(session,
        inputId = "facet",
        choices = facet_vars(),
        selected = facet_vars()[1])
      }) |>
      shiny::bindEvent(facet_vars())

      return(
          shiny::reactive({
            list(
              df = input_data(),
              x_var = input$x,
              y_var = input$y,
              col_var = input$col,
              facet_var = input$facet,
              alpha = input$alpha,
              size = input$size)
            })
          )

  })
}


