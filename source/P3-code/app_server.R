
library(shiny)

server <- function(input, output) {

  output$gdp_chart <- renderPlotly({
    plot_data <- get_gdp_data(input$gdp_chart_options)
    plot_ly(
      data = plot_data,
      x = ~total_disasters,
      y = ~avg_gdp,
      type = "scatter",
      mode = "markers",
      hoverinfo = "",
      hovertext = ""
    )
  })
}


