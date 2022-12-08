library(shiny)
source("source/P3-code/data_wrangling/tab_3_data_wrangling.R")

tab_panel_chart3 <- tabPanel(
  "Governmental Responses",
  h1("Governmental Responses of Vulnerable Nations"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "gdp_chart_options",
        label = "Disaster Category:",
        choices = tab_choices,
        selected = "Total Disasters"
      ),
      radioButtons(
        inputId = "color_gdp",
        label = "Grouping:",
        choices = list(
          "Country" = "country", "Region" = "region",
          "Continent" = "continent"
        ),
        selected = NULL
      ),
      h5(strong("Correlation Coefficient: "), textOutput(
        outputId = "gdp_correlation", inline = TRUE
      ))
    ),
    mainPanel(
      plotlyOutput(
        outputId = "gdp_chart"
      )
    )
  ),
  h3("Analysis:"),
  hr(),
  p("The scatterplot chart above shows the average percent of a nation's GDP
  that was spent on environmental protection compared to the frequency of 
  climate-related disasters experienced by that nation from 1980 to 2021. The 
  chart can be manipulated to change what kind of disasters are compared via 
  the adjacent drop-down widget. Included within the chart is the option to 
  further group a nation according to the geographic region or continent they 
  belong to."),
  tags$br(),
  p(
    "This graph was included to answer our third research question:",
    strong("How have the governments of those most affected by climate change 
           health risks responded?"),
    ". Within the chart, the governments of those most affected are identified 
  as those that have the largest disaster counts, while the response of those 
  governments is indicated by the percentage of the nation's GDP that is spent
  on environmental protection. In addition, the chart also enables grouping by
  continent or region, and the ability to subset which disasters are shown. 
  These additions further help explain how governments of those most affected 
  by climatechange health risks by showing which nations are at risk from each
  individual disaster type, which enables us to see if certain disasters evoke
  greater governmental responses."
  )
)
