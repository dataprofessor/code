####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################


# Import libraries
library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)
library(randomForest)

# Read data, at first I got an error message stating,
# Error in y - ymean : non-numeric argument to binary operator
# Until I put in line 20 and lines 23-25. Fixed bug.
weather <- read.csv(
  text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/weather-weka.csv"),
  stringsAsFactors = FALSE
)

weather$play <- as.factor(weather$play)
weather$outlook <- as.factor(weather$outlook)
weather$windy <- as.factor(weather$windy)


# Build model
model <- randomForest(play ~ ., data = weather, ntree = 500, mtry = 4, importance = TRUE)

# Save model to RDS file
# saveRDS(model, "model.rds")

# Read in the RF model
#model <- readRDS("model.rds")

####################################
# User interface                   #
####################################

ui <- fluidPage(theme = shinytheme("united"),
                
  # Page header
  headerPanel('Play Golf?'),
                
  # Input values
  sidebarPanel(
  HTML("<h3>Input parameters</h3>"),
                  
  selectInput("outlook", label = "Outlook:", 
              choices = list("Sunny" = "sunny", "Overcast" = "overcast", "Rainy" = "rainy"), 
              selected = "Rainy"),
  sliderInput("temperature", "Temperature:",
              min = 64, max = 86,
              value = 70),
  sliderInput("humidity", "Humidity:",
              min = 65, max = 96,
              value = 90),
  selectInput("windy", label = "Windy:", 
              choices = list("Yes" = "TRUE", "No" = "FALSE"), 
              selected = "TRUE"),
                  
  actionButton("submitbutton", "Submit", class = "btn btn-primary")
  ),
                
  mainPanel(
  tags$label(h3('Status/Output')), # Status/Output Text Box
  verbatimTextOutput('contents'),
  tableOutput('tabledata') # Prediction results table
                  
  )
)

####################################
# Server                           #
####################################

server <- function(input, output, session) {
  
 
  # Refactored the 'datasetInput' reactive expression
  # Input Data
  datasetInput <- reactive({  
    
    # Create the dataframe with correct types immediately
    test <- data.frame(
      outlook = factor(input$outlook, levels = levels(weather$outlook)),
      temperature = as.numeric(input$temperature),
      humidity = as.numeric(input$humidity),
      windy = factor(input$windy, levels = levels(weather$windy))
    )
    
    # Generate prediction
    Output <- data.frame(
      Prediction = predict(model, test), 
      round(predict(model, test, type = "prob"), 3)
    )
    print(Output)
  })
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
}

####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server) `
