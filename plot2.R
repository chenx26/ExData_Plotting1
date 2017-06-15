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

# genereate plot and save to plot2.png
png("plot2.png")
plot(dt$Time_Stamp, dt$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

