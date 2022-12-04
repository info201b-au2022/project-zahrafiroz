
library(shiny)
library(tidyverse)
source("./data_wrangling/tab_3_data_wrangling.R")
source("./data_wrangling/tab_2_data_wrangling.R")


server <- function(input, output) {
  get_gdp_color <- reactive({
    if (input$color_gdp == "country") {
      list("blue", "cyan", "red", "yellow", "magenta", "green", "orange", "olive")
    } else {
      ~ gdp_and_disasters[, input$color_gdp]
    }
  })

  output$gdp_correlation <- renderText({
    test <- cor.test(
      gdp_and_disasters[, input$gdp_chart_options],
      gdp_and_disasters$avg_gdp
    )
    return(round(test$estimate, 3))
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
      title = "Disasters vs. Avg. GDP% Spent on Environmental Protection (1980-2018)",
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

  get_vulnerable_data <- reactive({
    if (input$vulnerable_data == "Climate Hazards") {
      data <- hazard_groups
    } else {
      data <- climate_groups
    }
    return(data)
  })

  output$vulnerable_chart <- renderPlotly({
    vulnerable_data <- get_vulnerable_data()
    plot_ly(
      data = vulnerable_data,
      type = "treemap",
      parents = c("", "", "", "", "", "", "", "", "", ""),
      labels = ~ str_wrap(vulnerable_pop, 10),
      values = ~n,
      hoverinfo = "text",
      hovertext = paste0(
        vulnerable_data$vulnerable_pop, "<br>",
        "Reported in ", format(vulnerable_data$n, big.mark = ","), " Cities"
      ),
      domain = list(column = 0)
    ) %>%
      layout(
        title = paste0("Ten Most Commonly Reported Groups Vulnerable to ", input$vulnerable_data)
      )
  })

  get_disaster_data <- reactive({
    data <- disaster_freq %>%
      filter(Indicator == "Climate related disasters frequency, Number of Disasters: TOTAL") %>%
      group_by(Country) %>%
      mutate(disaster_sum = sum(across(paste0(
        "F", input$disaster_countries_years[1]
      ):paste0(
        "F", input$disaster_countries_years[2]
      ), na.rm = TRUE))) %>%
      select(Country, disaster_sum) %>%
      arrange(-disaster_sum) %>%
      head(10) %>%
      as.data.frame()
  })

  output$disaster_countries <- renderPlotly({
    country_data <- get_disaster_data()
    plot_ly(
      data = country_data,
      x = ~disaster_sum,
      y = ~Country,
      type = "bar",
      orientation = "h",
      hoverinfo = "text",
      hovertext = paste0(
        "Country: ", country_data$Country, "<br>",
        "Climate Related Disaster Count: ", country_data$disaster_sum
      ),
      color = ~Country
    ) %>% layout(
      title = paste0(
        "Nations Most Affected by Climate-related Disasters (",
        input$disaster_countries_years[1], "-",
        input$disaster_countries_years[2], ")"
      ),
      yaxis = list(
        categoryorder = "array",
        categoryarray = rev(pull(country_data, Country))
      ),
      xaxis = list(title = "Climate-related Disaster Count", ticksuffix = "")
    )
  })
}


