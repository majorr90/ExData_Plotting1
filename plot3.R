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

## First FUN creates a scatter plot. Second through fourth FUN adds the lines. Legend FUN adds legend.
with(data,{
  plot(DateTime,Sub_metering_1,pch=NA,xlab=NA,ylab="Energy sub metering")
  lines(DateTime,Sub_metering_1)
  lines(DateTime,Sub_metering_2,col="Red")
  lines(DateTime,Sub_metering_3,col="Blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"))
})

## Copies to PNG
dev.copy(png,file="plot3.png",width=480,height=480)
dev.off()