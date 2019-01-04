##########################################################
# Demo boxplot
# 
# example taken from helpfile from Roger Bivand
#
#########################################################
head(ToothGrowth)
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
        xlim = c(0, 5), 
        ylim = c(0, 40), 
        yaxs = "i")

boxplot(len ~ dose, 
        data = ToothGrowth, 
        add = TRUE,
        boxwex = 0.25, at = 1:3 + 0.2,
        subset = supp == "OJ", 
        col = "orange")

legend(1, 7, c("Ascorbic acid", "Orange juice"),
       fill = c("yellow", "orange"))

legend(4, 9, c("x", "y"), fill = c("red", "orange"))
