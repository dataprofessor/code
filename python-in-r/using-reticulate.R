############################################
# Data Professor                           #
# http://youtube.com/dataprofessor         #
# http://github.com/dataprofessor          #
# http://facebook.com/dataprofessor        #
# https://www.instagram.com/data.professor #
############################################

# https://rstudio.github.io/reticulate/
# install.packages("reticulate")
library(reticulate)

# Loads Python Shell
repl_python()

# Check the current Python version

reticulate::py_config()

# Load a particular Python version on our system
use_python("C:/Program Files/Python38", required = TRUE)



############################
#
# matplotlib Example - Scatter plot
# https://matplotlib.org/3.1.1/gallery/shapes_and_collections/scatter.html#sphx-glr-gallery-shapes-and-collections-scatter-py
#
############################

############################
# Import libraries
############################

# import matplotlib.pyplot as plt
plt <- import('matplotlib.pyplot') 

# import numpy as np
np <- import('numpy')

############################
# Load the Iris dataset
############################
data(iris)


############################
# Fixing random state for reproducibility
############################

# np.random.seed(19680801)  # https://github.com/rstudio/reticulate/issues/226
np$random$seed(19680801L)

# N = 50
N <- 50L
# x = np.random.rand(N)
x <- np$random$rand(N)

# y = np.random.rand(N)
y <- np$random$rand(N)

# colors = np.random.rand(N)
colors <- np$random$rand(N)

# area = (30 * np.random.rand(N))**2  # 0 to 15 point radii
area <- (30 * np$random$rand(N))**2

# plt.scatter(x, y, s=area, c=colors, alpha=0.5)
plt$scatter(x, y, s=area, c=colors, alpha=0.5)

# plt.show()
plt$show()
