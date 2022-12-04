
library(shiny)
library(shinythemes)

source("tabs/tab_panel_intro.R")
source("tabs/tab_panel_chart1.R")
source("tabs/tab_panel_chart2.R")
source("tabs/tab_panel_chart3.R")
source("tabs/tab_panel_summary.R")
source("tabs/tab_panel_report.R")

ui <- navbarPage(
  title = "Project Example",
  position = "fixed-top",
  theme = shinytheme("flatly"),

  # A simple header
  header = list(
    header = includeCSS("www/my_styles.css"),
    tags$style(type = "text/css", "body {padding-top: 70px;}"),
    hr(),
    HTML("Climate Change Health Impacts "),
    hr()
  ),

  # A simple footer
  footer = list(
    tags$style(type = "text/css", "body {padding-top: 70px;}"),
    hr(),
    HTML("... Project Footer ... "),
    hr()
  ),

  # The project introduction
  tab_panel_intro,

  # The three charts
  tab_panel_chart1,
  tab_panel_chart2,
  tab_panel_chart3,

  # The project summary
  tab_panel_summary,

  # The project report
  tab_panel_report,
  
)
