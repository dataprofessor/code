####################################
# Data Professor                   #
# http://youtube.com/dataprofessor #
# http://github.com/dataprofessor  #
####################################

#########################
# Loading DHFR data set
#########################

# Method 1

library(datasets)
data(dhfr)

# Method 2
#dhfr2 <- datasets::dhfr

# Method 3
# install.packages("RCurl")

#library(RCurl)
dhfr <- read.csv(text = getURL("https://github.com/dataprofessor/data/raw/master/dhfr.csv") )

# View the data
View(dhfr)

#############################
# Display summary statistics
#############################

# head() / tail()
head(dhfr, 5)
tail(dhfr, 5)


# summary()
summary(dhfr)
summary(dhfr$Y)


# Check to see if there are missing data?
sum(is.na(dhfr))


# skimr() - expands on summary() by providing larger set of statistics
#  install.packages("skimr")
# https://github.com/ropensci/skimr

library(skimr)

skim(dhfr) # Perform skim to display summary statistics

# Group data by Y (biological activity) then perform skim
dhfr %>%
  dplyr::group_by(Y) %>%
  skim()

#############################
# Quick data visualization
#
# R base plot()
#############################


# Panel plots
#plot(dhfr)
#plot(iris, col = "red")

# Scatter plot
plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol)

plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col = "red")     # Makes red circles

plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col = dhfr$Y)    # Color by Y

plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col = "red",     # Makes red circles + Adds x and y axis labels
     xlab = "moe2D_zagreb", ylab = "moe2D_weinerPol")

# Histogram
hist(dhfr$moe2D_zagreb)
hist(dhfr$moe2D_zagreb, col = "red")   # Makes red bars

# Feature plots
# https://www.machinelearningplus.com/machine-learning/caret-package/
featurePlot(x = dhfr[,2:21],
            y = dhfr$Y,
            plot = "box",
            strip=strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation="free"),
                          y = list(relation="free")))
