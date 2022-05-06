#' generateSiteYearCurve UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_generateSiteYearCurve_ui <- function(id){
  ns <- NS(id)
  tagList(
    selectInput(ns("site"),label = "Site",
                choices = list(
      `Connecticut USDA Station` = "CT_USDA",
      `Great Hollow, CT` = "Great_Hollow")
    ),
    selectInput(ns("year"), label = "Year",
                choices = list(`2018` = 2018,
                               `2019` = 2019,
                               `2020` = 2020,
                               `2021` = 2021))


  )
}

#' generateSiteYearCurve Server Functions
#'
#' @noRd
mod_generateSiteYearCurve_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    obs_data <- isolate(r$obs_data)

    toListen <- reactive({
      list(input$site, input$year)
    })

    tm <- month(today())
    td <- day(today())

    observeEvent(toListen(), {
      r$site_match <- tribble(
        ~siteid, ~latitude, ~longitude,
        "CT_USDA", 41.3840395, -72.9168159,
        "Great_Hollow", 41.4989663,-73.5298385) %>%
        filter(siteid == input$site) %>%
        mutate(date = mdy(paste(tm, td, input$year, sep = "-"))) %>%
        make_julian_year("date") %>%
        get_site_cdd_curves(ub = 120, lb = 50) %>%
        match_cdd_obs_site(obs_data, .)

      r$today_year <- mdy(paste(tm, td, input$year, sep = "-"))
    })

  })
}

## To be copied in the UI
# mod_generateSiteYearCurve_ui("generateSiteYearCurve_1")

## To be copied in the server
# mod_generateSiteYearCurve_server("generateSiteYearCurve_1")
