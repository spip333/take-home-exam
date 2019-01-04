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

transformed.ebay <- transformed.ebay %>%
  mutate(type = str_replace(type, "\\ \\(\\d+\\)", ""))

#========================================================
# plot...
pdf("ebayMobilAuktion.pdf")

boxplot(transformed.ebay$price ~ transformed.ebay$type,
        boxwex = 0.25, 
        at = 1:7 - 0.2,
        par(mar = c(12, 5, 4, 2)+ 0.1),
        data = transformed.ebay,
        subset = transformed.ebay$makellos == TRUE,
        main = "Mobile phone",
        col = "green",
        xlim = c(0, 8), 
        ylim = c(50, 350),
        yaxs = "i",
        ylab = "Price",
        las=2,
        xaxt = "n",
        yaxt = "n"
)

boxplot(transformed.ebay$price ~ transformed.ebay$type,
        col = "red",
        boxwex = 0.25, 
        at = 1:7 + 0.1,
        data = transformed.ebay,
        subset = transformed.ebay$makellos == F,
        las=2,
        add = T
)

legend("bottomleft", c("Verkäufer mit makellos ratings (über 98 % positive ratings)", 
                     "Verkäufer mit weniger als 98 % positive ratings"), 
       fill = c("green", "red"))

dev.off()



