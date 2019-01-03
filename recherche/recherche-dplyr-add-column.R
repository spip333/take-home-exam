##########################################################
# Recherche	 dplyr : add column and filter
##########################################################

library(dplyr)

#========================================================
# add a column to a data frame
tmp <- mtcars %>% mutate(
  cyl2 = cyl * 2,
  cyl4 = cyl2 * 2
)

str(tmp)
