## Downloads subset of file for Feb 1-2, 2007
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,method="curl")
dateDownloaded <- date()
data <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",skip=66637,nrows=2880,na.strings="?")
header <- read.table(unz(temp,"household_power_consumption.txt"),sep=";",nrows=1)
unlink(temp)
colnames(data) <- unlist(header)

## Adds new column with datetime
data$DateTime <- strptime(with(data,paste(Date,Time)),format="%d/%m/%Y %H:%M:%S")

## First FUN creates a scatter plot. Second FUN adds the lines
with(data,{
  plot(DateTime,Global_active_power,type="n",ylab="Global Active Power (kilowatts)",xlab=NA)
  lines(DateTime,Global_active_power)
})

## Copies to PNG
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()