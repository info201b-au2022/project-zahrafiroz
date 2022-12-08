library(shiny)
library(plotly)
library(shinythemes)
library(countrycode)
library(tidyverse)
library(rsconnect)
source("source/P3-code/p3_ui.R")
source("source/P3-code/p3_server.R")


# Run the application
shinyApp(ui = ui, server = server)
