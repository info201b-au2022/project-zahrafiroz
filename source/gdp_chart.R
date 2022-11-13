library("tidyverse")
library("ggplot2")
library("plotly")

disaster_freq <- read.csv("../data/Climate-related_Disasters_Frequency.csv",
  stringsAsFactors = FALSE
)

gov_expend <- read.csv("../data/Environmental_Protection_Expenditures.csv",
  stringsAsFactors = FALSE
)

# Find the number of climate related disasters that have affected nations.
disaster_freq_nations <- disaster_freq %>%
  filter(Indicator == "Climate related disasters frequency, Number of Disasters: TOTAL") %>%
  group_by(Country) %>%
  mutate(total_disasters = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  select(Country, total_disasters) %>%
  arrange(-total_disasters)

# Find the average percent of gdp nations spend on environmental protection.
avg_gdp_nations <- gov_expend %>%
  filter(Unit == "Percent of GDP") %>%
  group_by(Country) %>%
  summarise(sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
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
    "<br>", "Proportion of nation's GDP Spent on environmental protection: ",
    round(gdp_and_disasters$avg_gdp, 2),
    "%"
  )
) %>%
  layout(
    title = "Proportion of nation's GDP spent on environmental protection vs. 
    count of climate-related disasters occuring in nation",
    xaxis = list(
      title = "Count of climate-related disasters occuring in nation 
    (1980-2018)",
      ticksuffix = " Disasters"
    ),
    yaxis = list(
      title = "Mean proportion of nation's GDP spent on environmental protection
    (1995-2021)",
      ticksuffix = "%"
    )
  )