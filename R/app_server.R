#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny shinyBS
#' @noRd
app_server <- function(input, output, session) {
  r <- reactiveValues()
  mod_importObservations_server("importObservations_1", r = r)
  mod_generateSiteYearCurveMapInput_server("generateSiteYearCurveMapInput_1", r = r)
  mod_makePlot_server("makePlot_1", r = r)
}
