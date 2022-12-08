library(shiny)
library(tidyverse)
source("source/P3-code/data_wrangling/tab_3_data_wrangling.R")
source("source/P3-code/data_wrangling/tab_2_data_wrangling.R")
source("source/P3-code/data_wrangling/tab_1_data_wrangling.R")

server <- function(input, output) {
  output$health_impact_chart <- renderPlotly({
    chart_data <- health_chart_data[[input$health_variable]]
    plot_ly(
      data = chart_data,
      x = ~dummy,
      y = ~n,
      type = "bar",
      color = ~ chart_data[[health_chart_y_axis[[input$health_variable]]]],
      hoverinfo = "text",
      hovertext = ~ paste0(
        health_chart_label[[input$health_variable]],
        ": ",
        chart_data[[health_chart_y_axis[[input$health_variable]]]],
        "<br> Frequency: ",
        format(n, big.mark = ",")
      )
    ) %>%
      layout(
        barmode = "stack",
        title = paste0(
          "<b>Top Climate Change-related ",
          health_chart_title[[input$health_variable]]
        ),
        legend = list(
          title = list(text = paste0(
            "<b>",
            health_chart_label[[input$health_variable]],
            ":"
          ))
        ),
        xaxis = list(title = ""),
        yaxis = list(
          title = paste0(
            "<b>Frequency of ",
            health_chart_label[[input$health_variable]]
          ),
          tickformat = ",d",
          categoryorder = "array",
          categoryarray =
            chart_data[[health_chart_y_axis[[input$health_variable]]]]
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
        title = paste0(
          "<b>Population Groups Most Reported as Vulnerable to ",
          vulnerable_chart_title[[input$vulnerable_data]]
        )
      )
  })

  get_disaster_data <- reactive({
    disaster_data <- disaster_freq %>%
      filter(
        Indicator == "Climate related disasters frequency, Number of Disasters: TOTAL"
      ) %>%
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
    return(disaster_data)
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
        "<b>Nations Most Affected by Climate-related Disasters (",
        input$disaster_countries_years[1], "-",
        input$disaster_countries_years[2], ")"
      ),
      legend = list(
        title = list(text = "<b>Country:")
      ),
      yaxis = list(
        categoryorder = "array",
        categoryarray = rev(pull(country_data, Country))
      ),
      xaxis = list(title = "<b>Climate-related Disaster Count", ticksuffix = "")
    )
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
      color = if (input$color_gdp != "country") {
        ~ gdp_and_disasters[, input$color_gdp]
      },
      hoverinfo = "text",
      hovertext = paste0(
        "Country: ", gdp_and_disasters$country, "<br>",
        input$gdp_chart_options, " Disasters: ",
        gdp_and_disasters[[input$gdp_chart_options]], "<br>",
        "Avg. GDP% Spent on Environmental Protection: ",
        round(gdp_and_disasters$avg_gdp, 2), "%", "<br>",
        if (input$color_gdp != "country") {
          paste0(
            str_to_title(input$color_gdp),
            ": ",
            gdp_and_disasters[[input$color_gdp]]
          )
        }
      )
    ) %>% layout(
      title = paste0(
        "<b>Disasters vs. Avg. GDP% Spent on Environmental",
        "<b>Protection (1980-2021)"
      ),
      legend = list(title = list(text = gdp_chart_legend[[input$color_gdp]])),
      xaxis = list(
        title = paste(
          "<b>Count of", str_to_title(input$gdp_chart_options),
          "Disasters Impacting Nation"
        ),
        ticksuffix = ""
      ),
      yaxis = list(
        title = "<b>Avg GDP% Spent on Environmental Protection",
        ticksuffix = ""
      )
    )
  })
}
