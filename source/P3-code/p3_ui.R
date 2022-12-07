library(shiny)
library(shinythemes)

source("source/P3-code/tabs/tab_panel_intro.R")
source("source/P3-code/tabs/tab_panel_chart1.R")
source("source/P3-code/tabs/tab_panel_chart2.R")
source("source/P3-code/tabs/tab_panel_chart3.R")
source("source/P3-code/tabs/tab_panel_summary.R")
source("source/P3-code/tabs/tab_panel_report.R")

ui <- navbarPage(
  title = "Climate Change-Related Health Impacts",
  position = "fixed-top",
  theme = shinytheme("flatly"),
  includeCSS("source/P3-code/www/my_styles.css"),
  tags$style(type = "text/css", "body {padding-top: 75px;}"),

  # A simple footer
  footer = tags$footer(list(
    includeHTML("source/P3-code/tabs/footer.html")
  )),

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
