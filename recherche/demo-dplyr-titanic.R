##########################################################
# Demo dplyr from script chap. 16.3
# 
#
##########################################################

# install.packages("dplyr")
library(dplyr)

##########################################################
# titanic example
#
# load data
titanic <- read.dta("http://www.stata-press.com/data/kkd/titanic2.dta")

head(titanic)

# filter
filter(titanic, class == "1st class", age2 < 18)

# alos ok
titanic %>%
  filter(age2 < 18) %>%
  filter(class == "1st class") %>%
  nrow

# konventionell wäre das komplizierter:
titanic[titanic$class == "1st class" & titanic$age2 < 18, ]

# zusätzlich Spalten selektieren:
titanic %>%
  filter(class == "1st class", age2 < 18) %>%
  dplyr::select(age2) %>%
  head()

# zusätzlich Spalten selektieren:
titanic %>%
  filter(class == "1st class", age2 < 18) %>%
  dplyr::select(theAge = age2, theGender =sex,  class) %>%
  head()

# neue Variable "child" bauen
titanic %>%
  mutate(child = age2 < 18) %>%
  head()

# Auszählen wer gestorben ist nach Geschlecht und Kind (ja/nein)
titanic %>%
  mutate(child = ifelse(age2 < 18, "yes", "no")) %>%
  group_by(sex, child, survived) %>%
  summarise(count=n()) %>%
  arrange(sex, child, survived)

##########################################################
# allbus example
# 
# Daten laden
allbus <- read.dta("http://www.farys.org/daten/allbus2008.dta", convert.factors=FALSE)

allbus.agg <- allbus %>%
  dplyr::select(geschlecht = v151, # die drei Variablen wählen und direkt umbenennen
         alter = v154,
         einkommen = v386) %>%
  filter(einkommen < 99997, alter < 999) %>% # fehlende Werte droppen
  group_by(geschlecht, alter) %>% # gruppieren
  summarise(m_einkommen = mean(einkommen)) # aggregieren

# Zusatz: Das ganze könnte man jetzt grafisch anschauen (müsste man ggf. etwas gröber gruppieren)
library(ggplot2)  
ggplot(allbus.agg, aes(x=alter,y=m_einkommen,color=geschlecht)) +
  geom_line()

