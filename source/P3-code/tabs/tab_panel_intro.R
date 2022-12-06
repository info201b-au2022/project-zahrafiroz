# tab_panel_intro

library(shiny)

tab_panel_intro <-tabPanel(
  "Introduction",
  fluidRow(
    column(
      6,
      h1("Climate Change-Related Health Impacts"),
      img(src = "intro_image.jpg", height='488px',width='810px', align = "center"),
      p("(Photo by ", a("Patricia Zavala", href = "https://unsplash.com/@pattyzc?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText"),"(2020))"),
      tags$br(),
      p("A report by Calvin Standaert")
    ),
    column(
      6,
      h2("Introduction"),
      p("By most accounts, climate change and its current and projected impacts 
      are one of the top concerns for nations and individuals around the world. 
      As a result of these current and projected impacts, a great deal of 
      research has been done to investigate the ways that climate change may 
      affect climate patterns, the species of the world, sea levels, and other 
      aspects of the natural environment. At the same time as the scientific 
      concern, climate change is also a matter of key importance in the 
      political, social, and cultural realm of people around the world. Despite 
      the amassed research on the impacts of climate change on the natural 
      environment and the concern from nations and individuals, little research 
      has been done on the ways that climate change has impacted human 
      health."),
      tags$br(),
      p("In order to investigate the ways that climate change has impacted human
      health, we set out to conduct research on the health impacts of 
      climate change, with the hope of answering three primary research 
      questions. The first question we sought to answer was “How has human 
      health been impacted as a result of the environmental shifts caused by 
      climate change?”. Next, after determining how human health has been 
      impacted as a result of climate change, we wanted to answer the second 
      question “Which groups are most affected by the health risks posed by 
      climate change?”. Finally, after understanding how climate change has 
      impacted human health and which groups are most affected by those impacts,
      we finally sought to answer the question “How have the governments of 
      those most affected by climate change health impacts responded?”."),
      tags$br(),
      h2("The Dataset:"),
      p("In order to answer our research questions, we created a dataset on the 
      health impacts of climate change gathered from two key sources: the 
      International Monetary Fund (IMF) and the Carbon Disclosure Project (CDP) 
      with help from the ICLEI – Local Governments for Sustainability."),
      tags$br(),
      p("The data we collected from CDP/ICLEI was comprised of tabular datasets 
      gathered from two sets of voluntary response questionnaires sent to city 
      governments in 2021 and 2022. The first dataset gathered by the CDP in 
      2021 contains city government responses on the most frequent 
      climate-related health issues in their city, along with the groups that 
      were most vulnerable to those health issues. Similarly to the first 
      dataset, the second dataset taken by the CDP in 2022 contains city 
      government responses on the most frequent climate-related hazards in their
      city, along with the groups that were most vulnerable to those hazards."),
      tags$br(),
      p("Next, the data we collected from the IMF was composed of two main 
      datasets created as part of the IMF’s ongoing Climate Change Indicators 
      Project, which seeks to provide a link between climate change 
      considerations and global economics. The first dataset we used from the 
      IMF was collected by the IMF’s statistics department on the governmental 
      expenditures of nations on environmental protection expenditures from 
      1995 to 2021. The second dataset we gathered from the IMF was provided by 
      The Emergency Events Database (EM-DAT) and the Centre for Research on 
      the Epidemiology of Disasters (CRED) at Université Catholique de Louvain 
      (UCLouvain) in Belgium, and contains the yearly frequency of 
      climate-related disasters for the world’s nations from 1980 to 2021."),
      tags$br(),
      h2("Key Findings:"),
      p("After conducting an analysis of our dataset we were able to determine 
      answers to our research questions."),
      tags$br(),
      p("With our first research question on the ways that human health has been
      impacted by the shifts brought on by climate change, we were able to 
      determine the main ways that human health has been impacted due to 
      climate-related health issues, climate-related hazards, and 
      climate-related disasters. Concerning climate change-related health 
      issues, we determined that the main health issues impacting the 
      populations of world cities in 2021 were heat-related illnesses, 
      air-pollution-related illnesses, and vector-borne infectious diseases. 
      Next, through our analysis of the data on climate-related hazards, we were
      able to identify that the climate-related hazards in 2022 most frequently 
      impacting the populations of world cities were extreme heat, 
      heavy precipitation, and urban flooding. Finally, with the data provided 
      by the IMF on climate-related disasters, we discovered that the 
      climate-related disasters most frequently affecting the nations of the 
      world from 1980 to 2021 were floods and storms."),
      tags$br(),
      p("Considering our second research question on which groups are most 
      affected by the health impacts of climate change, we were able to identify
      the population subgroups most affected by climate-related health 
      issues/hazards, and the nations most affected by climate-related 
      disasters. Through our analysis of the CDP data on climate-related health 
      issues, we determined that the population subgroups reported by cities in 
      2021 as most affected by climate-related health issues were the elderly, 
      children/youth, and low-income households. Next, by analyzing the CDP data
      on climate-related hazards, we discovered that the population subgroups 
      reported by cities in 2022 to be most affected by climate-related hazards 
      were low-income households, the elderly, and marginalized or minority 
      communities. Lastly, by examining the IMF data on climate disaster 
      frequency, we identified that the nations most affected by climate-related
      disasters from 1980 to 2021 were The United States, China, and India."),
      tags$br(),
      p("Regarding our third and last research question on how the governments 
      of those most affected by the health risk posed by climate change have 
      responded, we determined that the total number of climate-related 
      disasters experienced by a nation from 1980 to 2021 did not appear to be 
      related to the percent of a nations GDP that is spent on environmental 
      expenditures.")
    ),
  )
)
