install.packages("ggplot2", dependencies = TRUE)
library("ggplot2")
library("data.table")

NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# We need to Subset the vehicles NEI data to Baltimore's fip
baltimoreNEI <- NEI[fips=="24510",]
# Gather the subset of the NEI data which corresponds to vehicles
vehiclerelated <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC [vehiclerelated, SCC]

baltimoreVehiclesNEI <- baltimoreNEI[baltimoreNEI[, SCC] %in% vehiclesSCC]                         


png("plot5.png")

ggplot(baltimoreVehiclesNEI,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#009E73" ,width=0.75) +
  labs(x="year", y="Total PM25 Emission") + 
  labs(title= "PM25 Motor Vehicle Source Emissions in Baltimore from 1999-2008")

dev.off()