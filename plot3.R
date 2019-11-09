# plot3.R
#
# This script reads in power consumptions readings
# and graphs the minutely Sub Metering values
# over a specific two day period.  The graph is then
# save to a PNG file.

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
# do not plot points yet, we'll add those later

plot(pwr2day$Sub_metering_1,type="n",
      ylab="Energy sub metering",
      cex.lab=1.0,cex.axis=1.0,xaxt="n")

# customize X-axis, providing placement/number of ticks and labels
axis(side=1, at=c(1,tablelen/2,tablelen),
    labels=c("Thu","Fri","Sat"),cex.axis=1.0)

# now add the three data series to the plot

points(pwr2day$Sub_metering_1,type="l")
points(pwr2day$Sub_metering_2,type="l",col="red")
points(pwr2day$Sub_metering_3,type="l",col="blue")

# add legend 
legend("topright",col=c("black","red","blue"),
      legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,cex=1.0,x.intersp=0.6,y.intersp=0.8,xjust=1.0,xpd=NA)

# copy plot to a PNG file
dev.copy(png,"plot3.png",width=480, height=480)

#close PNG graphics device
dev.off()
