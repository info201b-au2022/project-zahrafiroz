library(shiny)

tab_panel_summary <- tabPanel(
  "Summary",
  fluidRow(
    column(3),
    column(
      6,
      h1("Summary"),
      style = "background-color: #e9f2f5; min-height: 100%; position: fixed;
      left: 50%;top: 50%; transform: translate(-50%, -50%); margin-top: 50px;",
      p("From our analysis of the data on the health impacts of climate change,
      we were able to discern three major points."),
      tags$br(),
      p("The first key point from our analysis is that ", em("climate change is 
      impacting human health by exacerbating or leading to the increased 
      prevalence of certain health issues, health hazards, and climate 
      disasters"), ". Considering health issues, our analysis of data on the 
      most commonly reported health issues caused or exacerbated by climate 
      change led us to find that the most frequently reported health issues 
      related to climate change in 2021 were heat-related illnesses, 
      air-pollution-related illnesses, and vector-borne infectious diseases. 
      Next, through our analysis of the data on city climate hazards, we 
      determined that the most frequently reported health hazards related to 
      climate change in 2022 were extreme heat, heavy precipitation, and urban 
      flooding. Finally, by looking at the IMF data on climate disaster 
      frequency, we discovered that the climate disasters most frequently 
      impacting world nations from 1980 to 2021 were floods and storms"),
      tags$br(),
      p("The next key point produced from our research was that ", em("certain 
      subgroups of city populations and certain nations are most affected by the
      health impacts caused by climate change"), ". By analyzing data on the 
      frequency of climate-related health issues, we determined the population 
      subgroups that were most commonly vulnerable to climate-related health 
      issues in 2021 were the elderly, children/youth, and low-income 
      households. Through our similar analysis of data on the frequency of 
      climate-related hazards, we identified that the population subgroups most 
      frequently vulnerable to climate-related hazards in 2022 were low-income 
      households, the elderly, and marginalized or minority communities. Lastly,
      by looking at data on the frequency of climate-related disasters, we 
      determined that the nations most affected by climate-related disasters 
      from 1980 to 2021 were The United States, China, and India."),
      tags$br(),
      p("The last point from our analysis was ", em("that it is unclear how the 
      governments of those most affected by the health impacts of climate change
      have reacted."), " We reached this final conclusion by examining how the 
      number of climate-related disasters affecting a nation was associated 
      with the percentage of a nation’s GDP that was spent on environmental 
      protection. What we found was that the number of climate-related 
      disasters that occurred in a nation from 1980 to 2021 appeared to have 
      little to no relationship with the percentage of GDP that a given nation 
      spent on environmental protection.")
    ),
    column(3)
  )
)
