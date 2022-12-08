library(shiny)
library(shinythemes)

source("source/P3-code/tabs/tab_panel_intro.R")
source("source/P3-code/tabs/tab_panel_chart1.R")
source("source/P3-code/tabs/tab_panel_chart2.R")
source("source/P3-code/tabs/tab_panel_chart3.R")
source("source/P3-code/tabs/tab_panel_summary.R")
source("source/P3-code/tabs/tab_panel_report.R")

ui <- tagList(
  includeCSS("source/P3-code/www/my_styles.css"),
  navbarPage(
    title = "The Impacts of Climate Change on Human Health",
    position = "fixed-top",
    theme = shinytheme("flatly"),

    # Footer
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
)
