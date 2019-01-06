##########################################################
# Recherche	webscrapping
##########################################################

library(dplyr)
library(foreign)

#========================================================
# save file locally

Sys.Date()

today <- Sys.Date()
filename <- paste("ebay-", today, ".dta", sep="")

today + "test"
append("a", "b")

#========================================================
# load data from https://de.wikipedia.org/wiki/Bern#Klima
library(rvest)
url <- "https://de.wikipedia.org/wiki/Bern#Klima"

# don't work : proxy
# data <- read_html(url)
download.file(url, destfile = 'bern-klima.html')
bern.klima <- read_html('bern-klima.html')

klima.data <- html_table(bern.klima,fill=TRUE,header=TRUE)[[6]]

#========================================================
# task 1 : only 3 first lines
klima.data.1 <- klima.data[1:2,]
klima.data.1

klima.data.1$Jan


weather <- read.table("https://raw.githubusercontent.com/justmarkham/tidy-data/master/data/weather.txt", header=TRUE)
head(weather) # hier sind Variablen in Zeilen und Spaltenweather1 <- melt(weather, id=c("id", "year", "month", "element"), na.rm=TRUE)

# Daten reshapen (melt) und Missings löschen
library(reshape2) # für melt()/dcast()
weather1 <- melt(weather, id=c("id", "year", "month", "element"), na.rm=TRUE)
head(weather1)

?melt
library(MASS)
head(mtcars)
tmp1 <- melt(mtcars, id=c("mpg", "hp"))
head(tmp1)

head(klima.data.1)

klima.data.2 <- t(klima.data.1)

klima.data.2[3,]

klima.data.2["Jan",]

colnames(klima.data.2)
rownames(klima.data.2)
str(klima.data.2)
?strtoi

as.numeric("111.2")
       
klima.data.2[1,]

names <- c("min", "max")

colnames(klima.data.2) <- names 

klima.data.2

klima.data.3 <- klima.data.2[-c(1,14),]

for (i in 1:12)
klima.data.4 <- as.numeric(klima.data.3)

klima.data.3
