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

# We need to change the "Date" Column to "Date Type"!
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# We just need the data over the course of two days.
# So that we have to Filter Dates for 2007-02-01 and 2007-02-02
powerDT <- powerDT[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Here we open a png graphic file device, with a give width and height
png("plot1.png", width=480, height=480)

## Plot 1
hist(powerDT[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
# Close the graphic file device
dev.off()