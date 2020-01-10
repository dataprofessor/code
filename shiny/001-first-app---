####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

# Modified from Winston Chang, https://shiny.rstudio.com/gallery/shiny-theme-selector.html

library(shiny)
library(shinythemes)


shinyApp(
  ui = fluidPage(theme = shinytheme("cerulean"),
    navbarPage(
      "My first app",
      tabPanel("Navbar 1",
               sidebarPanel(
                 tags$h3("Input 1:"),
                 textInput("txt1", "Text input A:", ""),
                 textInput("txt2", "Text input B:", ""),
                 
                 tags$h3("Input 2:"),
                 sliderInput("integer", "Numerical input C:",
                             min = 0, max = 1000,
                             value = "0"),
                 
                 tags$h3("Input 3:"),
                 textAreaInput("textbox", "Text Box", "", rows=5, cols=100, width='100%')
                 
               ), # sidebarPanel
               mainPanel(
                            h1("Header 1"),
                            
                            h4("Output 1"),
                            verbatimTextOutput("txtout"),
                            
                            h4("Output 2"),
                            verbatimTextOutput("integerout"),
                            
                            h4("Output 3"),
                            verbatimTextOutput("txtboxout")

               ) # mainPanel
               
      ), # Navbar 1, tabPanel
      tabPanel("Navbar 2", "This panel is intentionally left blank"),
      tabPanel("Navbar 3", "This panel is intentionally left blank"),
      
      copyright <- div(HTML("<br><table border=0 cellpadding=10 cellspacing=10 width='100%' height='50'><tr><td bgcolor='#f2f2f2' align='center'>Copyright © 2020 <a href='http://youtube.com/dataprofessor'>Data Professor</a>. All rights reserved.</td></tr></table>")),
      cat(as.character(copyright))
      
    )
  ),
  
  server = function(input, output) {
    
    output$txtout <- renderText({
      paste(input$txt1, input$txt2, sep = "\n")
    })
    
    output$integerout <- renderText({
      paste(input$integer, sep = "")
    })
    
    output$txtboxout <- renderText({ paste(input$textbox) })

  }
)
