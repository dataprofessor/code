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

class <- aromatase[ ,2] # Class label
aromatase2 <- aromatase[,6:18]   # Descriptors
aromatase3 <- cbind(class, aromatase2) # Combine Class label + Descriptors into same dataframe

df <- aromatase3 # Once we are satisfied with the dataset, let's call it "df" for conciseness


######## plot()

# See at a glance all possible scatter plots
plot(df)
plot(df , col = "blue")

# Select a pair of interest to visualize scatter plot

     # Figure 1, https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0066566


plot(df$MW, df$ALogP)


# We're going to make Steroids blue and Non-Steroids red
library(colorspace) 
df$color <- factor(df$class,
                     levels=c("Steroid", "Non-Steroid"),
                     labels=c("blue", "red"))
plot(df$MW, df$ALogP, pch = 16, col=as.character(df$color) )




# col argument for defining the color
# R has 657 colors, colors() function lists these colors
plot(df$MW, df$ALogP, col = "red")
plot(df$MW, df$ALogP, col = "blue")
plot(df$MW, df$ALogP, col = "green")
plot(df$MW, df$ALogP, col = "purple")

plot(df$MW, df$ALogP, col = "orangered3")

plot(df$MW, df$ALogP, col = "#FF0000") # Hex color code for red

# Color in RGB color code
rgb(1,0,0) # red color
rgb(255,0,0, max=255) # red color

plot(df$MW, df$ALogP, col = rgb(0,0,0, max=255) )



# symbols

plot(df$MW, df$ALogP, pch = 1) # pch = 1, open circles (the default value)
                                            # There are a total of 25 symbols to choose from
plot(df$MW, df$ALogP, pch = 2) # pch = 2, open triangle symbols
plot(df$MW, df$ALogP, pch = 3) # pch = 3, plus symbols
plot(df$MW, df$ALogP, pch = 4) # pch = 4, x symbols
plot(df$MW, df$ALogP, pch = 5) # pch = 5, diamond diamongs
plot(df$MW, df$ALogP, pch = 16) # pch = 16, filled circle symbols


plot(df$MW, df$ALogP, pch = 16, col = "orangered3")                                                
col2rgb("orangered3") # This gives us rgb(205,55,0, max=255)
plot(df$MW, df$ALogP, pch = 16, col = rgb(205,55,0, max=255))


# Add transparency to color 

library(scales)

plot(df$MW, df$ALogP, pch = 16, 
     col = alpha("orangered3", 0.3))

plot(df$MW, df$ALogP, pch = 16, 
     col = rgb(205,55,0, 75, max=255))

plot(df$MW, df$ALogP, pch = 16, col=alpha(as.character(df$color),0.3 ) )


##################################
# Multi-plot

# Scatter plot of first pair
plot(df$MW, df$ALogP, pch = 16, 
     col = alpha("red", 0.3),
     xlab = "Molecular Weight (MW)",    # X-axis label
     ylab = "Solubility (ALogP)", # Y-axis label
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

  # 2 rows by 2 columns

      par(mfrow=c(2,2))
      # Plot 1
      # Plot 2
      # Plot 3
      # Plot 4
      
      par(mfrow=c(2,2),  mai = c(0.7, 0.7, 0.3, 0.3))
        plot(df$MW, df$ALogP) # Plot 1
        plot(df$MW, df$Qm) # Plot 2
        plot(df$HOMO, df$LUMO) # Plot 3
        plot(df$MW, df$HOMO) # Plot 4
      
        
  # 3 rows by 1 column
        
      par(mfrow=c(3,1))
      # Plot 1
      # Plot 2
      # Plot 4
      
      par(mfrow=c(3,1),  mai = c(0.3, 0.7, 0.1, 0.3))
        plot(df$MW, df$ALogP) # Plot 1
        plot(df$MW, df$Qm) # Plot 2
        plot(df$MW, df$HOMO) # Plot 4
      
        
  # 1 row by 3 column
        
      par(mfrow=c(1,3))
      # Plot 1
      # Plot 2
      # Plot 3
      # Plot 4

      par(mfrow=c(1,3),  mai = c(0.3, 0.3, 0.3, 0.3))
        plot(df$MW, df$ALogP) # Plot 1
        plot(df$MW, df$Qm) # Plot 2
        plot(df$MW, df$HOMO) # Plot 4
      
      par(mfrow=c(1,3),  mai = c(0.3, 0.3, 0.3, 0))
        plot(df$ALogP, df$MW) # Plot 1
        plot(df$Qm, df$MW) # Plot 2
        plot(df$HOMO, df$MW) # Plot 4
        

######## Saving plot to file

# Single plot   
      
  pdf("plot.pdf")
  #...Insert plot function here...
  dev.off()
  
  pdf("plot.pdf")
    plot(df$ALogP, df$MW)
  dev.off()
  
# Multi-plot

  pdf("plot2.pdf")
    par(mfrow=c(2,2))
    # Plot 1
    # Plot 2
    # Plot 3
    # Plot 4
  dev.off()

  pdf("plot_multiplot.pdf")
    par(mfrow=c(1,3),  mai = c(0.3, 0.3, 0.3, 0))
      plot(df$ALogP, df$MW) # Plot 1
      plot(df$Qm, df$MW) # Plot 2
      plot(df$HOMO, df$MW) # Plot 4
  dev.off()
  
  pdf("plot2.pdf")
  par(mfrow=c(2,2),  mai = c(0.7, 0.7, 0.3, 0.3))
    # Plot 1
    # Plot 2
    # Plot 3
    # Plot 4
  dev.off()
