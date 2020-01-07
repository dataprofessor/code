####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################


# 1. Loading the DHFR data
library(RCurl)
dhfr <- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/dhfr.csv") )

View(dhfr)


# 2. Check for missing data

sum(is.na(dhfr))


# 3. If data is clean, randomly introduce NA to the dataset

na.gen <- function(data,n) {
  i <- 1
  while (i < n+1) {
    idx1 <- sample(1:nrow(data), 1)
    idx2 <- sample(1:ncol(data), 1)
    data[idx1,idx2] <- NA
    i = i+1
  }
  return(data)
}


# Before introducing NA to the dataset, leave the Y class label (output variable) out

dhfr <- dhfr[,-1]


# Choose 1 of the following to run (they'll produce the same result)

dhfr <- na.gen(dhfr,100)

dhfr <- na.gen(n=100,data=dhfr)

dhfr <- na.gen(100,dhfr) # This produces an error, why?


# 4. Check again for missing data

sum(is.na(dhfr))

colSums(is.na(dhfr))

str(dhfr)


# Lists rows with missing data

missingdata <- dhfr[!complete.cases(dhfr), ]

sum(is.na(missingdata))


# If above sum is 0, this means that there is no missing data and proceed to modeling.
# If above sum is greater than 0, then proceed to # 5


# 5. Handling the missing data. There are 2 options, decide and choose only 1

# 5.1. Simply delete all entries with missing data

clean.data <- na.omit(dhfr)

sum(is.na(clean.data))


# 5.2. Imputation: Replace missing values with the column's 

# MEAN
dhfr.impute <- dhfr

for (i in which(sapply(dhfr.impute, is.numeric))) { 
  dhfr.impute[is.na(dhfr.impute[, i]), i] <- mean(dhfr.impute[, i],  na.rm = TRUE) 
}

sum(is.na(dhfr.impute))


# MEDIAN
dhfr.impute <- dhfr

for (i in which(sapply(dhfr.impute, is.numeric))) { 
  dhfr.impute[is.na(dhfr.impute[, i]), i] <- median(dhfr.impute[, i],  na.rm = TRUE) 
}

sum(is.na(dhfr.impute))
