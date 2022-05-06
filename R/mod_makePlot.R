#' makePlot UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @import ggplot2
mod_makePlot_ui <- function(id){
  ns <- NS(id)
  tagList(
    plotOutput(ns("plot"))

  )
}

#' makePlot Server Functions
#'
#' @noRd
#' @import ggplot2
#' @import ggtext
mod_makePlot_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    base_font_size <- 12

    mytheme <- theme_minimal() +
      theme(text = element_text(family = "Lato",
                                size = base_font_size),
            axis.title = element_text(size = base_font_size*1.2,
                                      family = "Lato"),
            plot.subtitle = element_markdown(size = base_font_size*1.4,
                                             family = "Lato-LightItalic"),
            axis.text.y = element_blank(),
            axis.ticks.y = element_blank(),
            plot.title = element_markdown(family = "Open Sans Bold",
                                          size = base_font_size*1.4^2),
            legend.title = element_text(size = base_font_size*1.2,
                                        family = "Lato"))

    theme_set(mytheme)

    output$plot <- renderPlot({

        ggplot(r$site_match, aes(x = site_date_match)) +
        geom_density(bw = "SJ") +
        scale_x_date(date_breaks = "1 month", date_labels = "%b") +
        geom_vline(xintercept = r$today_year,
                   lty = 3, color = "#FF0000", size = 0.8) +
        labs(x = "Site Date", y = "Estimated Observation Density",
             title = paste("Estimated", year(r$today_year), "*Lymantria dispar* densities"),
             subtitle = paste("Data from iNaturalist and Daymet.<br><span style='color:#FF0000;'>Red line</span> is today's date in", year(r$today_year)))

    })

  })
}

## To be copied in the UI
# mod_makePlot_ui("makePlot_1")

## To be copied in the server
# mod_makePlot_server("makePlot_1")
