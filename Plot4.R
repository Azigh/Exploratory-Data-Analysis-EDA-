#First we load the required library (data.table) to read the data set
library("data.table")

# Set the directory to where the dataset is located.
# Then read in dataset from the given .txt file. as noted in the problem
# description, in this dataset missing values are coded as "?".
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?")

#Note: Since we just want to work on part of the whole data table, so that it is 
#      beneficiary to call a subset of data table (.SD), and work from there.
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]


# POSIXct is used to representing calendar dates and times. By converting data and time to POSIXct
# data, we try to make them capable of graphically be shown by time of day
powerDT[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# We just need the data over the course of two days.
# So that we have to Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Here we open a png graphic file device, with a give width and height
png("plot4.png", width=480, height=480)


par(mfrow=c(2,2))

# Plot 1
plot(powerDT[, dateTime], powerDT[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(powerDT[, dateTime],powerDT[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(powerDT[, dateTime], powerDT[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerDT[, dateTime], powerDT[, Sub_metering_2], col="red")
lines(powerDT[, dateTime], powerDT[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
) 

# Plot 4
plot(powerDT[, dateTime], powerDT[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")
# Close the graphic file device
dev.off()





