library("dplyr")
library("ggplot2")

Frequency_of_distasters <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-zahrafiroz/main/data/Climate-related_Disasters_Frequency.csv")
Cities_climate_hazards <- read.csv("https://raw.githubusercontent.com/info201b-au2022/project-zahrafiroz/main/data/2022_Cities_Climate_Hazards.csv")

Highest_frequency <- Frequency_of_distasters %>%
  group_by(Country) %>%
  mutate(total = sum(across(starts_with("F")), na.rm = T)) %>%
  select(Country, total) %>%
  arrange(-total)
Highest_frequency <- distinct(Highest_frequency)

Top_ten_countries <- head(Highest_frequency, 10)

plot2 <- ggplot(data = Top_ten_countries) + 
  geom_col(
             mapping = aes( 
               x = reorder(Top_ten_countries$Country,
                           + Top_ten_countries$total),
               y = Top_ten_countries$total,
               color = Country,
               fill = Country)
  ) +
  labs(
    x = "Countries",
    y = "Disasters"
  ) +
  ggtitle("Frequency of Disasters", "Top Ten Countries")

plot2


