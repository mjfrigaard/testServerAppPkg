#' pkgDataApp
#'
#' @return shiny app
#' @export pkgDataApp
#'
#' @importFrom shiny shinyApp fluidPage
#' @importFrom shiny sidebarLayout sidebarPanel
#' @importFrom shiny mainPanel
pkgDataApp <- function() {
    check_inst_pkg(pkg = "NHANES")
    check_inst_pkg(pkg = "palmerpenguins")
    require(palmerpenguins)
    require(NHANES)

    shiny::shinyApp(
      ui = appUI,
      server = appServer)

}
