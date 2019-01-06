
##########################################################
# webscrapping	
##########################################################

library(rvest)

#========================================================
# load data from https://de.wikipedia.org/wiki/Bern#Klima
url <- "https://de.wikipedia.org/wiki/Bern#Klima"

# Todo: download
# download.file(url, destfile = 'bern-klima.html')
bern.klima <- read_html('bern-klima.html')
klima.data <- html_table(bern.klima,fill=TRUE,header=TRUE)[[6]]

#========================================================
# task 1 : only 3 first lines
klima.data.1 <- klima.data[1:2,]
klima.data.1
