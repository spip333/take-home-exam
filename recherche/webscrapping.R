
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

# transpose
klima.data.2 <- t(klima.data.1)

# remove unused rows
klima.data.3 <- klima.data.2[-c(1,14,15),]

klima.data.3

for (i in 1:12){
  for (j in 1:2){
    klima.data.3[i,j] <- str_replace(klima.data.3[i,j], ",", ".")
  }
}

colnames(klima.data.3) <- c("Max", "Min")

klima.data.3

klima.data.df <- as.data.frame(klima.data.3)

klima.data.df
str(klima.data.df)

klima.data.df$Min <- as.numeric(as.character(klima.data.df$Min))
klima.data.df$Max <- as.numeric(as.character(klima.data.df$Max))

klima.data.df
str(klima.data.df)

rownames(klima.data.df) <- c("Januar", "Februar", "März", "April", "Mai", "Juni",
                             "Juli", "August", "September", "Oktober", "November", "Dezember" )

klima.data.df

library("kableExtra")

kable(klima.data.df)
