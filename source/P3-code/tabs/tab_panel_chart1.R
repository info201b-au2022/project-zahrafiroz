# tab_panel_chart1

library(shiny)

tab_panel_chart1 <-tabPanel(
    "Health Impacts",
    h1("Climate Change-related Health Impacts"),
    sidebarLayout(
      sidebarPanel(
        radioButtons(
          inputId = "health_variable",
          label = "Variable",
          choices = list(
            "Health Issues" = "health_count", "Hazards" = "hazards_count",
            "Climate Disasters" = "continent"
          ),
          selected = "health_count"
        )),
      mainPanel(
        plotlyOutput(
          outputId = "health_impact_chart"
        )
      )
    ),
    p("This is chart 3.")
)



