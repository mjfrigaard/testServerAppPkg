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
          # pkg input ----
          shiny::h4(
            shiny::code("pkg input"), " module"),
          mod_pkg_ui("pkg"),
          # dataset input  ----
            shiny::h4(
              shiny::code("dataset input"), " module"),
          mod_dataset_ui("ds"),
        ),
        shiny::mainPanel(
          shiny::tags$br(),
          # column inputs ----
          shiny::h4(shiny::code("column select"), " module"),
          mod_cols_ui(id = "cols"),
          # plot outputs  ----
          shiny::h4(shiny::code("scatter plot"), " module"),
          mod_plot_ui("plot")
        )
      )
    )
  )
}



