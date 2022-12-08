library(shiny)
library("markdown")

tab_panel_report <- tabPanel(
  "Report",
  includeMarkdown("source/P3-code/tabs/p03-final-report.md"),
  tags$style(type = "text/css", "body {padding-bottom: 100px;}"),
)
