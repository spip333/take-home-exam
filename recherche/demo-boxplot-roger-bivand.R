##########################################################
# Demo boxplot
# 
# example taken from helpfile from Roger Bivand
#
##########################################################

plot.new()

boxplot(len ~ dose, 
        data = ToothGrowth,
        boxwex = 0.25, 
        at = 1:3 - 0.2,
        subset = supp == "VC", 
        col = "yellow",
        main = "Guinea Pigs' Tooth Growth",
        xlab = "Vitamin C dose mg",
        ylab = "tooth length",
        xlim = c(0.5, 3.5), ylim = c(0, 35), yaxs = "i")

boxplot(len ~ dose, 
        data = ToothGrowth, 
        add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", 
        col = "orange")

legend(2, 9, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))
