#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny shinyBS shinyjs
#' @noRd
app_server <- function(input, output, session) {
  shinyjs::addCssClass(id = 'testCollapse', class = "inactiveLink")
  r <- reactiveValues()
  mod_importObservations_server("importObservations_1", r = r)
  mod_generateSiteYearCurveMapInput_server("generateSiteYearCurveMapInput_1", r = r)
  mod_makePlot_server("makePlot_1", r = r)
}
