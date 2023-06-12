source('modules.R')

demoApp <- function() {
  require(janitor)
  require(palmerpenguins)
  require(NHANES)
  shiny::shinyApp(
    ui = function() {
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
              mod_cols_ui(id = "cols"),
              # graph outputs  ----
              mod_graph_ui("plot")
            )
          )
        )
      )
    },
    server = function(input, output, session) {

      gargoyle::init("tf_ds", "tf_x", "tf_y", "tf_col",
                     "tf_facet", "tf_alpha", "tf_size",
                      "tf_plot")

      # pkg module ----
      pkg <- mod_pkg_server("pkg")

      # dataset module ----
      dataset <- mod_ds_server("ds", pkg_input = pkg)

      # column select module ----
      plot_values <- mod_cols_server(id = "cols", ds_input = dataset)

      # plot module ----
      mod_graph_server("plot",
                      ds_input = dataset,
                      col_inputs = plot_values)
    }
  )
}
demoApp()
