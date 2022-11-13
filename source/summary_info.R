library(tidyverse)
library(dplyr)

climate_hazards <- read.csv("../data/2022_Cities_Climate_Hazards.csv", stringsAsFactors = FALSE)

climate_health <- read.csv("../data/2021_Cities_Climate_Change_Impacts_on_Health_and_Health_Systems.csv", stringsAsFactors = F)

disaster_freq <- read.csv("../data/Climate-related_Disasters_Frequency.csv", stringsAsFactors = F)

gov_expend <- read.csv("../data/Environmental_Protection_Expenditures.csv", stringsAsFactors = F)

summary_info <- list()

# Find the most frequent climate-related hazard.
summary_info$most_frequent_hazard <- climate_hazards %>%
  mutate(Climate.related.hazards = strsplit(as.character(Climate.related.hazards), ";")) %>%
  unnest(Climate.related.hazards) %>%
  mutate(Climate.related.hazards = str_trim(Climate.related.hazards, "left")) %>%
  count(Climate.related.hazards) %>%
  filter(n == max(n)) %>%
  pull(Climate.related.hazards)

# Find the most frequent climate-related health issue.
summary_info$most_frequent_health_issue <- climate_health %>%
  rename(Health_issue = Identify.the.climate.related.health.issues.faced.by.your.city) %>%
  select(Country, Health_issue) %>%
  mutate(Health_issue = strsplit(as.character(Health_issue), ";")) %>%
  unnest(Health_issue) %>%
  mutate(Health_issue = str_trim(Health_issue, "left")) %>%
  count(Health_issue) %>%
  filter(Health_issue != "Question not applicable") %>%
  filter(n == max(n)) %>%
  pull(Health_issue)

# Find the most population most frequently vulnerable from climate health issues
summary_info$most_vulnerable_health <- climate_health %>%
  rename(vulnerable_pop = Please.identify.which.vulnerable.populations.are.affected.by.these.climate.related.impacts) %>%
  select(Country, vulnerable_pop) %>%
  mutate(vulnerable_pop = strsplit(as.character(vulnerable_pop), ";")) %>%
  unnest(vulnerable_pop) %>%
  mutate(vulnerable_pop = str_trim(vulnerable_pop, "left")) %>%
  count(vulnerable_pop) %>%
  filter(vulnerable_pop != "Question not applicable") %>%
  filter(n == max(n)) %>%
  pull(vulnerable_pop)

# Find the population most frequently vulnerable from climate hazards.
summary_info$most_vulnerable_hazards <- climate_hazards %>%
  select(Country, Vulnerable.population.groups.most.exposed) %>%
  rename(vulnerable_pop = Vulnerable.population.groups.most.exposed) %>%
  mutate(vulnerable_pop = strsplit(as.character(vulnerable_pop), ";")) %>%
  unnest(vulnerable_pop) %>%
  mutate(vulnerable_pop = str_trim(vulnerable_pop, "left")) %>%
  count(vulnerable_pop) %>%
  filter(vulnerable_pop != "Question not applicable") %>%
  filter(n == max(n)) %>%
  pull(vulnerable_pop)

# Find the nation that has had the most climate-related disasters and the
# amount of disasters that affected that nation.
top_disasters <- disaster_freq %>%
  filter(Indicator == "Climate related disasters frequency, Number of Disasters: TOTAL") %>%
  group_by(Country) %>%
  mutate(disaster_sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  select(Country, disaster_sum) %>%
  as.data.frame()

summary_info$most_disasters_freq <- top_disasters %>%
  filter(disaster_sum == max(disaster_sum, na.rm = TRUE)) %>%
  pull(disaster_sum)

summary_info$most_disasters_nation <- top_disasters %>%
  filter(disaster_sum == max(disaster_sum, na.rm = TRUE)) %>%
  pull(Country)

# Find the average gdp spent on environmental protection by the ten nations
# with the most climate-related disasters.

gdp <- gov_expend %>%
  filter(Unit == "Percent of GDP") %>%
  group_by(Country) %>%
  summarise(sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  mutate(avg_gdp = sum / ncol(select(gov_expend, starts_with("F")))) %>%
  select(-sum)

summary_info$avg_gdp_ten <- left_join(gdp, top_disasters, by = "Country") %>%
  arrange(-disaster_sum) %>%
  head(10) %>%
  pull(avg_gdp) %>%
  mean(na.rm = TRUE) %>%
  round(2)

