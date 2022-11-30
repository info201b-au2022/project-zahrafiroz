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

tab_choices <- list("Total Disasters" = "TOTAL", "Droughts" = "Drought",
                    "Wildfires" = "Wildfire", "Floods" = "Flood",
                    "Extreme Temp. Events" = "Extreme temperature",
                    "Storms" = "Storm", "Landslides" = "Landslide")


tab_panel_chart3 <- tabPanel(
  "Chart 3",
  p("This is chart 3."),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "gdp_chart_options",
        label = "Disaster Categories",
        choices = tab_choices,
        selected = "Total Disasters"
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
  group_by(ISO3, Indicator) %>% 
  mutate(sum = sum(across(starts_with("F")), na.rm = TRUE)) %>% 
  spread(key = Indicator, value = sum) %>% 
  group_by(ISO3) %>% 
  summarize(across(starts_with("Climate related"), sum, na.rm=T)) %>% 
  rename_with(~gsub(".*: ", "", .), starts_with("Climate related"))

# Find the average percent of gdp nations spend on environmental protection.
avg_gdp_nations <- gov_expend %>%
  filter(Unit == "Percent of GDP") %>%
  group_by(ISO3) %>%
  summarise(sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  mutate(avg_gdp = sum / ncol(select(gov_expend, starts_with("F")))) %>%
  select(-sum)

gdp_and_disasters <- left_join(avg_gdp_nations, testing, by = "ISO3") %>% 
  filter(ISO3 != "") %>% 
  mutate(across(where(is.numeric), replace_na, 0)) %>% 
  as.data.frame()

gdp_and_disasters$country <- countrycode(sourcevar = gdp_and_disasters[, "ISO3"],
                                         origin = "iso3c",
                                         destination = "country.name")




  
