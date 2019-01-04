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
  dplyr::filter(sepos >= 12) %>%
  dplyr::filter(sold > 0) %>%
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
rm(x)

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
# titanic %>%
#   mutate(child = ifelse(age2 < 18, "yes", "no")) %>%
#   group_by(sex, child, survived) %>%
#   summarise(n=n()) %>%
#   arrange(sex, child, survived)
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
  dplyr::filter(is.na(price) == F) %>%
  group_by(subcat) %>%
  summarise(totalPrice=sum(price)) %>%
  head() 

# step2-2 : compute avg price per type and group by subcat, makellos
ebaynew %>%
  dplyr::filter(is.na(price) == FALSE) %>%
  group_by(subcat, makellos) %>%
  summarise(avgPrice=mean(price)) %>%
  arrange(subcat, makellos)

# can we get a plot??
plot.new()

boxplot(price ~ subcat, 
        data = ebaynew,
        subset = makellos == TRUE, 
        las = 2,
        main = "ebay",
        xlab = "type",
        ylab = "avg price")


boxplot(price ~ subcat, 
        data = ebaynew,
        subset = ebaynew$makellos == TRUE, 
        las = 2,
        main = "ebay",
        xlab = "type",
        ylab = "avg price")

boxplot(price ~ subcat, 
        data = ebaynew,
        subset = subcat == " Nokia 6230 (3)", 
        add = TRUE)

boxplot(len ~ dose, 
        data = ToothGrowth, 
        add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", 
        col = "orange")

legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))

z <- rep(rep(1:3, each=5), 2)
z

pricing <- ebay %>%
  dplyr::select(model = subcat,
         price = price) %>%
  mutate(rating = ebay$sepos - ebay$seneg) %>% 
  filter(ebay$sepos >= 12, !is.na(price)) %>% 
  arrange(model, desc(rating))


pricing <- ebay %>%
  dplyr::select(model = subcat,
         price = price) %>%
  mutate(rating = (ebay$sepos - ebay$seneg)/ebay$sepos) %>%
  mutate(makellos = ifelse((rating) > 0.98, TRUE, FALSE)) %>% 
  mutate(categorie = str_replace(model, "\\ \\(\\d+\\)", "")) %>% 
  filter(ebay$sepos >= 12, !is.na(price)) %>% 
  arrange(model, desc(rating))

head(pricing)

head(pricing)

tmp <- droplevels(ebay)
tmp

?droplevels

# demo : droplevels
aq <- transform(airquality, Month = factor(Month, labels = month.abb[5:9]))
aq <- subset(aq, Month != "Jul")
table(           aq $Month)
table(droplevels(aq)$Month)

plot.new()
boxplot(pricing$price ~ pricing$categorie,
        boxwex = 0.25, 
        at = 1:7 - 0.2,
        data = pricing,
        subset = pricing$makellos == TRUE,
        main = "Mobile phone",
        col = "green",
        xlim = c(0.5, 7.5), 
        ylim = c(50, 400),
        yaxs = "i",
        ylab = "Price",
        las=3,
        yaxt = "n"
)

plot.new()
boxplot(pricing$price ~ pricing$categorie,
        boxwex = 0.25, 
        at = 1:7 - 0.2,
        data = pricing,
        subset = pricing$makellos == TRUE,
        main = "Mobile phone",
        col = "green",
        xlim = c(0.5, 7.5), 
        ylim = c(50, 400),
        yaxs = "i",
        ylab = "Price",
        las=3,
        yaxt = "n"
)

head(pricing)
head(ebaynew2)

nrow(pricing)
nrow(ebaynew2)

# new versiton
ebaynew2 <- ebay %>%
  dplyr::filter(sepos >= 12) %>%
  dplyr::filter(sold > 0) %>%
  mutate(
    rating =  sepos / (seneg + sepos),
    makellos = rating > 0.98
  ) %>%
  dplyr::select(price, model = subcat , rating, makellos)

head(pricing)
head(ebaynew2)

str(pricing)

plot.new()
boxplot(ebaynew2$price ~ ebaynew2$model2,
        boxwex = 0.25, 
        at = 1:7 - 0.2,
        data = ebaynew2,
        subset = ebaynew2$makellos == TRUE,
        main = "Mobile phone",
        col = "green",
        xlim = c(0, 8), 
        ylim = c(50, 350),
        yaxs = "i",
        ylab = "Price",
        las=3,
        yaxt = "n"
)

boxplot(ebaynew2$price ~ ebaynew2$model2,
        col = "orange",
        boxwex = 0.25, 
        at = 1:7 + 0.2,
        data = ebaynew2,
        subset = ebaynew2$makellos == F,
        las=3,
        add = T
)


?boxplot

factors(pricing$model)

Filter(is.factor, ebaynew2)

levels(pricing$model)
levels(ebaynew2$model)
ebaynew2$model2 <- droplevels(ebaynew2$model)

head(ebaynew2)
levels(ebaynew2$model2)

