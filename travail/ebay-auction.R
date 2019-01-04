##########################################################
# ebay -auction	
##########################################################


library(dplyr)
library(foreign)

#========================================================
# init environment
rm(list = ls())
setwd("C:/ieu/workspace/R/tooling-und-datenmanagement/take-home-exam")


#========================================================
# load data
ebay <- read.dta("http://www.farys.org/daten/ebay.dta")
ebay.bak <- ebay

#========================================================
# filter out rows where sepos < 12, add a column "rating" and a column "makellos"
ebaynew <- ebay %>%
  filter(sepos >= 12) %>%
  mutate(
    rating =  sepos / (seneg + sepos),
    makellos = rating > 0.98
  )

#========================================================


