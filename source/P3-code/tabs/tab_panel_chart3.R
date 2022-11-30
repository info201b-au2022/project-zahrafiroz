# tab_panel_chart3
library(shiny)
source('./data_wrangling/tab_3_data_wrangling.R')

tab_panel_chart3 <- tabPanel(
  "Chart 3",
  p("This is chart 3."),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "gdp_chart_options",
        label = "Disaster Categories",
        choices = tab_choices,
        selected = "Total Disasters"
      ),
      
      radioButtons(
        inputId = "color_gdp",
        label = "Color",
        choices = list("Country" = "country", "Region" = "region",
                       "Continent" = "continent"),
        selected = NULL
      )
    ),
    mainPanel(
      plotlyOutput(
        outputId = "gdp_chart"
      )
    )
  )
)

