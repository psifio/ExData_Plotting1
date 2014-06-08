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


#plot the histogram
hist(mydata$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")



