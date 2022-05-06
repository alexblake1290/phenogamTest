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
    load("data/lymantria_obs_cdd.rda")
    r$obs_data <- lymantria_obs_cdd

    output$print <- renderPrint({
      head(r$obs_data)
    })

  })
}

## To be copied in the UI
# mod_importObservations_ui("importObservations_1")

## To be copied in the server
# mod_importObservations_server("importObservations_1")
