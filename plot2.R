# plot2.R
#
# This script reads in power consumptions readings
# and graphs the minutely Global Active Power consumption
# over a specific two day period.  The graph is then
# saved to a PNG file.

library(data.table)

# read file into a data.table, "?" is the NA character
pwr<-fread("household_power_consumption.txt",na.strings="?")

# filter for only our two specific days
pwr2day<-subset(pwr,Date=="1/2/2007"|Date=="2/2/2007")

# get table length for easy reference later
tablelen<-length(pwr2day$Date)

# Sort by Date and Time fields to order in chronological order.
# Sort will be alpha on these char fields
# but that works out to chronological with this dataset --
# so no need to complicate things with String to Date/Time conversions

pwr2day<-pwr2day[order(Date,Time)]

# set margins
par(mar=c(3,4,1,1))

# do plot of y in X-order (which is chronological due to sort)
# suppress x-axis so we can customize below

plot(pwr2day$Global_active_power,type="l",
   ylab="Global Active Power (kilowatts)",
   cex.lab=1.0,cex.axis=1.0,xaxt="n")

# customize X-axis, providing placement/number of ticks and labels
axis(side=1, at=c(1,tablelen/2,tablelen),
    labels=c("Thu","Fri","Sat"),cex.axis=1.0)

# copy plot to a PNG file
dev.copy(png,"plot2.png",width=480, height=480)

#close PNG graphics device
dev.off()
