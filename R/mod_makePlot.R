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
    plotOutput(ns("plot"), width = "95%")

  )
}

#' makePlot Server Functions
#'
#' @noRd
#' @import ggplot2
#' @import ggtext showtext sysfonts
mod_makePlot_server <- function(id, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns

    base_font_size <- 4

    sysfonts::font_add_google("Lexend Deca", "LexendDecaSemiBold", regular.wt = 600)
    sysfonts::font_add_google("Lexend Deca", "LexendDecaThin", regular.wt = 200)
    sysfonts::font_add_google("Lexend Deca", "LexendDecaLight", regular.wt = 400)
    sysfonts::font_add_google("Roboto Condensed", "RobotoCondensed")
    showtext::showtext_auto()
    showtext::showtext_opts(dpi = 300)

    mytheme <- theme_minimal() +
      theme(text = element_text(family = "RobotoCondensed",
                                size = base_font_size,
                                colour = "#ffffff"),
            axis.title = element_text(size = base_font_size*1.1,
                                      family = "LexendDecaLight"),
            plot.subtitle = element_markdown(size = base_font_size*1.4,
                                             family = "LexendDecaThin"),
            axis.text.x = element_text(family = "RobotoCondensed",
                                       colour = "#ffffff",
                                       size = base_font_size*0.9),
            axis.text.y = element_blank(),
            axis.ticks.y = element_blank(),
            plot.title = element_markdown(family = "LexendDecaSemiBold",
                                          size = base_font_size*1.4^2),
            legend.title = element_text(size = base_font_size*1.2,
                                        family = "RobotoCondensed"),
            plot.background = element_rect(fill="#1b2724", colour="#1b2724"),
            panel.border = element_rect(fill=NA,colour="#ffffff",size=0.5),
            panel.grid.major = element_line(colour = "grey",size=0.1),
            panel.grid.minor = element_line(colour = "grey",size=0.1)
            )

    theme_set(mytheme)

    output$plot <- renderPlot({

        ggplot(r$site_match, aes(x = site_date_match)) +
        #geom_density(bw = "SJ-dpi") +
        geom_density(bw = "bcv", color = "#ffffff", size=1.3) +
        #geom_histogram() +
        scale_x_date(date_breaks = "1 month", date_labels = "%b") +
        geom_vline(xintercept = r$today_year,
                   lty = 3, color = "#6eb39c", size = 0.8) +
        labs(x = "\nSite Date", y = "Estimated Observation Density",
             title = paste("Estimated", year(r$today_year), "*Lymantria dispar* densities"),
             subtitle = paste("Data from iNaturalist and Daymet.<br><span style='color:#6eb39c;'>Teal line</span> is today's date in", year(r$today_year)))

    },
    execOnResize = TRUE)

  })
}

## To be copied in the UI
# mod_makePlot_ui("makePlot_1")

## To be copied in the server
# mod_makePlot_server("makePlot_1")
