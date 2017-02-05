## Downloads subset of file for Feb 1-2, 2007
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method="curl")
dateDownloaded <- date()
data <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",skip=66637,nrows=2880,na.strings="?")
header <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",nrows=1)
unlink(temp)
colnames(data) <- unlist(header)

## Creates density histogram
hist(data$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main="Global Active Power",col="red")

## Copies to PNG
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()