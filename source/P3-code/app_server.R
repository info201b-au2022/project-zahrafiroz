
library(shiny)
library(tidyverse)
source("./data_wrangling/tab_3_data_wrangling.R")


server <- function(input, output) {

  get_gdp_color <- reactive({
    if(input$color_gdp == "country") {
      list("blue", "cyan", "red", "yellow", "magenta", "green", "orange", "olive")
    } else {
      ~gdp_and_disasters[, input$color_gdp]
    }
  })
  
  output$gdp_chart <- renderPlotly({
    plot_ly(
      data = gdp_and_disasters,
      x = ~ gdp_and_disasters[, input$gdp_chart_options],
      y = ~avg_gdp,
      type = "scatter",
      mode = "markers",
      color = get_gdp_color(),
      hoverinfo = "text",
      hovertext = paste0(
        "Country: ", gdp_and_disasters$country, "<br>",
        input$gdp_chart_options, " Disasters: ",
        gdp_and_disasters[[input$gdp_chart_options]], "<br>",
        "Avg. GDP% Spent on Environmental Protection: ",
        round(gdp_and_disasters$avg_gdp, 2), "%", "<br>",
        if (input$color_gdp != "country") {
          paste0(str_to_title(input$color_gdp), ": ", gdp_and_disasters[[input$color_gdp]])
        }
      )
    ) %>% layout(
      title = "Disasters vs. Avg. GDP% Spent on Environmental Protection (1980-2021)",
      xaxis = list(
        title = paste(
          "Count of", str_to_title(input$gdp_chart_options),
          "Disasters Impacting Nation"
        ),
        ticksuffix = ""
      ),
      yaxis = list(
        title = "Avg GDP% Spent on Environmental Protection",
        ticksuffix = ""
      )
    )
  })
}


