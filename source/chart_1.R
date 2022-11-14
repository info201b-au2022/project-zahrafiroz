# Load packages
library("dplyr")
library("ggplot2")
library("plotly")

# Question: How has human health been impacted?
#
# Topic: Top hazards across countries
# 
#   Loading data
climate_hazards <- read.csv("~/Documents/info201/project-zahrafiroz/data/2022_Cities_Climate_Hazards.csv")

#   Narrowing down columns
climate_hazards <- climate_hazards %>%
  select(Country, Climate.related.hazards)

#   Count of hazards
hazards_count <- climate_hazards %>%
  select(Climate.related.hazards) %>%
  count(Climate.related.hazards) %>%
  na_if("") %>%
  na.omit() %>%
  arrange(by = -n) %>%
  top_n(20)

hazards_count <- data.frame(
  hazards=hazards_count$Climate.related.hazards,
  number_of_occurences=hazards_count$n
)

#   Graphing
plot_ly(
  data = hazards_count,
  y = ~reorder(hazards, number_of_occurences),
  x = ~number_of_occurences,
  type = "bar",
  hovertext = ""
) %>%
  layout(
    title = "Top 20 Climate Related Hazard Occurences in 2022",
    yaxis = list(title = "Types of Hazards"),
    xaxis = list(title = "Number of Occurences")
  ) 

