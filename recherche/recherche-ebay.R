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
tmp <- is.na(ebaynew$rating)
tmp[tmp==T] # OK: Zero
tmp[tmp==F]
rm (tmp)

# check that we have only T / F in makellos
str(ebaynew)
nrow(ebaynew[ebaynew$makellos==TRUE,])
nrow(ebaynew[ebaynew$makellos==FALSE,])
nrow(ebaynew) == nrow(ebaynew[ebaynew$makellos==TRUE,]) + nrow(ebaynew[ebaynew$makellos==FALSE,])

#========================================================
# variable makellos
# ebay$makellos <- ebay$rating >= 0.98

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

# finde den mittleren preis per typ
head(ebaynew)

# from titanic sample...
titanic %>%
  mutate(child = ifelse(age2 < 18, "yes", "no")) %>%
  group_by(sex, child, survived) %>%
  summarise(n=n()) %>%
  arrange(sex, child, survived)
#...

# finde den mittleren preis per typ: using group by type
ebaynew %>%
  group_by(subcat) %>%
  summarise(tot=sum(price)) %>%
  head() 
# ... -> don't work : price NA. why??

# finde how many sold of one type?den mittleren preis per typ: using group by type
ebaynew %>%
  filter(subcat == "Sony T610 (1)") %>% 
  filter(sold != 0) %>% 
  dplyr::select(sold) %>%
  sum()

# does sum in the data values works when there are na ?
x1 <- c("andy", "bernie", "andy", "cliff", "alice", "alice", "frank", "debbie", "frank")
y1 <- c(NA,3,2,5,NA,6,6,4,5)

mydata <- data.frame(x1, y1) 
mydata

mydata %>%
  group_by(x1) %>%
  summarise(tot = sum(y1)) %>%
  head()
# sum returns NA when one data is NA

# finde den mittleren preis per typ: using group by type
ebaynew %>%
  group_by(subcat) %>%
  summarise(tot=sum(price)) %>%
  head() 
# the above doesn't work, because sum returns NA when one data is NA
# .. but the following will work:
sum(ebaynew$price, na.rm = T)
# fact: exlude rows where price is null

# finde den mittleren preis per typ (second try): using group by type, excluding not sold items
# step1 : filter out not sold items
ebaynew %>%
  dplyr::filter(is.na(price) == F) %>%
  nrow

# step2-1 : compute total price per type 
ebaynew %>%
  dplyr::filter(is.na(price) == FALSE) %>%
  group_by(subcat) %>%
  summarise(totalPrice=sum(price)) %>%
  head() 

# step2-2 : compute avg price per type and group by subcat, makellos
theData <- ebaynew %>%
  dplyr::filter(is.na(price) == FALSE) %>%
  group_by(subcat, makellos) %>%
  summarise(avgPrice=mean(price)) %>%
  arrange(subcat, makellos)
  
# can we get a plot??
plot.new()

boxplot(avgPrice ~ subcat, 
        data = theData,
        subset = makellos == T, 
        main = "ebay",
        xlab = "type",
        ylab = "avg price")

boxplot(len ~ dose, 
        data = ToothGrowth, 
        add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", 
        col = "orange")

legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))



?boxplot
