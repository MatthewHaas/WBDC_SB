# 16 January 2019
# WBDC screening for C. sativus isolates ND90Pr and ND93-1

# Load data.table package
library(data.table)

# Read in data
fread("190110_WBDC_SB_rating_raw_data.csv") -> data

# ND90Pr Replicate 1

# Select only one replicate of one isolate.
# Entry_Type=="sample" removes checks from data table so they don't confound the distribution
data[Isolate == "ND90Pr" & Entry_Type == "sample" & Replicate == 1] -> x

# Group by IR and remove NA samples
x[, .N, by=IR_For_Analysis] -> y
y[order(IR_For_Analysis)] -> y
y[IR_For_Analysis != "NA"] -> y

# Insert IR values that exist on the scale (1-9) but have values of zero so are not in the data set.
# This is important for comparison across multiple plots
z <- data.table(IR_For_Analysis=c(1.0, 1.5, 2.0, 8.0), N=c(0,0,0,0))
rbind(y,z) -> y
y[order(IR_For_Analysis)] -> y

# ND90Pr Replicate 2

# Select only one replicate of one isolate.
# Entry_Type=="sample" removes checks from data table so they don't confound the distribution
data[Isolate == "ND90Pr" & Entry_Type == "sample" & Replicate == 2] -> xx

# Group by IR and remove NA samples
xx[, .N, by=IR_For_Analysis] -> yy
yy[order(IR_For_Analysis)] -> yy
yy[IR_For_Analysis != "NA"] -> yy

# Insert IR values that exist on the scale (1-9) but have values of zero so are not in the data set.
# This is important for comparison across multiple plots
zz <- data.table(IR_For_Analysis=c(1.0, 1.5, 2.0, 8.0, 9.0), N=c(0,0,0,0,0))
rbind(yy,zz) -> yy
yy[order(IR_For_Analysis)] -> yy

# ND93-1 Replicate 1

# Select only one replicate of one isolate.
# Entry_Type=="sample" removes checks from data table so they don't confound the distribution
data[Isolate == "ND93-1" & Entry_Type == "sample" & Replicate == 1] -> a

# This fixes a typo that should be fixed permanently in source file.
a[IR_For_Analysis == 3.4, IR_For_Analysis := 3.5]

# Group by IR and remove NA samples
a[, .N, by=IR_For_Analysis] -> b
b[order(IR_For_Analysis)] -> b
b[IR_For_Analysis != "NA"] -> b

# Insert IR values that exist on the scale (1-9) but have values of zero so are not in the data set.
# This is important for comparison across multiple plots
c <- data.table(IR_For_Analysis=c(1.0, 1.5, 7.0, 7.5, 8.0, 8.5, 9.0), N=c(0,0,0,0,0,0,0))
rbind(b,c) -> b
b[order(IR_For_Analysis)] -> b

# ND93-1 Replicate 2

# Select only one replicate of one isolate.
# Entry_Type=="sample" removes checks from data table so they don't confound the distribution
data[Isolate == "ND93-1" & Entry_Type == "sample" & Replicate == 2] -> aa

# Group by IR and remove NA samples
aa[, .N, by=IR_For_Analysis] -> bb
bb[order(IR_For_Analysis)] -> bb
bb[IR_For_Analysis != "NA"] -> bb

# Insert IR values that exist on the scale (1-9) but have values of zero so are not in the data set.
# This is important for comparison across multiple plots
cc <- data.table(IR_For_Analysis=c(1.0, 1.5, 2.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0), N=c(0,0,0,0,0,0,0,0,0))
rbind(bb,cc) -> bb
bb[order(IR_For_Analysis)] -> bb

# Make the plot
# File name reflects date, wild barley diversity collection, disease (spot blotch), and IR=infection response
pdf("190116_WBDC_SB_IR_distribution_plots.pdf")
par(oma=c(0,0,5,0))
layout(matrix(c(1:4), nrow=2, byrow=TRUE), width=c(12,12), height=c(5,5))

# ND90Pr Replicate 1
y[, barplot(N, main = paste0("Isolate ND90Pr", "\n", "Replicate 1"), cex.axis=0.9, xlab="Infection Response", ylab="Frequency", ylim=c(0,80), xaxt="n", yaxt="n", cex.main=0.8)]

# Midpoints from barplot() are used because when I use names.arg, the tick mark labels are unpredictable (probably due to space constraints). I wanted only round numbers which I achieved using the next line of code
axis(1, at=c(0.7, 3.1, 5.5, 7.9, 10.3, 12.7, 15.1, 17.5, 19.9), labels=c(1,2,3,4,5,6,7,8,9))
axis(2, las=1) # y-axis tick mark labels perpendicular to axis (easier to read)

# ND90Pr Replicate 2
yy[, barplot(N, main = paste0("Isolate ND90Pr", "\n", "Replicate 2"), cex.axis=0.9, xlab="Infection Response", ylab="Frequency", ylim=c(0,80), xaxt="n", yaxt="n", cex.main=0.8)]
axis(1, at=c(0.7, 3.1, 5.5, 7.9, 10.3, 12.7, 15.1, 17.5, 19.9), labels=c(1,2,3,4,5,6,7,8,9))
axis(2, las=1)

# ND93-1 Replicate 1
b[, barplot(N, main = paste0("Isolate ND93-1", "\n", "Replicate 1"), cex.axis=0.9, xlab="Infection Response", ylab="Frequency", ylim=c(0,80), xaxt="n", yaxt="n", cex.main=0.8)]
axis(1, at=c(0.7, 3.1, 5.5, 7.9, 10.3, 12.7, 15.1, 17.5, 19.9), labels=c(1,2,3,4,5,6,7,8,9))
axis(2, las=1)

# ND93-1 Replicate 2
b[, barplot(N, main = paste0("Isolate ND93-1", "\n", "Replicate 2"), cex.axis=0.9, xlab="Infection Response", ylab="Frequency", ylim=c(0,80), xaxt="n", yaxt="n", cex.main=0.8)]
axis(1, at=c(0.7, 3.1, 5.5, 7.9, 10.3, 12.7, 15.1, 17.5, 19.9), labels=c(1,2,3,4,5,6,7,8,9))
axis(2, las=1)

# Add a main title over all four plots
# I wanted two lines for the title and I found it hard to combine all of the desired elements with one line of code (especially since getting the italic font for the Latin Binomial was tricky--required substitute+italic but did not work with paste0)
mtext(paste0("Wild Barley Diversity Collection", "\n"), side=3, outer = TRUE, cex=1.1)
mtext(substitute(paste("Spot blotch (", italic("Cochliobolus sativus"), ") Screening")), side=3, outer = TRUE, cex=1.1)

dev.off()
