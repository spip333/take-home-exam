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

# simplify labels
transformed.ebay <- transformed.ebay %>%
mutate(type = str_replace(type, "\\ \\(\\d+\\)", ""))
head(transformed.ebay)
#========================================================
# plot...
plot.new()

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

legend("topright", c("sellers with 98 % or more positive ratings", 
                     "sellers with less than 98 % positive ratings"), 
       fill = c("green", "red"))
################################################################
# Modell 1 soll als Prädiktoren den Modelltyp und das Rating beinhalten.   


# filter out rows where sepos < 12, 
# add a column "rating" and a column "makellos"
transformed.ebay.v2 <- ebay %>%
  dplyr::filter(sepos >= 12) %>%
  dplyr::filter(sold > 0) %>%
  mutate(
    rating =  sepos / (seneg + sepos),
    makellos = rating > 0.98
  ) %>%
  dplyr::select(price, model = subcat , rating, makellos, listpic)


transformed.ebay.v2$type <- droplevels(transformed.ebay$model)

transformed.ebay.v2 <- transformed.ebay.v2 %>%
  mutate(type = str_replace(type, "\\ \\(\\d+\\)", ""))

head(transformed.ebay.v2)

model.1 <- lm(price ~ type + rating, data = transformed.ebay)
summary(model.1)
coef(model.1)

# Modell 2 soll zusätzlich die Variable listpic beinhalten.
model.2 <- lm(price ~ type + rating + listpic, data = transformed.ebay.v2)
summary(model.2)
coef(model.2)

# Haben das Rating und die Thumbnails einen Einfluss auf den Verkaufspreis? 
# Antwort: Ja, die Verkaufspreise beeinflussen den verkaufspreis mit dem
#          Koeffizienzintervall von 6.73 

# Exportieren Sie eine Regressionstabelle, die beide Modelle beinhaltet.
library(stargazer)
stargazer(model.1, model.2, type = "html", style = "qje", out = "model.htm")

# string manip

library(stringr)
str_sub("test", 1, str_length("test")-3)
substring("test", 1, str_length("test")-3)
?instring

? ("")

grep("\\(", "test (1)")

x <- gregexpr(pattern ="\\(","test (1)")
typeof(x)

x

x <- c("This is a sentence about axis", "A second pattern is also listed here")
sub("is", "XY", x)

library (gdata)

str_trim(sub("\\(.+\\)", "", "test (10)"))


###########################################3
# model
install.packages("car")
install.packages("lme4")
install.packages("rgl")

install.packages("packageurl", repos=NULL, type="source")
library(car) 


# alternativ, falls car Probleme mit Abhaenigkeiten macht: 
# Prestige <- read.csv("http://farys.org/daten/Prestige.csv")

# Für folgendes Beispiel brauchen wir jedoch die Funktion scatter3d() aus car. 
# Das Dependency Problem lässt sich ggf. so lösen:
# install.packages("lme4") # dependency für altes pbkrtest

# packageurl <- "https://cran.r-project.org/src/contrib/Archive/pbkrtest/pbkrtest_0.4-4.tar.gz"
# install.packages(packageurl, repos=NULL, type="source") # von hand installieren
# install.packages("car") # jetzt car installieren mit denmanuell installierten dependencies
# library(car)

# Wie kann man sich eine Regression mit zwei erklärenden Variablen vorstellen?
# Als Ebene durch eine 3d Punktewolke!

scatter3d(Prestige$income,Prestige$prestige,Prestige$education, fit="linear") 

fit <- lm(prestige ~ education + income, data=Prestige)

# wie viele Datensätze mit 0 in "sold"?
nrow(ebay)

nrow(ebay [ebay$sold == 0,])

no.sold<- ebay %>%
  dplyr::filter(sold > 0) %>%
  mutate(
    model = str_trim(sub("\\(.+\\)", "", subcat)),
    rating =  sepos / (seneg + sepos),
    makellos = rating > 0.98
  ) %>%
  dplyr::select(price, model, rating, makellos, listpic)