#' importObservations UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_importObservations_ui <- function(id){
  ns <- NS(id)
  tagList(
    verbatimTextOutput(ns("print"))
  )
}

#' importObservations Server Functions
#'
#' @noRd
mod_importObservations_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    r$obs_data <- lymantria_obs_cdd
    # technically this lymantria data object is visible to all functions, since it's internal data
    # however, doing things this way means this could be a call to a DB later

  })
}

## To be copied in the UI
# mod_importObservations_ui("importObservations_1")

## To be copied in the server
# mod_importObservations_server("importObservations_1")
