library("dplyr")
library("stringr")
library("ggplot2")
library("plotly")

disaster_freq <- read.csv("../data/Climate-related_Disasters_Frequency.csv", stringsAsFactors = F)

gov_expend <- read.csv("../data/Environmental_Protection_Expenditures.csv", stringsAsFactors = F)

disaster_freq_nations <- disaster_freq %>%
  filter(Indicator == "Climate related disasters frequency, Number of Disasters: TOTAL") %>%
  group_by(Country) %>%
  mutate(total_disasters = sum(across(starts_with("F")), na.rm = T)) %>%
  select(Country, total_disasters) %>%
  arrange(-total_disasters)


avg_gdp_nations <- gov_expend %>%
  filter(Unit == "Percent of GDP") %>%
  group_by(Country) %>%
  summarise(sum = sum(across(starts_with("F")), na.rm = T)) %>%
  mutate(avg_gdp = sum / ncol(select(gov_expend, starts_with("F")))) %>%
  select(-sum)

gdp_and_disasters <- left_join(avg_gdp_nations, disaster_freq_nations,
  by = "Country"
)

gdp_chart <- plot_ly(
  data = gdp_and_disasters,
  x = ~total_disasters,
  y = ~avg_gdp,
  type = "scatter",
  text = ~n,
  textposition = "auto",
  hoverinfo = "text",
  hovertext = paste0(
    gdp_and_disasters$Country,
    "<br>", "Disasters: ",
    gdp_and_disasters$total_disasters,
    "<br>", "Mean GDP Spent: ",
    round(gdp_and_disasters$avg_gdp, 2)
  )
) %>%
  layout(
    title = "Nation mean percent gdp spent on environmental protection compared to count of disasters impacting nation",
    xaxis = list(title = "Count of climate-related disasters impacting nation (1980-2018)", ticksuffix = " Disasters"),
    yaxis = list(title = "Mean percent GDP spent on environmental protection (1995-2021)", ticksuffix = "%")
  )
