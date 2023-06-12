library(shiny)
require(tsap)
library(gargoyle)


# mod_pkg -----------------------------------------------------------------
mod_pkg_ui <- function(id) {
  df_pkgs <- tsap::get_pkgs_with_dfs()
  ns <- shiny::NS(id)
  shiny::tagList(
  shiny::selectInput(ns("pkg"),
    label = "Pick a package",
    choices = df_pkgs)
    )
}

mod_pkg_server <- function(id) {

  shiny::moduleServer(id, function(input, output, session) {

      shiny::reactive({
          shiny::req(c(input$pkg))
            input$pkg
        })

  })
}


# mod_ds ------------------------------------------------------------------
mod_ds_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
  shiny::selectInput(ns("dataset"),
    label = "Pick a dataset",
    choices = NULL)
    )
}

mod_ds_server <- function(id, pkg_input) {

  shiny::moduleServer(id, function(input, output, session) {
    env_vars <- new.env()

     shiny::observe({
      df_names <- get_pkg_df_names(pkg = pkg_input())
      shiny::updateSelectInput(session = session,
        inputId = "dataset",
        choices = df_names,
        selected = df_names[1])
      gargoyle::trigger("tf_ds")
    }) |>
      shiny::bindEvent(pkg_input(), ignoreNULL = TRUE)

     shiny::reactive({
          shiny::req(input$dataset, pkg_input())
                env_vars$ds <- get(x = input$dataset,
                                   pos = paste0("package:", pkg_input()))
                return(env_vars$ds)
                gargoyle::watch("tf_ds")
                }) |>
                  shiny::bindCache(c(pkg_input(), input$dataset)) |>
                  shiny::bindEvent(input$dataset)

  })
}


# mod_cols ----------------------------------------------------------------

mod_cols_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      column(
        width = 6,
        shiny::selectInput(
          inputId = ns("x"),
          label = "X variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("y"),
          label = "Y variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("col"),
          label = "Color variable:",
          choices = NULL
        ),
        shiny::selectInput(
          inputId = ns("facet"),
          label = "Facet variable:",
          choices = NULL
        )
      ),
      shiny::column(
        width = 6,
        shiny::sliderInput(
          inputId = ns("alpha"),
          label = "Point opacity:",
          min = 0, max = 1, step = 0.1,
          value = 0.7
        ),
        shiny::sliderInput(
          inputId = ns("size"),
          label = "Point size:",
          min = 0, max = 5,
          step = 0.2,
          value = 3
        )
      )
    ),
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::verbatimTextOutput(ns("vals"))
      )
    )
  )
}

mod_cols_server <- function(id, ds_input) {

  shiny::moduleServer(id, function(input, output, session) {

    env_vars <- new.env()

    pkg_data <- shiny::reactive({
                   env_vars$df <- janitor::clean_names(ds_input())
                   return(env_vars$df)
                      }) |>
                shiny::bindEvent(
                  ds_input(),
                  ignoreNULL = TRUE)

    # print pkg_data() -----
    # output$vals <- shiny::renderPrint({ pkg_data() })

    shiny::observe({
      num_vars <- tsap::pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "x",
        choices = num_vars,
        selected = num_vars[1])
      gargoyle::trigger("tf_x")
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    shiny::observe({
      num_vars <- tsap::pull_numeric_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "y",
        choices = num_vars,
        selected = num_vars[2])
      gargoyle::trigger("tf_y")
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    shiny::observe({
      col_vars <- pull_binary_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "col",
        choices = col_vars,
        selected = col_vars[1])
      gargoyle::trigger("tf_col")
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

    shiny::observe({
      facet_vars <- pull_facet_cols(df = pkg_data())
      shiny::updateSelectInput(session,
        inputId = "facet",
        choices = facet_vars,
        selected = facet_vars[1])
      gargoyle::trigger("tf_facet")
      }) |>
      shiny::bindEvent(pkg_data(),
        ignoreNULL = TRUE)

     shiny::observe({
        gargoyle::trigger("tf_alpha")
      }) |>
      shiny::bindEvent(input$alpha,
        ignoreNULL = TRUE)

     shiny::observe({
        gargoyle::trigger("tf_size")
      }) |>
      shiny::bindEvent(input$size,
        ignoreNULL = TRUE)

       return(
         shiny::reactive({
           env_vars$cols <- list(
                              x_var = input$x,
                              y_var = input$y,
                              col_var = input$col,
                              facet_var = input$facet,
                              alpha = input$alpha,
                              size = input$size
                              )
           return(env_vars$cols)
           gargoyle::watch("tf_x")
           gargoyle::watch("tf_y")
           gargoyle::watch("tf_col")
           gargoyle::watch("tf_facet")
           gargoyle::watch("tf_alpha")
           gargoyle::watch("tf_size")
          })
         )

  })
}


# mod_graph ----------------------------------------------------------------
mod_graph_ui <- function(id) {
  ns <- shiny::NS(id)
  shiny::tagList(
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::verbatimTextOutput(ns("cols"))
        )
      ),
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::verbatimTextOutput(ns("df"))
        )
      ),
    shiny::fluidRow(
      shiny::column(
        width = 12,
        shiny::plotOutput(outputId = ns("graph"))
        )
      )
  )
}

