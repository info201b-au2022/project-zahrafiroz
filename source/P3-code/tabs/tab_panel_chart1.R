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
            "Climate Disasters" = "disaster_count"
          ),
          selected = "health_count"
        )),
      mainPanel(
        plotlyOutput(
          outputId = "health_impact_chart"
        )
      )
    ), h3("Analysis:"), 
    p("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
)



