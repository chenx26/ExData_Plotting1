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

# generate histogram of Global_active_power
png("plot1.png")
hist(dt$Global_active_power, xlim = c(0,6), col = "red", 
    main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()

