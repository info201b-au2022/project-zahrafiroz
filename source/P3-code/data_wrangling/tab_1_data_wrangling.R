library("plotly")
library("tidyverse")

health_count <- climate_health %>%
  rename(health_issue = Identify.the.climate.related.health.issues.faced.by.your.city) %>%
  mutate(health_issue = strsplit(as.character(health_issue), ";")) %>%
  unnest(health_issue) %>%
  mutate(health_issue = strsplit(as.character(health_issue), "\\(")) %>%
  unnest(health_issue) %>%
  filter(!grepl("e.g. ",health_issue))%>%
  mutate(health_issue = str_trim(health_issue, "left")) %>%
  filter(health_issue != "Question not applicable") %>%
  count(health_issue, sort = TRUE) %>%
  mutate(dummy = "") %>%
  arrange(-n) %>% 
  head(10)

health_count$health_issue <- factor(issues_count$health_issue, levels = pull(issues_count, health_issue))


hazards_count <- climate_hazards %>%
  na_if("") %>%
  na.omit() %>%
  mutate(Climate.related.hazards = strsplit(as.character(Climate.related.hazards), ":")) %>%
  unnest(Climate.related.hazards) %>%
  mutate(Climate.related.hazards = str_trim(Climate.related.hazards, "left")) %>%
  na_if("Other, please specify") %>%
  na.omit("Other, please specify") %>%
  na_if("Other coastal events") %>%
  na.omit("Other coastal events") %>%
  count(Climate.related.hazards, sort = TRUE) %>%
  mutate(dummy = "") %>%
  arrange(-n) %>% 
  head(10)

hazards_count$Climate.related.hazards <- factor(hazards_count$Climate.related.hazards, levels = pull(hazards_count, Climate.related.hazards))

health_chart_data <- list("health_count" = health_count, "hazards_count" = hazards_count)

health_chart_y <- list("health_count" = "health_issue", "hazards_count" = "Climate.related.hazards")

health_chart_label <- list("health_count" = "Health Issue", "hazards_count" = "Hazard")
