rm(list=ls())
library(data.table)

# read in the entire dataset
dt = fread("household_power_consumption.txt", colClasses = "character")

# check the structure of the dataset
str(dt)

# convert the character Date to Date objects
dt$Date = as.Date(dt$Date, "%d/%m/%Y")

# get the subset between 2007-02-01 and 2007-02-02
dt = subset(dt, Date >= "2007-02-01" & Date <= "2007-02-02")

# convert the character Global_active_power to numeric
dt$Global_active_power = as.numeric(dt$Global_active_power)

# create a new timestamp variable in the form of "%Y-%m-%d %H:%M:%S"
Time_Stamp = strptime(paste(as.character(dt$Date), dt$Time, sep = " "), format = "%Y-%m-%d %H:%M:%S")

# add the time stamp to the dt
dt = cbind(dt, Time_Stamp)

# genereate plot and save to plot4.png

png("plot4.png")
par(mfcol=c(2,2))

plot(dt$Time_Stamp, dt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(dt$Time_Stamp, dt$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(dt$Time_Stamp, dt$Sub_metering_2, col = "red")
lines(dt$Time_Stamp, dt$Sub_metering_3, col = "blue")
legend("topright", legend = c(colnames(dt)[7:9]), 
       col = c("black", "red", "blue"), lty = rep(1,3),
       bty = "n")

plot(dt$Time_Stamp, dt$Voltage, type = "l", xlab = "datetime")

plot(dt$Time_Stamp, dt$Global_reactive_power, type = "l", xlab = "datetime")
dev.off()

par(mfcol = c(1,1))

