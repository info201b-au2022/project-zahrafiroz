library(shiny)

cities_tab <- sidebarLayout(
  sidebarPanel(
    radioButtons(
      inputId = "vulnerable_data",
      label = "Variable:",
      choices = list(
        "Climate Health Impacts" = "Climate Health Impacts",
        "Climate Hazards" = "Climate Hazards"
      ),
      selected = "Climate Health Impacts"
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
      label = "Year Range:",
      min = 1980,
      max = 2021,
      value = c(1980, 2021),
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

tab_panel_chart2 <- tabPanel(
  "Vulnerable Groups",
  h1("Groups Most Vulnerable to Climate Change Related Impacts"),
  tabsetPanel(
    tabPanel("Groups Vulnerable in Cities", cities_tab),
    tabPanel("Vulnerable Nations", country_tab)
  ),
  h3("Analysis:"),
  hr(),
  p("The above treemaps display the groups of city populations that were most
    reported to be vulnerable to climate change-related health hazards in 2022 
    or the groups of city populations that were most reported to be vulnerable 
    to climate change-related health impacts in 2021. Alternatively, the graph 
    under the second panel shows the nations that experienced the most 
    climate-related disasters in a given timeframe between 1980 to 2021."),
  tags$br(),
  p("These charts were included to demonstrate the findings of our research 
    on our second question:", strong("Which groups are most affected by the 
    health risks posed by climate change?"), ". The treemaps help to answer 
    which groups are most affected by the health risks posed by climate change
    by displaying the top ten groups that were most frequently reported by 
    cities as threatened by climate change-related health risks or climate 
    change-related health hazards. The bar chart in the second tab helps 
    further identify the affected groups by showing the ten nations that 
    experienced the most climate change-related disasters from 1980 to 2021. 
    These groupings cumulatively provide a satisfactory understanding of the 
    groups most affected by the health risks posed by climate change and 
    additionally enable us to explore how the governments of those groups 
    have responded to their citizen's vulnerability.")
)
