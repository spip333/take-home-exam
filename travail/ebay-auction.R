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
# ebay <- read.dta("http://www.farys.org/daten/ebay.dta")
ebay <- read.dta("./data/ebay.dta")

#========================================================
# filter out rows where sepos < 12, 
# add a column "rating" and a column "makellos"
transformed.ebay <- ebay %>%
  dplyr::filter(sepos >= 12) %>%
  dplyr::filter(sold > 0) %>%
  mutate(
    rating =  sepos / (seneg + sepos),
    makellos = rating > 0.98
  ) %>%
  dplyr::select(price, model = subcat , rating, makellos)
#========================================================
# drop unused levels
head(transformed.ebay)
str(transformed.ebay)
transformed.ebay$type <- droplevels(transformed.ebay$model)
#========================================================
# plot...
plot.new()
boxplot(transformed.ebay$price ~ transformed.ebay$type,
        boxwex = 0.25, 
        at = 1:7 - 0.2,
        data = transformed.ebay,
        subset = transformed.ebay$makellos == TRUE,
        main = "Mobile phone",
        col = "green",
        xlim = c(0, 8), 
        ylim = c(50, 350),
        yaxs = "i",
        ylab = "Price",
        las=3,
        yaxt = "n"
)

boxplot(transformed.ebay$price ~ transformed.ebay$type,
        col = "orange",
        boxwex = 0.25, 
        at = 1:7 + 0.2,
        data = transformed.ebay,
        subset = transformed.ebay$makellos == F,
        las=3,
        add = T
)




