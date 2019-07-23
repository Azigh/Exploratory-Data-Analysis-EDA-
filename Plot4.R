install.packages("ggplot2", dependencies = TRUE)
library("ggplot2")
library("data.table")

NEI <- data.table::as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(readRDS("Source_Classification_Code.rds"))

# Subset coal combustion related NEI data
combustionRelated <- grepl("comb", SCC[, SCC.Level.One], ignore.case=TRUE)
coalRelated <- grepl("coal", SCC[, SCC.Level.Four], ignore.case=TRUE) 
combustionSCC <- SCC[combustionRelated & coalRelated, SCC]
combustionNEI <- NEI[NEI[,SCC] %in% combustionSCC]

png("plot4.png")

ggplot(combustionNEI,aes(x = factor(year),y = Emissions)) +
  geom_bar(stat="identity", fill ="#009E73", width=0.75) +
  labs(x="year", y="Total PM25 Emission ") + 
  labs(title="PM25 Coal Combustion Source Emissions Across US from 1999-2008")

dev.off()