library(tidyverse)
library(plotly)

climate_hazards <- read.csv(
  "data/2022_Cities_Climate_Hazards.csv",
  stringsAsFactors = FALSE
)

climate_health <- read.csv(
  "data/2021_Cities_Climate_Change_Impacts_on_Health_and_Health_Systems.csv",
  stringsAsFactors = FALSE
)

disaster_freq <- read.csv(
  "data/Climate-related_Disasters_Frequency.csv",
  stringsAsFactors = FALSE
)

climate_groups <- climate_health %>%
  rename(
    vulnerable_pop = Please.identify.which.vulnerable.populations.are.affected.by.these.climate.related.impacts
  ) %>%
  select(Country, vulnerable_pop) %>%
  mutate(vulnerable_pop = strsplit(as.character(vulnerable_pop), ";")) %>%
  unnest(vulnerable_pop) %>%
  mutate(vulnerable_pop = strsplit(as.character(vulnerable_pop), ":")) %>%
  unnest(vulnerable_pop) %>%
  mutate(vulnerable_pop = str_trim(vulnerable_pop, "left")) %>%
  count(vulnerable_pop) %>%
  filter(vulnerable_pop != "Question not applicable") %>%
  arrange(-n) %>%
  head(10)

hazard_groups <- climate_hazards %>%
  select(Country, Vulnerable.population.groups.most.exposed) %>%
  rename(vulnerable_pop = Vulnerable.population.groups.most.exposed) %>%
  mutate(vulnerable_pop = strsplit(as.character(vulnerable_pop), ";")) %>%
  unnest(vulnerable_pop) %>%
  mutate(vulnerable_pop = strsplit(as.character(vulnerable_pop), ":")) %>%
  unnest(vulnerable_pop) %>%
  mutate(vulnerable_pop = str_trim(vulnerable_pop, "left")) %>%
  count(vulnerable_pop) %>%
  filter(
    !vulnerable_pop %in% c(
      "Question not applicable",
      "Other, please specify",
      "Do not know"
    )
  ) %>%
  mutate(
    vulnerable_pop = str_replace(
      vulnerable_pop,
      "Personas que viven en viviendas de calidad inferior.",
      "People living in substandard housing"
    )
  ) %>%
  arrange(-n) %>%
  head(10)

vulnerable_chart_title <- list(
  "Climate Hazards" = "Climate Hazards (2022)",
  "Climate Health Impacts" = "Climate Health Impacts (2021)"
)
