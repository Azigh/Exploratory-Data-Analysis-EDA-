#First we load the required library (data.table) to read the data set
library("data.table")

# Set the directory to where the dataset is located.
# Then read in dataset from the given .txt file. as noted in the problem
# description, in this dataset missing values are coded as "?".
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")


# POSIXct is used to representing calendar dates and times. By converting data and time to POSIXct
# data, we try to make them capable of graphically be shown by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# We just need the data over the course of two days.
# So that we have to Filter Dates from 2007-02-01 to 2007-02-02
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Here we open a png graphic file device, with a give width and height
png("plot3.png", width=480, height=480)

# Plot 3
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2],col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=1, lwd=1)

# Close the graphic file device
dev.off()