mod_graph_server <- function(id, ds_input, col_inputs) {

  shiny::moduleServer(id, function(input, output, session) {

        output$cols <- shiny::renderPrint({
          unlist(col_inputs())
        })

        output$df <- shiny::renderPrint({
          str(ds_input())
        })

        shiny::observe({
            plot_data <- list(

            )
        })

    shiny::observe({
      output$graph <- shiny::renderPlot({
        tsap::gg_color_scatter_facet(
            df = ,
            x_var = ,
            y_var = ,
            col_var = ,
            facet_var = ,
          )
          })
        }) |>
        shiny::bindEvent(c(ds_input(), col_inputs()), ignoreNULL = TRUE)


    # df <- shiny::reactive({
    #     janitor::clean_names(ds_input()) |>
    #     dplyr::select(all_of())
    #     }) |>
    #       shiny::bindEvent(ds_input())

    # cols <- shiny::reactive({
    #             col_inputs()
    #         }) |>
    #         shiny::bindEvent(col_inputs())


    # shiny::observe({
    #   output$vals <- shiny::renderPrint({ df() })
    #       }) |>
    #       shiny::bindEvent(df())



    # gargoyle::trigger("tf_df")
    #
    # gargoyle::trigger("tf_cols")


    #
    # cols <- shiny::reactive({
    #              col_inputs()
    #               }) |>
    #         shiny::bindEvent(col_inputs(),
    #           ignoreNULL = TRUE)

    # shiny::observe({
    #   output$vals <- shiny::renderPrint({
    #     list(
    #         df = janitor::clean_names(ds_input()),
    #         x_var = col_inputs()$x,
    #         y_var = col_inputs()$y,
    #         col_var = col_inputs()$col,
    #         facet_var = col_inputs()$facet,
    #         alpha = col_inputs()$alpha,
    #         size = col_inputs()$size
    #         )
    #       })
    #     }) |>
    #     shiny::bindEvent(c(ds_input(), col_inputs()), ignoreNULL = TRUE)

    # shiny::observe({
    #   output$graph <- shiny::renderPlot({
    #     tsap::gg_color_scatter_facet(
    #         df = janitor::clean_names(ds_input()),
    #         x_var = col_inputs()$x,
    #         y_var = col_inputs()$y,
    #         col_var = col_inputs()$col,
    #         facet_var = col_inputs()$facet,
    #         alpha = col_inputs()$alpha,
    #         size = col_inputs()$size)
    #       })
    #     }) |>
    #     shiny::bindEvent(c(ds_input(), col_inputs()), ignoreNULL = TRUE)

  })
}
