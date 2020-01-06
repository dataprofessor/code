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
# Random forest


# Run normally without parallel processing
start.time <- proc.time()
Model <- train(Y ~ ., 
               data = TrainingSet, # Build model using training set
               method = "rf" # Learning algorithm
         )
stop.time <- proc.time()
run.time <- stop.time - start.time
print(run.time)



# Use doParallel
# https://topepo.github.io/caret/parallel-processing.html

library(doParallel)

cl <- makePSOCKcluster(5)
registerDoParallel(cl)

start.time <- proc.time()
Model <- train(Y ~ ., 
               data = TrainingSet, # Build model using training set
               method = "rf" # Learning algorithm
         )
stop.time <- proc.time()
run.time <- stop.time - start.time
print(run.time)

stopCluster(cl)




##########################

# Run without parallel processing

start.time <- proc.time()
Model <- train(Y ~ ., 
               data = TrainingSet, # Build model using training set
               method = "rf", # Learning algorithm
               tuneGrid = data.frame(mtry = seq(5,15, by=5))
         )
stop.time <- proc.time()
run.time <- stop.time - start.time
print(run.time)

# Using doParallel

library(doParallel)

cl <- makePSOCKcluster(5)
registerDoParallel(cl)

start.time <- proc.time()
Model <- train(Y ~ ., 
               data = TrainingSet, # Build model using training set
               method = "rf", # Learning algorithm
               tuneGrid = data.frame(mtry = seq(5,15, by=5))
         )
stop.time <- proc.time()
run.time <- stop.time - start.time
print(run.time)

stopCluster(cl)


##########################
# Apply model for prediction
Model.training <-predict(Model, TrainingSet) # Apply model to make prediction on Training set

# Model performance (Displays confusion matrix and statistics)
Model.training.confusion <-confusionMatrix(Model.training, TrainingSet$Y)

print(Model.training.confusion)

# Feature importance
Importance <- varImp(Model)
plot(Importance, top = 25)
plot(Importance, col = "red")
