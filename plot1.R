# plot1.R
#
# This script reads in power consumptions readings
# and creates a histogram of the minutely Global Active Power consumption
# over a specific two day period.  The graph is then
# saved to a PNG file.

library(data.table)

# read file into a data.table, "?" is the NA character
pwr<-fread("household_power_consumption.txt",na.strings="?")

# filter for only our two specific days
pwr2day<-subset(pwr,Date=="1/2/2007"|Date=="2/2/2007")

# create histogram on the default graphics device
hist(pwr2day$Global_active_power,xlab="Global Active Power (kilowatts)",col="red",main="Global Active Power")

# copy plot to a PNG file
dev.copy(png,"plot1.png",width=480, height=480)

#close PNG graphics device
dev.off()
