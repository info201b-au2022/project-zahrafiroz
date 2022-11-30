
library(shiny)

server <- function(input, output) {

  output$gdp_chart <- renderPlotly({
    plot_data <- gdp_and_disasters
    plot_ly(
      data = plot_data,
      x = ~plot_data[, input$gdp_chart_options],
      y = ~avg_gdp,
      type = "scatter",
      mode = "markers",
      hoverinfo = "text",
      hovertext = paste0(plot_data$country, "<br>",
                         plot_data[[input$gdp_chart_options]])
    )
  })
}


