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
          mod_pkg_ui("pkg"),
          # dataset input  ----
          mod_ds_ui("ds")
        ),
        shiny::mainPanel(
          shiny::tags$br(),
          # column inputs ----
          # mod_cols_ui(id = "cols"),
          mod_vars_ui(id = "vars"),
          # plot outputs  ----
          # mod_plot_ui("plot")
          mod_graph_ui("graph")
        )
      )
    )
  )
}



