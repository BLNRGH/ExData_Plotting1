library(data.table)

# read in data from 1/2/2007 and 2/2/2007
data <- fread(input = 'grep -e "^[1-2]/2/2007" "household_power_consumption.txt"', sep = ";", header=TRUE, na.strings = "?")

# set column names
setnames(data, c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# set datetime 
datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# write to png
png("plot4.png", width=504, height=504)

# multi plot
par(mfrow = c(2,2))

# data types already numeric

# plot 1
plot(datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# plot 2
plot(datetime, data$Voltage, type="l", ylab="Voltage")

# plot 3
plot(datetime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(datetime, data$Sub_metering_2, col = "red")
lines(datetime, data$Sub_metering_3, col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(1,1,1), bty = "n")

# plot 4
plot(datetime, data$Global_reactive_power, type="l", ylab = "Global_reactive_power")

# stop writing to png
dev.off()
