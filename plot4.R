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

## Specifies layout
par(mfrow=c(2,2),mar=c(4,4,0.5,0.5),oma=c(1.5,2,1,1))

## Adds first graph
with(data,{
  plot(DateTime,Global_active_power,type="n",ylab="Global Active Power",xlab=NA,cex.lab=.75,cex.axis=.75)
  lines(DateTime,Global_active_power)
})

## Adds second graph
with(data,{
  plot(DateTime,Voltage,xlab="datetime",pch=NA,cex.lab=.75,cex.axis=.75)
  lines(DateTime,Voltage)
})

## Adds third graph
with(data,{
  plot(DateTime,Sub_metering_1,pch=NA,xlab=NA,ylab="Energy sub metering",cex.lab=.75,cex.axis=.75)
  lines(DateTime,Sub_metering_1)
  lines(DateTime,Sub_metering_2,col="Red")
  lines(DateTime,Sub_metering_3,col="Blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=.5,bty="n",lty=c(1,1,1),lwd=c(1,1,1),col=c("black","red","blue"))
})

## Adds final graph
with(data,{
  plot(DateTime,Global_reactive_power,xlab="datetime",pch=NA,cex.lab=.75,cex.axis=.75)
  lines(DateTime,Global_reactive_power)
})

## Copies to PNG
dev.copy(png,file="plot4.png",width=480,height=480)
dev.off()