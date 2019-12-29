####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

# Importing libraries
library(datasets) # Contains several data sets
library(caret) # Package for machine learning algorithms / CARET stands for Classification And REgression Training

# Importing the dhfr data set
data(dhfr)

# Check to see if there are missing data?
sum(is.na(dhfr))

# To achieve reproducible model; set the random seed number
set.seed(100)

# Performs stratified random split of the data set
TrainingIndex <- createDataPartition(dhfr$Y, p=0.8, list = FALSE)
TrainingSet <- dhfr[TrainingIndex,] # Training Set
TestingSet <- dhfr[-TrainingIndex,] # Test Set



###############################
# SVM model (polynomial kernel)

# Build Training model
Model <- train(Y ~ ., data = TrainingSet,
               method = "svmPoly",
               na.action = na.omit,
               preProcess=c("scale","center"),
               trControl= trainControl(method="none"),
               tuneGrid = data.frame(degree=1,scale=1,C=1)
)


# Save model to RDS file

saveRDS(Model, "Model.rds")

# Read the model from RDS file

read.Model <- readRDS("Model.rds")


# Apply model for prediction
Model.training <-predict(read.Model, TrainingSet) # Apply model to make prediction on Training set
Model.testing <-predict(read.Model, TestingSet) # Apply model to make prediction on Testing set

# Model performance (Displays confusion matrix and statistics)
Model.training.confusion <-confusionMatrix(Model.training, TrainingSet$Y)
Model.testing.confusion <-confusionMatrix(Model.testing, TestingSet$Y)

print(Model.training.confusion)
print(Model.testing.confusion)

# Feature importance
Importance <- varImp(Model)
plot(Importance, top = 25)
plot(Importance, col = "red")
