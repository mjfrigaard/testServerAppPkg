

appUI <- function() {
  shiny::tagList(shiny::fluidPage(
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::code("input module")
      ),
      shiny::mainPanel(
        br(),
        shiny::code("display module")
        )
      )
    )
  )
}

appServer <- function(input, output, session) {

}

pkgDataApp() <- function() {
  shiny::shinyApp(ui = appUI, server = appServer)
}
