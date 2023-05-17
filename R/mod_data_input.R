#' Import data UI module
#'
#' @param id module id
#'
#' @return shiny UI module
#' @export mod_data_input_ui
#'
#' @importFrom shiny NS tagList selectInput
#'
mod_data_input_ui <- function(id) {
 ns <- shiny::NS(id)
  shiny::tagList(
    shiny::selectInput(
      inputId = ns("pkg"),
      label = "Package",
      choices = c(
        "palmerpenguins", "NHANES"
      ),
      selected = "palmerpenguins"
      ),
    shiny::selectInput(
      inputId = ns("data"),
      label = "Data",
      choices = c(
        "", NULL
      ),
      selected = c(NULL)
      )
    )
}

#' Import data server module
#'
#' @param id module id
#'
#' @return shiny server module
#' @export mod_data_input_server
#'
#' @section Use:
#'
#' `input$data` includes a call to `shiny::observe()`,
#' and `shiny::bindEvent(input$pkg)` to ensure both values are
#' included in the returned object.
#'
#' @importFrom shiny NS moduleServer reactive
mod_data_input_server <- function(id) {

  shiny::moduleServer(id, function(input, output, session) {

    shiny::observe({
      pkg_data_nms <- names(get_pkg_data(package = input$pkg))
      shiny::updateSelectInput(session,
        inputId = "data",
        choices = pkg_data_nms,
        selected = pkg_data_nms[1])
      }) |>
      shiny::bindEvent(input$pkg)

    return(
      shiny::reactive({
            list(
              pkg_data = get_pkg_data(package = input$pkg)[[input$data]]
              )
            })
        )

  })
}
