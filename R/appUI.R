#' App UI
#'
#' @importFrom shiny tagList fluidPage sidebarLayout
#' @importFrom shiny sidebarPanel mainPanel br h4 code
#' @importFrom shiny fluidRow code verbatimTextOutput
#'
#' @export appUI
appUI <- function() {
  shiny::tagList(
    shiny::fluidPage(
      shiny::sidebarLayout(
        shiny::sidebarPanel(
          # data inputs ----
          shiny::h4(
            shiny::code("mod_data_input"), " module"),
          mod_data_input_ui("data")
        ),
        shiny::mainPanel(
          shiny::tags$br(),
          # var inputs ----
          shiny::h4(shiny::code("mod_var_input"), " module"),
          mod_var_input_ui(id = "vars"),
          # outputs  ----
          shiny::h4(shiny::code("mod_scatter"), " module"),
          mod_scatter_ui(id = "plot"),
          # include for showing reactive values: ----
          shiny::fluidRow(
            shiny::column(
              width = 6,
              shiny::h4("Reactive values in ",
                    shiny::code("appServer()")),
              shiny::verbatimTextOutput("vals")
            ))
        )
      )
    )
  )
}



