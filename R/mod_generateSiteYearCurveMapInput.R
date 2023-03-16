#' generateSiteYearCurveMapInput UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import leaflet
mod_generateSiteYearCurveMapInput_ui <- function(id){
  ns <- NS(id)
  tagList(
    selectInput(ns("year"), label = "Year",
                choices = list(`2018` = 2018,
                               `2019` = 2019,
                               `2020` = 2020,
                               `2021` = 2021)),
    leafletOutput(ns('map'), width = "100%")
  )
}

#' generateSiteYearCurveMapInput Server Functions
#'
#' @noRd
#' @import leaflet
mod_generateSiteYearCurveMapInput_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    obs_data <- isolate(r$obs_data)

    output$map <- renderLeaflet({
      leaflet(options = leafletOptions(minZoom = 9)) %>%
        setView(lat = 41.3840395, lng = -72.9168159, zoom = 9) %>%
        addTiles() %>%
        addMarkers(-73.5298385, 41.4989663,
                   group = "starting_point", label = "Great Hollow") %>%
        setMaxBounds( lng1 = -73.816265
                      , lat1 = 40.944817
                      , lng2 = -71.737432
                      , lat2 = 42.154837 )
    })

    observe({
      click = input$map_click
      leafletProxy(ns("map"), session = session) %>%
        clearGroup("click_point") %>%
        addMarkers(click$lng, click$lat, label = "Clicked Point", group = "click_point")
    }) %>%
      bindEvent(input$map_click)

    toListen <- reactive({
      list(input$site, input$year, input$map_click)
    })

    tm <- month(today())
    td <- day(today())

    observeEvent(toListen(), {

      if(!is.null(input$map_click)){
        site <- tribble(
          ~siteid, ~latitude, ~longitude,
          "clicked", input$map_click$lat, input$map_click$lng
        )
      } else {
        site <- tribble(
          ~siteid, ~latitude, ~longitude,
          "CT_USDA", 41.3840395, -72.9168159,
          "Great_Hollow", 41.4989663,-73.5298385
        ) %>%
          filter(siteid == "Great_Hollow")
      }

      r$site_match <- site %>%
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
