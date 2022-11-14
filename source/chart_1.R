# Load packages
library("dplyr")
library("ggplot2")
library("plotly")

# Question: How has human health been impacted?
#
# Topic: Top hazards across countries
#
#   Loading data
climate_hazards <- read.csv("../data/2022_Cities_Climate_Hazards.csv")

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
  hazards = hazards_count$Climate.related.hazards,
  number_of_occurrences = hazards_count$n
)

#   Graphing
hazards_chart <- plot_ly(
  data = hazards_count,
  labels = ~hazards,
  values = ~number_of_occurrences,
  type = "pie",
  textposition = "inside",
  textinfo = "label+percent",
  hoverinfo = "label+text",
  text = ~ paste(number_of_occurrences, "Cities Affected"),
  insidetextfont = list(color = "#FFFFFF"),
  marker = list(line = list(color = "#FFFFFF", width = 0.7)),
  showlegend = TRUE
) %>%
  layout(
    title = "Top 20 Climate Related Hazards in 2022"
  )
