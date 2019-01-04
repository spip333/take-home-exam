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
  mutate(
    rating =  sepos / (seneg + sepos),
    makellos = rating > 0.98
         )

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

#========================================================
# BOXPLOT
?boxplot
help(bxp)

str(ToothGrowth)
head(ToothGrowth)

x <- ToothGrowth

## Using 'at = ' and adding boxplots -- example idea by Roger Bivand :
boxplot(len ~ dose, data = ToothGrowth,
        boxwex = 0.25, at = 1:3 - 0.2,
        subset = supp == "VC", col = "yellow",
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg",
        ylab = "tooth length",
        xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")
boxplot(len ~ dose, data = ToothGrowth, add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", col = "orange")
legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))

#========================================================
## boxplot of the ebay data
# Zeichnen Sie einen farblich geschichteten Boxplot: Y-Achse=Preis, X-Achse=Gerätetyp, 
# farblich geschichtet nach Bewertung (makellos=grün sonst=rot). 


