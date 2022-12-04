# tab_panel_chart3
library(shiny)
source("./data_wrangling/tab_3_data_wrangling.R")

tab_panel_chart3 <- tabPanel(
  "Governmental Responses",
  h1("Governmental Responses of Vulnerable Nations"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "gdp_chart_options",
        label = "Disaster Category",
        choices = tab_choices,
        selected = "Total Disasters"
      ),
      radioButtons(
        inputId = "color_gdp",
        label = "Grouping",
        choices = list(
          "Country" = "country", "Region" = "region",
          "Continent" = "continent"
        ),
        selected = NULL
      ),
      p(strong("Correlation Coefficient: "), textOutput(
        outputId = "gdp_correlation", inline = TRUE
      ))
    ),
    mainPanel(
      plotlyOutput(
        outputId = "gdp_chart"
      )
    )
  ),
  p("This is chart 3.")
)

