############################################
# Data Professor                           #
# http://youtube.com/dataprofessor         #
# http://github.com/dataprofessor          #
# http://facebook.com/dataprofessor        #
# https://www.instagram.com/data.professor #
############################################

######## READ DATA
# https://link.springer.com/article/10.1007%2Fs11030-013-9462-x
# 11030_2013_9462_MOESM2_ESM.xls (423 kb)
# Supplementary material 2 (xls 423 KB)
aromatase <- read.csv("aromatase.csv")

######## MISSING DATA
sum(is.na(aromatase))
missingdata <- aromatase[!complete.cases(aromatase), ] # Identify which row contains missing data

aromatase <- na.omit(aromatase) # Remove any missing data >> Complete case
sum(is.na(aromatase)) # Check again for missing data

class <- aromatase[,2] # Class label
aromatase2 <- aromatase[,6:18]   # Descriptors
aromatase3 <- cbind(class, aromatase2) # Combine Class label + Descriptors into same dataframe

df <- aromatase3 # Once we are satisfied with the dataset, let's call it "df" for conciseness


######## plot()

# See at a glance all possible scatter plots
plot(aromatase2)
plot(aromatase2 , col = "blue")

# Select a pair of interest to visualize scatter plot

     # Figure 1, https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0066566


plot(df$MW, df$ALogP)


plot(df$MW, df$ALogP, col = "red")

plot(df$MW, df$ALogP, pch = 16, col = "red") # pch = 16 means that circles are filled,
                                                # by default it is open circles
                                                # There are a total of 25 symbols to choose from

library(scales)

plot(df$MW, df$ALogP, pch = 16, 
     col = alpha("red", 0.3)
)


# Scatter plot of first pair
plot(df$MW, df$ALogP, pch = 16, 
     col = alpha("red", 0.3),
     xlab = "MW",    # X-axis label
     ylab = "ALogP", # Y-axis label
     font.lab = 2    # X and Y labels are now bold
     )
abline(lm(df$ALogP ~ df$MW)) # Trend line


# Scatter plot of second pair
plot(df$MW, df$Qm, pch = 16, 
     col = alpha("blue", 0.3),
     xlab = "MW",    # X-axis label
     ylab = "Qm", # Y-axis label
     font.lab = 2    # X and Y labels are now bold
)
abline(lm(df$Qm ~ df$MW)) # Trend line


# Scatter plot of third pair
plot(df$HOMO, df$LUMO, pch = 16, 
     col = alpha("green", 0.3),
     xlab = "HOMO",    # X-axis label
     ylab = "LUMO", # Y-axis label
     font.lab = 2    # X and Y labels are now bold
)
abline(lm(df$LUMO ~ df$HOMO)) # Trend line


# Scatter plot of fourth pair
plot(df$MW, df$HOMO, pch = 16, 
     col = alpha("purple", 0.3),
     xlab = "MW",    # X-axis label
     ylab = "HOMO", # Y-axis label
     font.lab = 2    # X and Y labels are now bold
)
abline(lm(df$HOMO ~ df$MW)) # Trend line


######## Creating multi-plot figures

  # 2 columns by 2 rows
      par(mfrow=c(2,2))
      # Plot 1
      # Plot 2
      # Plot 3
      # Plot 4
      
  # 4 columns by 1 row
      par(mfrow=c(4,1))
      # Plot 1
      # Plot 2
      # Plot 3
      # Plot 4
      
  # 1 column by 4 row
      par(mfrow=c(1,4))
      # Plot 1
      # Plot 2
      # Plot 3
      # Plot 4

      

######## Saving plot to file

# Single plot   
      
  pdf("plot.pdf")
  #...Insert plot function here...
  dev.off()

# Multi-plot

  pdf("plot.pdf")
    par(mfrow=c(2,2))
    # Plot 1
    # Plot 2
    # Plot 3
    # Plot 4
  dev.off()
