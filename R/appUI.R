#' App UI
#'
#' @importFrom shiny tagList fluidPage sidebarLayout
#' @importFrom shiny sidebarPanel mainPanel br
#' @importFrom shiny fluidRow code verbatimTextOutput
#'
#' @export appUI
appUI <- function() {
  shiny::tagList(
    shiny::fluidPage(
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          # inputs placeholder
          shiny::code("inputs"),
          # inputs ----
          mod_var_input_ui(
            id = "vars",
            app_data = tibble::tibble(`integer column` = as.integer(c(1:3)),
                                      `double column` = as.double(c(4:6)),
                                      `facet 01` = c(LETTERS[1:3]),
                                      `facet 02` = c(LETTERS[1:3]),
                                      `binary` = c(TRUE, FALSE, NA)))
        ),
        shiny::mainPanel(
          shiny::tags$br(),
          # inputs placeholder
          shiny::code("outputs"),
          # outputs  ----
          mod_scatter_output_ui(id = "plot")
        )
      )
    )
  )
}
# appUI <- function() {
#   shiny::tagList(
#     shiny::fluidPage(
#       shiny::sidebarLayout(
#         shiny::sidebarPanel(
#           # inputs
#           mod_var_input_ui(
#             id = "vars",
#             app_data = palmerpenguins::penguins
#           )
#         ),
#         shiny::mainPanel(
#           shiny::tags$br(),
#           # outputs
#           mod_scatter_output_ui(id = "plot"),
#           # # include these for showing reactive values to include in tests: ----
#           # shiny::fluidRow(
#           #   shiny::code("reactive values"),
#           #   shiny::verbatimTextOutput("vals")
#           # )
#         )
#       )
#     )
#   )
# }


