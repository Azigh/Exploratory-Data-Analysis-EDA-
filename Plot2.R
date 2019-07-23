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
png("plot2.png", width=480, height=480)

## Plot 2
plot(x = powerDT[, dateTime]
     , y = powerDT[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

# Close the graphic file device
dev.off()



