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

## convert global active power variable to numeric
plotdata$Global_active_power<-as.numeric(levels(plotdata$Global_active_power))[plotdata$Global_active_power]

##open file device
png(file="plot2.png",width=480,height=480)

##plot global active power against datetime, without plotting x axis
with(plotdata,plot(Datetime,Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="",xaxt="n"))

##add x axis plot and label
daterange=c(as.POSIXlt("2007-02-01 00:00:00",format="%Y-%m-%d %H:%M:%S"),as.POSIXlt("2007-02-03 00:00:00",format="%Y-%m-%d %H:%M:%S"))
axis.POSIXct(1, at=seq(daterange[1], daterange[2], by="day"))

##close file device
dev.off()
