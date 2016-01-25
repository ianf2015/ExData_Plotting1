##download and unzip data to local directory
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./household_power_consumption.zip")
mydata <- read.csv(unz("./household_power_consumption.zip", "household_power_consumption.txt"),sep=";")

##select relevant data within the range of dates
mydata$Date<-as.Date(mydata$Date,"%d/%m/%Y")
plotdata<-mydata[mydata$Date=="2007-02-01"|mydata$Date=="2007-02-02",] 

## convert global active power variable to numeric
plotdata$Global_active_power<-as.numeric(levels(plotdata$Global_active_power))[plotdata$Global_active_power]

##open file device
png(file="plot1.png",width=480,height=480)

##plot histograms of global active power variable
with(plotdata,hist(Global_active_power,main="Global Active Power",xlab = "Global Active Power (kilowatts)",col="red"))

##close file device
dev.off()