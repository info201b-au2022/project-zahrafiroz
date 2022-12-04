# tab_panel_intro

library(shiny)

tab_panel_intro <-tabPanel(
    "Introduction",
    h1("Introduction"),
    img(src = "intro_image.jpg", height='488px',width='810px', align = "center"),
    p("Photo by ", a("Patricia Zavala", href = "https://unsplash.com/@pattyzc?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText"),"(2020)")
)
