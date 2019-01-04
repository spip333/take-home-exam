##########################################################
# Demo boxplot
# 
# example taken from https://www.r-bloggers.com/box-plot-with-r-tutorial/
#
##########################################################


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
                                 "Station 1","Station 2","Station 3","Station 4",
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

# add colors
my.col <- c("red","sienna","palevioletred1","royalblue2",
            "red","sienna","palevioletred1","royalblue2",
            "red","sienna","palevioletred1","royalblue2")

boxplot(data, 
        las = 2, 
        col=my.col,
        at =c(1,2,3,4, 6,7,8,9, 11,12,13,14), 
        par(mar = c(12, 5, 4, 2)+ 0.1),
        names = c("Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4"))

# labels
boxplot(data, 
        las = 2, 
        col=my.col,
        xlab ="Time",
        ylab ="Oxigen (%)", 
        at =c(1,2,3,4, 6,7,8,9, 11,12,13,14), 
        par(mar = c(12, 5, 4, 2)+ 0.1),
        names = c("Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4"))

# improve labels position with mtext
# mtext(“Label”, side = 1, line = 7)
# the option side takes an integer between 1 and 4, with these meaning: 1=bottom, 2=left, 3=top, 4=right
plot.new()

boxplot(data, 
        las = 2, 
        col=my.col,
        at =c(1,2,3,4, 6,7,8,9, 11,12,13,14), 
        par(mar = c(12, 5, 4, 2)+ 0.1),
        names = c("Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4",
                  "Station 1","Station 2","Station 3","Station 4"))
mtext("Time2", side = 1, line = 10, cex = 2, font = 8)
mtext("Oxigen (%)", side = 2, line = 3, cex = 2, font = 8)

##########################################################
# Full example

data <- data.frame(Stat11=rnorm(100,mean=3,sd=2), 
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

plot.new()

boxplot(data,  
        las = 2,  
        col = c("red","sienna","palevioletred1","royalblue2","red","sienna","palevioletred1","royalblue2","red","sienna","palevioletred1","royalblue2"), 
        at = c(1,2,3,4, 6,7,8,9, 11,12,13,14), 
        par(mar = c(12, 5, 4, 2) + 0.1),  
        names = c("","","","","","","","","","","",""), 
        ylim=c(-6,18))

#Station labels
mtext("Station1", side=1, line=1, at=1, las=2, font=1, col="red")
mtext("Station2", side=1, line=1, at=2, las=2, font=2, col="sienna")
mtext("Station3", side=1, line=1, at=3, las=2, font=3, col="palevioletred1")
mtext("Station4", side=1, line=1, at=4, las=2, font=4, col="royalblue2")
mtext("Station1", side=1, line=1, at=6, las=2, font=1, col="red")
mtext("Station2", side=1, line=1, at=7, las=2, font=2, col="sienna")
mtext("Station3", side=1, line=1, at=8, las=2, font=3, col="palevioletred1")
mtext("Station4", side=1, line=1, at=9, las=2, font=4, col="royalblue2")
mtext("Station1", side=1, line=1, at=11, las=2, font=1, col="red")
mtext("Station2", side=1, line=1, at=12, las=2, font=2, col="sienna")
mtext("Station3", side=1, line=1, at=13, las=2, font=3, col="palevioletred1")
mtext("Station4", side=1, line=1, at=14, las=2, font=4, col="royalblue2")
#Axis labels
mtext("Time", side = 1, line = 6, cex = 2, font = 3)
mtext("Oxigen (%)", side = 2, line = 3, cex = 2, font = 3)
#In-plot labels
text(1,-4,"*", cex=1, font=3)
text(6,-4,"*", cex=1, font=3)
text(11,-4,"*", cex=1, font=3)
text(2,9,"A",cex=0.8,font=3)
text(7,11,"A",cex=0.8,font=3)
text(12,15,"A",cex=0.8,font=3)        



