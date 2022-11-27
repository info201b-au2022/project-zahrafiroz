# tab_panel_chart3
library("tidyverse")
library("ggplot2")
library("plotly")
library(countrycode)
library(shiny)

disaster_freq <- read.csv("../../data/Climate-related_Disasters_Frequency.csv",
                          stringsAsFactors = FALSE
)

gov_expend <- read.csv("../../data/Environmental_Protection_Expenditures.csv",
                       stringsAsFactors = FALSE
)

tab_panel_chart3 <-tabPanel(
    "Chart 3",
    p("This is chart 3."), 
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "gdp_chart_options",
          label = "Subset",
          choices = list("Countries" = "Country", "Regions" = "region", "Continents" = "continent"),
          selected = "Countries"
        )
      ),
      
      mainPanel(
        plotlyOutput(
          outputId = "gdp_chart"
        )
      )
    )
)

#Actual code, not sure if this is meant to be here
  


# Find the number of climate related disasters that have affected nations.
disaster_freq_nations <- disaster_freq %>%
  filter(Indicator == "Climate related disasters frequency, Number of Disasters: TOTAL") %>%
  group_by(ISO3) %>%
  mutate(total_disasters = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  select(ISO3, total_disasters) %>%
  arrange(-total_disasters)

# Find the average percent of gdp nations spend on environmental protection.
avg_gdp_nations <- gov_expend %>%
  filter(Unit == "Percent of GDP") %>%
  group_by(ISO3) %>%
  summarise(sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  mutate(avg_gdp = sum / ncol(select(gov_expend, starts_with("F")))) %>%
  select(-sum)

gdp_and_disasters <- left_join(avg_gdp_nations, disaster_freq_nations,
                               by = "ISO3"
)

gdp_and_disasters <- gdp_and_disasters %>% 
  as.data.frame()

gdp_and_disasters$region <- countrycode(sourcevar = gdp_and_disasters[, "ISO3"],
                                        origin = "iso3c",
                                        destination = "region23")

gdp_and_disasters$Country <- countrycode(sourcevar = gdp_and_disasters[, "ISO3"],
                                         origin = "iso3c",
                                         destination = "country.name")

gdp_and_disasters$continent <- countrycode(sourcevar = gdp_and_disasters[, "ISO3"],
                                           origin = "iso3c",
                                           destination = "continent")

get_gdp_data <- function(input_group) {
  plot_data <- gdp_and_disasters %>%
    group_by(.dots=input_group) %>% 
    summarize(avg_gdp = mean(avg_gdp, na.rm = TRUE), total_disasters = sum(total_disasters, na.rm = TRUE))
  return(as.data.frame(plot_data))
}

