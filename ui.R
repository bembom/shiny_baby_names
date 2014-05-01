
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(
  
  titlePanel(h3("Popular baby names over time", align = "center")),
  
  plotOutput("trendPlot", height = "600px"),    
  
  fluidRow(
    column(3, selectInput("gender", label = "Gender", choices = list("Boy" = "boy", "Girl" = "girl"))),
    column(3, selectInput("num_names", label = "Number of names", choices = as.integer(1:20), selected = 12)),
    column(3, sliderInput("year", label = "Top names for year", min = 1880, max = 2008, value = 2008, format="####", animate = animationOptions(interval = 2000))),
    column(3, sliderInput("display_range", label = "Display range", min = 1880, max = 2008, value = c(1970, 2008), format="####"))
    )
  
  
))
