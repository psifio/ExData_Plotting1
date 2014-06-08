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

#plot x,y
plot(mydata$Date.Time,mydata$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type="l")

#export to png
dev.copy(png, file = "plot2.png")
dev.off(dev.prev())
dev.off()