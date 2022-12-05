# Load packages
library("dplyr")
library("ggplot2")
library("plotly")
library("tidyr")
library("tidyverse")

# Loading data
climate_hazards <- read.csv("./data/2022_Cities_Climate_Hazards.csv")
climate_health <- read.csv("./data/2021_Cities_Climate_Change_Impacts_on_Health_and_Health_Systems.csv",
  stringsAsFactors = FALSE
)

# Climate change hazards
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


# Health issues across countries
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

