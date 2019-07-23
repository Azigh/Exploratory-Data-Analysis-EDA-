install.packages("ggplot2", dependencies = TRUE)
library("ggplot2")
library("data.table")

NEI <- data.table::as.data.table(readRDS("summarySCC_PM25.rds"))

# Subset NEI data by Baltimore City, Maryland
baltimoreNEI <- NEI[fips=="24510",]

png("plot3.png")

ggplot(baltimoreNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw()+guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y="Total PM25 Emission (Tons)") + 
  labs(title="PM25 Emissions, Baltimore City 1999-2008 by Source Type")
dev.off()

