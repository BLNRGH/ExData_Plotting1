library(data.table)

# read in data from 1/2/2007 and 2/2/2007
data <- fread(input = 'grep -e "^[1-2]/2/2007" "household_power_consumption.txt"', sep = ";", header=TRUE, na.strings = "?")

# set column names
setnames(data, c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# write to png
png("plot2.png", width=504, height=504)

# plot
# class(data$Global_active_power) - already numeric
plot(datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# stop writing to png
dev.off()
