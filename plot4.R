# plot4.R
#
# This script reads in power consumptions readings
# and creates 4 graphs of minutely power consumption
# over a specific two day period.  The graphs are then
# save to a PNG file.

library(data.table)

# READ, FILTER & SORT DATA

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

# set graphics device ready for 4 plots in 2 rows X 2 columns
par(mfcol=c(2,2))

# set margins
par(mar=c(4,4,2,2))


# UPPER LEFT PLOT

# do plot of y in X-order (which is chronological due to sort)
# suppress x-axis so we can customize below

plot(pwr2day$Global_active_power,type="l",
   ylab="Global Active Power",
   cex.lab=1.0,cex.axis=1.0,xaxt="n",xlab=NA)

# customize X-axis, providing placement/number of ticks and labels
axis(side=1, at=c(1,tablelen/2,tablelen),
    labels=c("Thu","Fri","Sat"),cex.axis=1.0)


# BOTTOM LEFT PLOT

# Plot each the sub metering series on the same plot

plot(pwr2day$Sub_metering_1,type="n",
      ylab="Energy sub metering",
      cex.lab=1.0,cex.axis=1.0,xaxt="n",xlab="")

# customize X-axis, providing placement/number of ticks and labels
axis(side=1, at=c(1,tablelen/2,tablelen),
    labels=c("Thu","Fri","Sat"),cex.axis=1.0)

# now add the three data series to the plot

points(pwr2day$Sub_metering_1,type="l")
points(pwr2day$Sub_metering_2,type="l",col="red")
points(pwr2day$Sub_metering_3,type="l",col="blue")

# add legend 
legend(x="topright",
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col=c("black","red","blue"),lty=1,bty="n",x.intersp=1.0,y.intersp=1,
	xjust=1,yjust=0,xpd=FALSE,cex=0.7,seg.len=2)


# UPPER RIGHT PLOT

# plot the Voltage similarly as we did with Global Active Power

plot(pwr2day$Voltage,type="l",
   ylab="Voltage", xlab="datetime",
   cex.lab=1.0,cex.axis=1.0,xaxt="n")

# customize X-axis, providing placement/number of ticks and labels
axis(side=1, at=c(1,tablelen/2,tablelen),
    labels=c("Thu","Fri","Sat"),cex.axis=1.0)



# BOTTOM RIGHT PLOT

# plot the  Global Reactive Power similarly as we did with Global Active Power

with(pwr2day,plot(Global_reactive_power,type="l",
   xlab="datetime",
   cex.lab=1.0,cex.axis=1.0,xaxt="n",yaxt="n"))

# customize X-axis, providing placement/number of ticks and labels
axis(side=1, at=c(1,tablelen/2,tablelen),
    labels=c("Thu","Fri","Sat"),cex.axis=1.0)

# customize y-axis, providing placement/number of ticks and labels
axis(side=2, at=c(0.0,0.1,0.2,0.3,0.4,0.5),
    labels=c("0.0","0.1","0.2","0.3","0.4","0.5"),cex.axis=1.0)



# copy all 4 plots to a PNG file
dev.copy(png,"plot4.png",width=480, height=480)

#close PNG graphics device
dev.off()
