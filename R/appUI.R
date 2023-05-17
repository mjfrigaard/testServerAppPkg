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
          # data inputs ----
          shiny::h4(shiny::code("mod_data_input")),
          mod_data_input_ui("data"),
          # var inputs ----
          shiny::h4(shiny::code("mod_var_input")),
          mod_var_input_ui(id = "vars")),
        shiny::mainPanel(
          shiny::tags$br(),
          # include for showing reactive values: ----
          shiny::fluidRow(
            shiny::h4(shiny::code("appServer(): reactive values")),
              shiny::verbatimTextOutput("vals")
          ),
          # include for showing reactive values: ----
          shiny::fluidRow(
              # inputs placeholder
              shiny::h4(shiny::code("mod_scatter")),
              # outputs  ----
              mod_scatter_ui(id = "plot")
            )
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
#           mod_scatter_ui(id = "plot"),
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


