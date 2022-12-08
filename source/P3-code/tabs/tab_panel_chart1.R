library(shiny)

tab_panel_chart1 <- tabPanel(
  "Health Effects",
  h1("The Health Effects of Climate Change"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "health_variable",
        label = "Variable:",
        choices = list(
          "Health Issues" = "health_count", "Hazards" = "hazards_count",
          "Climate Disasters" = "disaster_count"
        ),
        selected = "health_count"
      )
    ),
    mainPanel(
      plotlyOutput(
        outputId = "health_impact_chart"
      )
    )
  ),
  h3("Analysis:"),
  hr(),
  p("The stacked bar chart above shows the ten most commonly reported climate 
  change-related health issues, climate change-related health hazards, or the 
  frequency of climate change-related disasters."),
  tags$br(),
  p("These charts were created to answer our first research question: ",
    strong("How has human health been impacted as a result of environmental
  shifts caused by climate change?"), "The chart helps answer this question by 
  displaying what health issues, hazards, or disasters brought on or exacerbated
  by climate change are most frequent. By showing the frequency of climate 
  change-related health issues, hazards, and disasters, the graph reveals the 
  main impacts of climate change on human health. After finding the main 
  impacts, we can then use them as a measure of the ways that human health has 
  been impacted due to the shifts caused by climate change."
  )
)
