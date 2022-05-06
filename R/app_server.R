#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  r <- reactiveValues()
  mod_importObservations_server("importObservations_1", r = r)
  mod_generateSiteYearCurve_server("generateSiteYearCurve_1", r = r)
  mod_makePlot_server("makePlot_1", r = r)
}
