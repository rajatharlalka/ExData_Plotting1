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

##Convert date and time into character
d3$Date = as.character(d3$Date)
d3$Time = as.character(d3$Time)

## Create a new column that has DateTime together
d3$DateTime <- paste(d3$Date, d3$Time)
d3$DateTime <- strptime(d3$DateTime, "%d/%m/%Y %H:%M:%S")

##Convert Global Active Power into numeric
d3$Global_active_power <- as.character(d3$Global_active_power)
d3$Global_active_power <- as.numeric(d3$Global_active_power)

##Create the plot
plot(as.POSIXct(d3$DateTime),d3$Global_active_power, ylab="Global Active Power (in kilowatts)",xlab="",pch=26)

lines(as.POSIXct(d3$DateTime),d3$Global_active_power)

##Save it as PNG File
dev.copy(png,file="plot2.png")

dev.off()
