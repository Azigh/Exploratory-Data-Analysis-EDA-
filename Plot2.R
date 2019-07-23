library(data.table)
NEI <- data.table::as.data.table(readRDS("summarySCC_PM25.rds"))

#create a subset of data table NEI
NEI[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalNEI <- NEI[fips=='24510', lapply(.SD, sum, na.rm = TRUE)
                , .SDcols = c("Emissions")
                , by = year]
png("plot2.png")
# Using barplots to represent relationship between a numeric variable and a categoric variable
barplot(totalNEI[, Emissions]
        , names = totalNEI[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years in Baltimore City, Maryland")

dev.off()