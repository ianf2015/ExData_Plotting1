##download and unzip data to local directory
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./household_power_consumption.zip")
mydata <- read.csv(unz("./household_power_consumption.zip", "household_power_consumption.txt"),sep=";")

##select relevant data within the range of dates
mydata$Date<-as.Date(mydata$Date,"%d/%m/%Y")
plotdata<-mydata[mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02",] 

##combine date and time into one datetime variable
Datetime=paste(plotdata$Date,plotdata$Time)
plotdata$Datetime<-as.POSIXct(Datetime,format="%Y-%m-%d %H:%M:%S")

## convert variables to numeric,conversion of sub_metering_3 not necessary
plotdata$Global_active_power<-as.numeric(levels(plotdata$Global_active_power))[plotdata$Global_active_power]
plotdata$Global_reactive_power<-as.numeric(levels(plotdata$Global_reactive_power))[plotdata$Global_reactive_power]
plotdata$Voltage<-as.numeric(levels(plotdata$Voltage))[plotdata$Voltage]
plotdata$Sub_metering_1<-as.numeric(levels(plotdata$Sub_metering_1))[plotdata$Sub_metering_1]
plotdata$Sub_metering_2<-as.numeric(levels(plotdata$Sub_metering_2))[plotdata$Sub_metering_2]

##open file device
png(file="plot4.png",width=480,height=480)
par(mfrow=c(2,2),oma=c(0,0,0,0))

##plot global active power against datetime, without plotting x axis
with(plotdata,plot(Datetime,Global_active_power,type="l",ylab="Global Active Power",xlab="",xaxt="n"))
##add x axis plot and label
daterange=c(as.POSIXlt("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S"),as.POSIXlt("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"))

##plot voltage against datetime, without plotting x axis
with(plotdata,plot(Datetime,Voltage,type="l",ylab="Voltage",xlab="datetime",xaxt="n"))
##add x axis plot and label
daterange=c(as.POSIXlt("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S"),as.POSIXlt("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"))


##plot sub meterings against datetime, without plotting x axis
with(plotdata,plot(Datetime,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",xaxt="n"))
with(plotdata,lines(Datetime,Sub_metering_2,col="red"))
with(plotdata,lines(Datetime,Sub_metering_3,col="blue"))
##add x axis plot and label
daterange=c(as.POSIXlt("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S"),as.POSIXlt("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"))
##add legend
legend("topright",lty=c(1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")

##plot global reactive power against datetime, without plotting x axis
with(plotdata,plot(Datetime,Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="datetime",xaxt="n"))
##add x axis plot and label
daterange=c(as.POSIXlt("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S"),as.POSIXlt("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"))

##close file device
dev.off()
