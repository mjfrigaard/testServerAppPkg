#' runShinyApp
#'
#' @return shiny app
#' @export runShinyApp
#'
#' @importFrom shiny shinyApp fluidPage
#' @importFrom shiny sidebarLayout sidebarPanel
#' @importFrom shiny mainPanel
runShinyApp <- function() {

    shiny::shinyApp(
      ui = appUI,
      server = appServer)

}
# runShinyApp <- function(testing = FALSE) {
#   if (isTRUE(testing)) {
#     shiny::shinyApp(
#       ui = appUI, server = appServer,
#       options = list("test.mode" = TRUE)
#     )
#   } else {
#     shiny::shinyApp(ui = appUI, server = appServer)
#   }
# }
