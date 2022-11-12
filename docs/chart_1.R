# Load packages
library("dplyr")
library("ggmap")
library("ggplot2")
library("stringr")

# Questions to answer:
#
# How has human health been impacted - Chart one of these values
# OPTION 1: Top hazard across countries <- count inject a pie graph/bar chart
#    - Value
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
  arrange(by = -n)

#   Graphing
ggplot(data = hazards_count, aes(x = hazards_count$Climate.related.hazards, y = hazards_count$n, fill = hazards_count$Climate.related.hazards)) +
  geom_bar(stat = "identity") +
  coord_polar("y")

hazards_count %>%
  ggplot() +
  geom_bar(aes(x = hazards_count$Climate.related.hazards, y = hazards_count$n, fill = hazards_count$Climate.related.hazards)) +
  ylab("Frequency") +
  xlab("Types of Hazards") +
  theme_minimal() +
  theme(legend.position = "none")

# OPTION 2: Top health issue <- counts
#    - Value
#  Loading data
health_issues <- read.csv("~/Documents/info201/project-zahrafiroz/data/2021_Cities_Climate_Change_Impacts_on_Health_and_Health_Systems.csv")

#  Narrowing down columns
health_issues <- health_issues %>% select(Country, Identify.the.climate.related.health.issues.faced.by.your.city)

#  Count of health issues
health_issues_count <- health_issues %>%
  select(Identify.the.climate.related.health.issues.faced.by.your.city) %>%
  count(Identify.the.climate.related.health.issues.faced.by.your.city)

health_issues_count <- str_split(health_issues$Identify.the.climate.related.health.issues.faced.by.your.city, ";") %>%
  unlist() %>%
  str_trim("left") %>%
  table()
health_issues_count <- data.frame(health_issues_count)

health_issues_count <- health_issues_count %>% rename(health_issues_count, health.issues = .)

health_issues_count <- health_issues_count %>%
  select(health.issues, Freq) %>%
  na_if("") %>%
  na.omit() %>%
  na_if("Question not applicable") %>%
  na.omit() %>%
  arrange(by = -Freq)

#   Graphing
health_issues_count %>%
  ggplot()
geom_point(aes(x = health_issues_count$health.issues, y = health_issues_count$Freq))

# OPTION 3: Disaster frequency <- frequency of each disaster (finding the top)
#    - Value
#   Loading data
countries_disasters <- read.csv("~/Documents/info201/project-zahrafiroz/data/Climate-related_Disasters_Frequency.csv")

#   Narrowing down columns
countries_disasters <- countries_disasters %>% select(Country, Indicator, F1980:F2018)
disaster_count <- str_split(countries_disasters$Indicator, ":") %>%
  unlist() %>%
  str_trim("left") %>%
  table()
disaster_count <- data.frame(disaster_count)

#   Count of disaster types
disaster_count <- disaster_count %>% rename(disaster_count, disaster.types = .)

disaster_count <- disaster_count %>%
  select(disaster.types, Freq) %>%
  na_if("Climate related disasters frequency, Number of Disasters") %>%
  na.omit() %>%
  na_if("TOTAL") %>%
  na.omit() %>%
  arrange(by = -Freq)

#  Graphing

