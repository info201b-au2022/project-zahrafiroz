#every plugin will need to go in here
library(shiny)
library(plotly)
library(shinythemes)
library(countrycode)
library(tidyverse)
source("app_ui.R")
source("app_server.R")

# Run the application
shinyApp(ui = ui, server = server)
