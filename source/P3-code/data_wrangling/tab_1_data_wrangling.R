library("plotly")
library("tidyverse")

disaster_freq <- read.csv(
  "./../../data/Climate-related_Disasters_Frequency.csv",
  stringsAsFactors = FALSE
)

climate_health <- read.csv(
  "./../../data/2021_Cities_Climate_Change_Impacts_on_Health_and_Health_Systems.csv",
  stringsAsFactors = FALSE
)

climate_hazards <- read.csv(
  "./../../data/2022_Cities_Climate_Hazards.csv",
  stringsAsFactors = FALSE
)

health_count <- climate_health %>%
  rename(
    health_issue =
      Identify.the.climate.related.health.issues.faced.by.your.city
  ) %>%
  mutate(health_issue = strsplit(as.character(health_issue), ";")) %>%
  unnest(health_issue) %>%
  mutate(health_issue = strsplit(as.character(health_issue), "\\(")) %>%
  unnest(health_issue) %>%
  filter(!grepl("e.g. ", health_issue)) %>%
  mutate(health_issue = str_trim(health_issue, "left")) %>%
  filter(health_issue != "Question not applicable") %>%
  count(health_issue, sort = TRUE) %>%
  mutate(dummy = "") %>%
  arrange(-n) %>%
  head(10)

health_count$health_issue <- factor(
  health_count$health_issue,
  levels = pull(health_count, health_issue)
)


hazards_count <- climate_hazards %>%
  na_if("") %>%
  na.omit() %>%
  mutate(
    Climate.related.hazards = strsplit(
      as.character(Climate.related.hazards),
      ":"
    )
  ) %>%
  unnest(Climate.related.hazards) %>%
  mutate(Climate.related.hazards = str_trim(
    Climate.related.hazards,
    "left"
  )) %>%
  na_if("Other, please specify") %>%
  na.omit("Other, please specify") %>%
  na_if("Other coastal events") %>%
  na.omit("Other coastal events") %>%
  count(Climate.related.hazards, sort = TRUE) %>%
  mutate(dummy = "") %>%
  arrange(-n) %>%
  head(10)

hazards_count$Climate.related.hazards <- factor(
  hazards_count$Climate.related.hazards,
  levels = pull(hazards_count, Climate.related.hazards)
)

disaster_count <- disaster_freq %>%
  rowwise() %>%
  mutate(disaster_sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  select(Indicator, disaster_sum) %>%
  group_by(Indicator) %>%
  summarise(category_sum = sum(disaster_sum)) %>%
  mutate(Indicator = gsub(".*:", "", Indicator)) %>%
  mutate(Indicator = str_trim(Indicator, "left")) %>%
  filter(Indicator != "TOTAL") %>%
  mutate(Indicator = paste0(Indicator, "s")) %>%
  rename("n" = category_sum) %>%
  mutate(dummy = "") %>%
  arrange(-n)

disaster_count$Indicator <- factor(
  disaster_count$Indicator,
  levels = pull(disaster_count, Indicator)
)

health_chart_data <- list(
  "health_count" = health_count,
  "hazards_count" = hazards_count,
  "disaster_count" = disaster_count
)

health_chart_y_axis <- list(
  "health_count" = "health_issue",
  "hazards_count" = "Climate.related.hazards",
  "disaster_count" = "Indicator"
)

health_chart_label <- list(
  "health_count" = "Health Issue",
  "hazards_count" = "Hazard",
  "disaster_count" = "Disaster"
)

health_chart_title <- list(
  "health_count" = "Health Issues (2021)",
  "hazards_count" = "Hazards (2022)",
  "disaster_count" = "Disasters (1980-2021)"
)
