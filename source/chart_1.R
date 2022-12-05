# Load packages
library("dplyr")
library("ggplot2")
library("plotly")
library("tidyr")
library("tidyverse")

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
  select(Country, Climate.related.hazards) %>%
  na_if("") %>%
  na.omit() %>%
  mutate(Climate.related.hazards = strsplit(as.character(Climate.related.hazards), ":")) %>%
  unnest(Climate.related.hazards) %>%
  mutate(Climate.related.hazards = str_trim(Climate.related.hazards, "left")) %>%
  na_if("Other, please specify") %>%
  na.omit("Other, please specify") %>%
  na_if("Other coastal events") %>%
  na.omit("Other coastal events") %>%
  group_by(Country, Climate.related.hazards) %>%
  count(Climate.related.hazards, sort = TRUE) %>%
  filter(n > 3) %>%
  arrange(by = Country, Climate.related.hazards)


#   Graphing hazards
hazards_chart <- plot_ly(
  data = hazards_count,
  x = ~Country,
  y = ~n,
  color = ~Climate.related.hazards,
  type = "bar",
  text = ~Country,  
  hoverinfo = "text",
  hovertext = ~paste("Hazard:", Climate.related.hazards,
                "<br> Frequency:", n)
) %>%
  layout(
    barmode = "stack",
    title = "Climate Related Hazards in Countries",
    xaxis = list(title = "Country"),
    yaxis = list(title = "Frequency of Hazards"),
    legend = list(title = list(text = "Types of Hazards"))
  )

print(hazards_chart)


# Health issues across countries
climate_health <- read.csv("../data/2021_Cities_Climate_Change_Impacts_on_Health_and_Health_Systems.csv", stringsAsFactors = FALSE)

issues_count <- climate_health %>%
  rename(health_issue = Identify.the.climate.related.health.issues.faced.by.your.city) %>%
  select(Country, health_issue) %>%
  mutate(health_issue = strsplit(as.character(health_issue), ";")) %>%
  unnest(health_issue) %>%
  mutate(health_issue = str_trim(health_issue, "left")) %>%
  filter(health_issue != "Question not applicable") %>%
  group_by(Country, health_issue) %>%
  count(health_issue, sort = TRUE) %>%
  filter(n > 3) %>%
  arrange(by = Country, -n)


# Graphing
health_chart <- plot_ly(
  data = issues_count,
  x = ~Country,
  y = ~n,
  color = ~health_issue,
  type = "bar",
  text = ~Country,  
  hoverinfo = "text",
  hovertext = ~paste("Health Issue:", health_issue,
                     "<br> Frequency:", n)
) %>%
  layout(
    barmode = "stack",
    title = "Climate Related Health Issues in Countries",
    xaxis = list(title = "Country"),
    yaxis = list(title = "Frequency of Issues")
  ) 

print(health_chart)
