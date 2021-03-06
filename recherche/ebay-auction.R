##########################################################
# ebay -auction	
##########################################################

library(dplyr)
library(foreign)
library(stringr)

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
    model = str_trim(sub("\\(.+\\)", "", subcat)),
    rating =  sepos / (seneg + sepos),
    makellos = rating > 0.98
  ) %>%
  dplyr::select(price, model, rating, makellos, listpic)
#========================================================
str(transformed.ebay)

#========================================================
# plot...
#pdf("ebayMobilAuktion.pdf")

plot.new()

boxplot(transformed.ebay$price ~ transformed.ebay$model,
        boxwex = 0.25, 
        at = 1:7 - 0.2,
        par(mar = c(9, 5, 4, 2)+ 0.1),
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

boxplot(transformed.ebay$price ~ transformed.ebay$model,
        col = "red",
        boxwex = 0.25, 
        at = 1:7 + 0.1,
        data = transformed.ebay,
        subset = transformed.ebay$makellos == F,
        las=2,
        add = T
)

legend("bottomleft", c("Verkäufer mit makellos ratings (über 98 % positive ratings)", 
                     "Verkäufer mit weniger als 98 % positive ratings"),bty="n",
       text.font = 1,
       fill = c("green", "red"))

mtext("Time", side = 1, line = 7, cex = 1, font = 1)


?legend


#dev.off()

################################################################
# Modell 1 soll als Prädiktoren den Modelltyp und das Rating beinhalten.   

model.1 <- lm(price ~ model + rating, data = transformed.ebay)
summary(model.1)
coef(model.1)

model.2 <- lm(price ~ model + rating + listpic, data = transformed.ebay)
summary(model.2)
coef(model.2)

# Haben das Rating und die Thumbnails einen Einfluss auf den Verkaufspreis? 
# Antwort: Ja, die Verkaufspreise beeinflussen den verkaufspreis mit dem
#          Koeffizienzintervall von 6.73 

# Exportieren Sie eine Regressionstabelle, die beide Modelle beinhaltet.
library(stargazer)
stargazer(model.1, model.2, type = "html", style = "default", out = "model.htm")



