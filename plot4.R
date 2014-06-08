#load sqldflib
library(sqldf)

#source data file
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#data file will be downloaded with this name
localfilename<-"./PowerConsumption.zip"

#download file
#mode="wb" needed to make sure file is downloaded as binary
zippedFile<-download.file(fileUrl,destfile=localfilename,mode="wb") 

#unzip file
unzippedFile<-unzip(localfilename)

#subset and read data
mydata<-read.csv.sql(unzippedFile,header=TRUE,sep=";", sql="select * from file where Date='1/2/2007' or Date='2/2/2007'")

#calc datetime
mydata$Date.Time <-strptime(paste(mydata$Date,mydata$Time),"%d/%m/%Y %H:%M:%S")

#open screen device
windows()

#plot the graphs

#set a 2x2 plot area
par(mfcol = c(2, 2))

plot(mydata$Date.Time,mydata$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l")


plot(mydata$Date.Time,mydata$Sub_metering_1,xlab="",ylab="Enery sub metering",type="l", col="black")
lines(mydata$Date.Time,mydata$Sub_metering_2, col="red")
lines(mydata$Date.Time,mydata$Sub_metering_3, col="blue")
# bty="n" no box legend
legend("topright", bty="n", lty=c(1,1,1)  ,col = c("black", "red","blue"), legend = c("Sub_metering_1   ", "Sub_metering_2   ","Sub_metering_3   "))


plot(mydata$Date.Time,mydata$Voltage,ylab="Voltage",xlab="datetime",type="l")

plot(mydata$Date.Time,mydata$Global_reactive_power,ylab="Global_reactive_power",xlab="datetime",type="l")

#export to png
dev.copy(png, file = "plot4.png")
dev.off(dev.prev())
dev.off()
