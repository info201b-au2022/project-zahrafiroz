library("tidyverse")
library("plotly")
library(countrycode)


disaster_freq <- read.csv(
  "data/Climate-related_Disasters_Frequency.csv",
  stringsAsFactors = FALSE
)

gov_expend <- read.csv(
  "data/Environmental_Protection_Expenditures.csv",
  stringsAsFactors = FALSE
)

tab_choices <- list(
  "Total Disasters" = "Total", "Droughts" = "Drought",
  "Wildfires" = "Wildfire", "Floods" = "Flood",
  "Extreme Temp. Events" = "Extreme temperature",
  "Storms" = "Storm", "Landslides" = "Landslide"
)

# Find the number of climate related disasters that have affected nations.
disaster_freq_nations <- disaster_freq %>%
  group_by(ISO3, Indicator) %>%
  mutate(sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  spread(key = Indicator, value = sum) %>%
  group_by(ISO3) %>%
  summarize(across(starts_with("Climate related"), sum, na.rm = TRUE)) %>%
  rename_with(~ gsub(".*: ", "", .), starts_with("Climate related")) %>%
  rename("Total" = TOTAL)

# Find the average percent of gdp nations spend on environmental protection.
avg_gdp_nations <- gov_expend %>%
  filter(Unit == "Percent of GDP") %>%
  group_by(ISO3) %>%
  summarise(sum = sum(across(starts_with("F")), na.rm = TRUE)) %>%
  mutate(avg_gdp = sum / ncol(select(gov_expend, starts_with("F")))) %>%
  select(-sum)

gdp_and_disasters <- left_join(
  avg_gdp_nations, disaster_freq_nations,
  by = "ISO3"
) %>%
  filter(ISO3 != "") %>%
  mutate(across(where(is.numeric), replace_na, 0)) %>%
  as.data.frame()

gdp_and_disasters$country <- countrycode(
  sourcevar = gdp_and_disasters[, "ISO3"],
  origin = "iso3c",
  destination = "country.name"
)

gdp_and_disasters$region <- countrycode(
  sourcevar = gdp_and_disasters[, "ISO3"],
  origin = "iso3c",
  destination = "region"
)

gdp_and_disasters$continent <- countrycode(
  sourcevar = gdp_and_disasters[, "ISO3"],
  origin = "iso3c",
  destination = "continent"
)

gdp_chart_legend <- list("region" = "<b>Region:", "continent" = "<b>Continent:")
