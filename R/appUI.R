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



