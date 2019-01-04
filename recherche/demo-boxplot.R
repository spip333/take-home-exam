############################################
# boxplot demo and filtering with dplyr
############################################

library(MASS)
library(ggplot2)
library(dplyr)
mtcars
str(mtcars)
class(mtcars)
dim(mtcars)

############################################
# exemple : puissance moyenne selon le nombre de cylindres
cardata <- data.frame(mtcars$cyl, mtcars$hp)

ggplot(cardata, aes(x=mtcars.cyl, y=mtcars.hp, group=mtcars.cyl, fill=mtcars.cyl)) +
  geom_boxplot()

############################################
# recherche et autres exemples
# simple boxplot
boxplot(mtcars$hp, main="Mean hp")

# simple boxplot mit ggplot
ggplot(mtcars, aes(x="", y=mtcars$hp)) + geom_boxplot()

# group by with dplyr
mtcars %>% 
  group_by(cyl) %>% 
  summarize(meanHp = mean(hp), sd=sd(hp))

mtcars %>%
  group_by(cyl) %>%
  summarize(puissance = mean(hp), stddev = sd(hp)) %>%
  arrange(desc(puissance))

############################################
# exemple tiré de 
# https://www.r-graph-gallery.com/265-grouped-boxplot-with-ggplot2/
# create a data frame
variety=rep(LETTERS[1:7], each=40)
treatment=rep(c("high","low"),each=20)
note=seq(1:280)+sample(1:150, 280, replace=T)
data=data.frame(variety, treatment ,  note)

# grouped boxplot
ggplot(data, aes(x=variety, y=note, fill=treatment)) +
  geom_boxplot()

mtcars %>%
  filter(cyl == 8) %>%
  summarize(puissance = mean(hp), xx = sd(hp))

mtcars %>%
  filter(cyl == 8) %>%
  summarize(meanHp = mean(hp), sd = sd(hp))


ggplot(tabhp, aes(x=mhp$cyl, y=mhp$hp, group=mhp$cyl)) + geom_boxplot()

  
############################################
movies <- data.frame(movie = as.factor(c("Movie 1", "Movie 2", "Movie 3", "Movie 4", "Movie 5")), 
                     director = as.factor(c("Dir 1", "Dir 2", "Dir 1", "Dir 3", "Dir 3")), 
                     director_rating =  c(1000, 2000, 1500, 3000, 4000))

movies

movies %>% 
  group_by(director) %>%
  summarize(moyenne = mean(director_rating)) %>%
  arrange(desc(moyenne))
  


############################################
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


x <- c(1,2,3,4,5,6)
y1 <- 2 * x
y2 <- x + 4

boxplot(x, y1, col= "yellow")

boxplot(x, y2, add=T, col="red")


