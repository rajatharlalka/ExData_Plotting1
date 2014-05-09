tmpdir <- tempdir()
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

file <- basename(url)

download.file(url, file)

unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip")

d = read.table("household_power_consumption.txt", 
               sep=";", 
               col.names=c("Date", "Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
               fill=FALSE, 
               strip.white=TRUE)

d2 <- subset(d, Date=="1/2/2007"|Date=="2/2/2007")

d2[d2=="?"] <- NA
d3 <- na.omit(d2)

hist(as.numeric(d3$Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power")

dev.copy(png,file="plot1.png")

dev.off()

