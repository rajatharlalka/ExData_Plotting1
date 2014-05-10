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

##Configure screen device to show 4 plots
par(mfrow=c(2,2),mar=c(4,4,2,2))


##Transform Global Active Power into numeric
d3$Global_active_power <- as.character(d3$Global_active_power)
d3$Global_active_power <- as.numeric(d3$Global_active_power)

##Plot the first graph
plot(as.POSIXct(d3$DateTime),d3$Global_active_power, ylab="Global Active Power",xlab="",pch=26)
lines(as.POSIXct(d3$DateTime),d3$Global_active_power)


##convert voltage into numeric
d3$Voltage <- as.character(d3$Voltage)
d3$Voltage <- as.numeric(d3$Voltage)

##Plot Voltage vs datetime
plot(as.POSIXct(d3$DateTime),d3$Voltage, ylab="Voltage",xlab="datetime",pch=26)
lines(as.POSIXct(d3$DateTime),d3$Voltage)

##Third plot
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

##Fourth plot
d3$Global_reactive_power <- as.character(d3$Global_reactive_power)
d3$Global_reactive_power <- as.numeric(d3$Global_reactive_power)

plot(as.POSIXct(d3$DateTime),d3$Global_reactive_power, ylab="Global_reactive_power",xlab="datetime",pch=26)
lines(as.POSIXct(d3$DateTime),d3$Global_reactive_power)

##Save it as PNG File
dev.copy(png,file="plot4.png")

dev.off()
