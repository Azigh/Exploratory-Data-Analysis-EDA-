library(data.table)
NEI <- data.table::as.data.table(readRDS("summarySCC_PM25.rds"))

#create a subset of data table NEI
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

totalNEI <- NEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]
png("plot1.png")

#We plot by using barplot to show the comparision among discrete and categorical data
barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")
dev.off()