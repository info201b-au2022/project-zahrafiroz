# tab_panel_intro

library(shiny)

tab_panel_intro <-tabPanel(
    "Introduction",
    img("description", src = "intro_image.jpg", height='488px',width='810px'),
    p("This is the introduction.")
)
