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

# Read data
weather <- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/weather-weka.csv") )

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

server <- function(input, output, session){
  
  # Using event reactive function to update the predictors used in the model upon the hitting the submit button
    
  datasetInput <- eventReactive( input$submit,{
   
    # create dataframe structure from weather dataframe
    rvtest.df = weather[0,1:4]
    
    rvtest.df[1,1] = factor(input$outlook, levels = c("sunny", "rainy", "overcast"))
    rvtest.df[1,2] = input$temperature
    rvtest.df[1,3] = input$humidity
    rvtest.df[1,4] = ifelse(input$windy == "TRUE", T, F)
       
    
    " Note: dataframe with updated input values for the predictors will be used in the prediction model, hence we 
skip the code below that writes to csv file to build the test dataset "
    
    # write the inputs to csv file
    # write.table(rvtest.df[,1:4], paste0(path,"/csv/ui_inputs.csv"), sep=",", 
    #         quote = FALSE, row.names = FALSE, col.names = TRUE)
   
    # Append the csv file without headers
    #write.table(rvtest.df[,1:4], append = TRUE,  paste0(path,"/csv/ui_inputs.csv"), sep=",", 
    #           quote = FALSE, row.names = FALSE, col.names = FALSE)
    
    
    Output <- data.frame(Prediction=predict(model,rvtest.df), 
                     round(predict(model,rvtest.df,type="prob"), 3))
    
  })
  
  # Render output for Prediction results table 
  output$tabledata <- renderTable({
    datasetInput()
  })
  
  # Render output for Status/Output Text Box
  output$contents <- renderPrint({
    ifelse(!input$submitbutton,"Server is ready for calculation.","Calculation complete." )
  })
  
} # server



####################################
# Create the shiny app             #
####################################
shinyApp(ui = ui, server = server)
