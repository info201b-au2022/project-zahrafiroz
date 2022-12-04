# tab_panel_chart2

library(shiny)

cities_tab <- sidebarLayout(
  sidebarPanel(
    radioButtons(
      inputId = "vulnerable_data",
      label = "Group",
      choices = list("Climate Hazards" = "Climate Hazards", "Climate Health Impacts" = "Climate Health Impacts"),
      selected = "Climate Hazards"
    )
  ),
  mainPanel(
    plotlyOutput(
      outputId = "vulnerable_chart"
    )
  )
)

country_tab <- sidebarLayout(
  sidebarPanel(
    sliderInput(
      inputId = "disaster_countries_years",
      label = "Year Range",
      min = 1980,
      max = 2018,
      value = c(1980, 2018),
      step = 5,
      ticks = TRUE,
      sep = ""
    )
  ),
  mainPanel(
    plotlyOutput(
      outputId = "disaster_countries"
    )
  )
)

tab_panel_chart2 <-tabPanel(
    "Chart 2",
    p("This is chart 2."),
    tabsetPanel(
      tabPanel("Groups Vulnerable in Cities", cities_tab),
      tabPanel("Vulnerable Nations", country_tab)),
      mainPanel(
        p("Some text here")
      )
    )


