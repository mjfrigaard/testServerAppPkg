#' App UI
#'
#' @importFrom shiny tagList fluidPage sidebarLayout
#' @importFrom shiny sidebarPanel mainPanel br h3 h4 code
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
          mod_data_input_ui("data"),
          # var inputs ----
          shiny::h4(shiny::code("mod_var_input"), " module"),
          mod_var_input_ui(id = "vars")
        ),
        shiny::mainPanel(
          shiny::tags$br(),
          # include for showing reactive values: ----
          shiny::fluidRow(
            shiny::column(
              width = 6,
              shiny::h3("Reactive values in ",
                    shiny::code("appServer()")),
              shiny::verbatimTextOutput("vals")
            )
          ),
            shiny::h3(
              shiny::code("mod_scatter"), " module"),
            # outputs  ----
            mod_scatter_ui(id = "plot")
        )
      )
    )
  )
}



