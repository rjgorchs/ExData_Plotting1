fileName <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

## if the file was not already downloaded, download and unzip it:
if (!file.exists(fileName)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, fileName)
  unzip(fileName)
}

## read the file on a table and filter corresponding dates
powerConsumption <- read.table("household_power_consumption.txt", header=TRUE, sep=";", dec=".", stringsAsFactors=FALSE)
powerConsumptionFiltered <- powerConsumption[powerConsumption$Date=="1/2/2007" | powerConsumption$Date=="2/2/2007", ]

##take Global_active_power, globalReactivePower and Voltage columns and convert them to numeric
globalActivePower <- as.numeric(powerConsumptionFiltered$Global_active_power)
globalReactivePower <- as.numeric(powerConsumptionFiltered$Global_reactive_power)
voltage <- as.numeric(powerConsumptionFiltered$Voltage)

##take Date and Time columns and convert to datetime
datetime <- strptime(paste(powerConsumptionFiltered$Date, powerConsumptionFiltered$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

##create the plot and save it
png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2))

plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(datetime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(datetime, subMetering1, type="l", ylab="Energy Sub metering", xlab="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(datetime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
