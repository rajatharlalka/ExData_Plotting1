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

##Convert Sub Metering data into numeric
d3$Sub_metering_1 <- as.character(d3$Sub_metering_1)
d3$Sub_metering_1 <- as.numeric(d3$Sub_metering_1)

d3$Sub_metering_2 <- as.character(d3$Sub_metering_2)
d3$Sub_metering_2 <- as.numeric(d3$Sub_metering_2)

d3$Sub_metering_3 <- as.character(d3$Sub_metering_3)
d3$Sub_metering_3 <- as.numeric(d3$Sub_metering_3)


##Create the plot
plot(as.POSIXct(d3$DateTime),d3$Sub_metering_1, ylab="Energy Sub Metering",xlab="",pch=26)

lines(as.POSIXct(d3$DateTime),d3$Sub_metering_1)
lines(as.POSIXct(d3$DateTime),d3$Sub_metering_2,col="red")
lines(as.POSIXct(d3$DateTime),d3$Sub_metering_3,col="blue")

legend("topright",lty = c("solid","solid","solid"), col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##Save it as PNG File
dev.copy(png,file="plot3.png")

dev.off()
