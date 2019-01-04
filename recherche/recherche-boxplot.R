##########################################################
# Recherche	boxplot
##########################################################

# example https://www.r-bloggers.com/box-plot-with-r-tutorial/
# generate measure data for 4 stations for 3 consecutive days
data<-data.frame(Stat11=rnorm(100,mean=3,sd=2),
                 Stat21=rnorm(100,mean=4,sd=1),
                 Stat31=rnorm(100,mean=6,sd=0.5),
                 Stat41=rnorm(100,mean=10,sd=0.5),
                 Stat12=rnorm(100,mean=4,sd=2),
                 Stat22=rnorm(100,mean=4.5,sd=2),
                 Stat32=rnorm(100,mean=7,sd=0.5),
                 Stat42=rnorm(100,mean=8,sd=3),
                 Stat13=rnorm(100,mean=6,sd=0.5),
                 Stat23=rnorm(100,mean=5,sd=3),
                 Stat33=rnorm(100,mean=8,sd=0.2),
                 Stat43=rnorm(100,mean=4,sd=4))
boxplot(data)

# draw station name label vertically
boxplot(data, las=2)


# map station names
boxplot(data, 
        las = 2, 
        names = c("Station 1","Station 2","Station 3","Station 4",
                                 "Station 1","Station 2222222222222222222222","Station 3","Station 4",
                                 "Station 1","Station 2","Station 3","Station 4"))

# increase window size if names are too long
# for setting margins : see https://www.r-bloggers.com/setting-graph-margins-in-r-using-the-par-function-and-lots-of-cow-milk/
# args are bottom - left - top - right
boxplot(data, 
        las = 2, 
        par(mar = c(12, 5, 4, 2)+ 0.1),
        names = c("Station 1","Station 2","Station 3","Station 4",
                   "Station 1","Station 2","Station 3","Station 4",
                   "Station 1","Station 2","Station 3","Station 4"))

#  use the option at to  specify the position, along the X axis, of each box-plot:
boxplot(data, 
        las = 2, 
        at =c(1,2,3,4, 6,7,8,9, 11,12,13,14), 
        par(mar = c(12, 5, 4, 2)+ 0.1),
        names = c("Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4"))

