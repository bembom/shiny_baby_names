
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(dplyr)
library(ggplot2)
library(scales)

load("data/baby_names.rda")

shinyServer(function(input, output) {
   
    
  
  output$trendPlot <- renderPlot({    
    
    num_names <- as.integer(input$num_names)
    min_year <- input$display_range[1]
    max_year <- input$display_range[2]
    
    top_names <- df %.% 
      filter(year == input$year, gender == input$gender) %.%
      arrange(desc(prop)) %.%
      head(num_names) %.%
      select(name) %.%
      mutate(name_label = sprintf("%d: %s", 1:num_names, name),
             name_label = factor(name_label, levels = name_label))
    
    s <- df %.% 
      filter(gender == input$gender, year >= min_year, year <= max_year) %.%
      inner_join(top_names, by = "name")
        
    s <- data.frame(year = min_year:max_year) %.%
      left_join(s, by = "year") %.%
      mutate(prop = ifelse(is.na(prop), 0, prop))
    
                
    p <- ggplot(s, aes(x = year, y = prop)) + 
      geom_line(color = "blue") +       
      scale_y_continuous(label = percent) +
      labs(x = "", y = "Percent of baby names", title = sprintf("Top %d %s names for %d\n", num_names, input$gender, input$year)) +
      facet_wrap(~name_label)
    
    if (input$year >= min_year && input$year <= max_year){
      p <- p + geom_vline(xintercept = input$year, lty = 2) 
    }
      
    
    print(p)
  })
  
  
})
