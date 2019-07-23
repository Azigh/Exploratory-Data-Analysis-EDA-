install.packages("ggplot2", dependencies = TRUE)
library("ggplot2")
library("data.table")

NEI <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

# We need to Subset the vehicles NEI data to Baltimore and Los Angeles fips:
baltimoreNEI <- NEI[fips=="24510",]
LANEI <- NEI[fips=="06037",]

# Gather the subset of the NEI data which corresponds to vehicles
vehiclerelated <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC [vehiclerelated, SCC]

baltimoreVehiclesNEI <- baltimoreNEI[baltimoreNEI[, SCC] %in% vehiclesSCC]   
baltimoreVehiclesNEI[, city := c("Baltimore City")]
LAVehiclesNEI <- LANEI[LANEI[, SCC] %in% vehiclesSCC]
LAVehiclesNEI[, city := c("Los Angeles")]

# Create one data.able by Combining data.tables
bothNEI <- rbind(baltimoreVehiclesNEI,LAVehiclesNEI)

png("plot6.png")

ggplot(bothNEI, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(.~city, scales="free", space="free") +
  labs(x="year", y="Total PM25 Emission") + 
  labs(title="PM25 Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008")

dev.off()