##########################################################
# Recherche	
##########################################################


#========================================================
# init environment
rm(list = ls())
setwd("C:/ieu/workspace/R/tooling-und-datenmanagement/take-home-exam")
library(dplyr)
library(foreign)


#========================================================
# load data
ebay <- read.dta("http://www.farys.org/daten/ebay.dta")
str(ebay)
head(ebay)
ebay.bak <- ebay
#========================================================
# variable rating
ebay$rating <- ebay$sepos / (ebay$seneg + ebay$sepos)

# how to exclude cases where there are less than 12 pos ratings 
# try with dplyr:
ebaynew <- ebay %>%
  filter(sepos >= 12) %>%
  mutate(rating =  sepos / (seneg + sepos))

# check that the relevant cases sum up correctly 
# we filtered out the cases where sepos < 12
nrow(ebaynew)
nrow(ebay)
nrow(ebay[ebay$sepos<12,])

# Check that we have only numerical values in rating
hist(ebaynew$rating)
rm (tmp)
tmp <- is.na(ebaynew$rating)
tmp[tmp==T] # OK: Zero
tmp[tmp==F]

# check that we have only T / F in makellos
str(ebaynew)
nrow(ebaynew[ebaynew$makellos==TRUE,])
nrow(ebaynew[ebaynew$makellos==FALSE,])
nrow(ebaynew) == nrow(ebaynew[ebaynew$makellos==TRUE,]) + nrow(ebaynew[ebaynew$makellos==FALSE,])



#========================================================
# variable makellos
ebay$makellos <- ebay$rating >= 0.98
head(ebay)






