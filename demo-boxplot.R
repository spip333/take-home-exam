############################################
# boxplot demo
############################################

library(MASS)
Titanic
str(Titanic)
class(Titanic)
dim(Titanic)
Titanic[1:4,,,]


#exemple : age moyen des victimes par class
boxplot(Titanic$Age, main="Mean age of victims")

# Erstellen Sie ein Boxplot für die Pferdestärke (hp=horsepower) mit ggplot
ggplot(mtcars, aes(x="", y=mtcars$hp)) + geom_boxplot()

