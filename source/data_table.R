library("tidyverse")
library("countrycode")

climate_hazards <- read.csv("../data/2022_Cities_Climate_Hazards.csv",
  stringsAsFactors = FALSE
)

climate_health <- read.csv("../data/2021_Cities_Climate_Change_Impacts_on_Health_and_Health_Systems.csv",
  stringsAsFactors = FALSE
)

disaster_freq <- read.csv("../data/Climate-related_Disasters_Frequency.csv",
  stringsAsFactors = FALSE
)

# Find the count of climate-related disasters that have affected nations.
disaster_freq_nations <- disaster_freq %>%
  filter(Indicator == "Climate related disasters frequency, Number of Disasters: TOTAL") %>%
  group_by(ISO3) %>%
  mutate(total_disasters = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  select(total_disasters, ISO3)

# Find the top climate-related hazard in nations.
top_hazard <- climate_hazards %>%
  group_by(Country) %>%
  count(Climate.related.hazards, sort = TRUE) %>%
  filter(n == max(n)) %>%
  filter(Climate.related.hazards != "") %>%
  summarize(top_hazard = paste(Climate.related.hazards, collapse = ", ")) %>%
  mutate(ISO3 = countrycode(Country,
    origin = "country.name",
    destination = "iso3c"
  ))

# Find the top climate-related health issue in nations.
health_issues <- climate_health %>%
  select(Country, Identify.the.climate.related.health.issues.faced.by.your.city) %>%
  rename(Health_issues = Identify.the.climate.related.health.issues.faced.by.your.city) %>%
  mutate(Health_issues = strsplit(as.character(Health_issues), ";")) %>%
  unnest(Health_issues) %>%
  mutate(Health_issues = str_trim(Health_issues, "left")) %>%
  group_by(Country) %>%
  count(Health_issues) %>%
  filter(Health_issues != "Question not applicable") %>%
  filter(n == max(n)) %>%
  summarize(top_health_issue = paste(Health_issues, collapse = ", ")) %>%
  mutate(ISO3 = countrycode(Country,
    origin = "country.name",
    destination = "iso3c"
  ))

# Join data and format for presentation.
data_table <- inner_join(disaster_freq_nations, top_hazard, by = "ISO3") %>%
  inner_join(health_issues, by = "ISO3") %>%
  mutate(Country = countrycode(ISO3,
    origin = "iso3c",
    destination = "country.name"
  )) %>%
  group_by(Country) %>%
  select(Country, total_disasters, top_health_issue, top_hazard) %>%
  filter(Country != "") %>%
  arrange(-total_disasters) %>%
  head(10) %>%
  rename(
    Number_of_climate_related_disasters_recorded_in_nation = total_disasters,
    Main_climate_related_health_issue_in_nation = top_health_issue,
    Main_climate_related_environmental_hazard_in_nation = top_hazard
  )
