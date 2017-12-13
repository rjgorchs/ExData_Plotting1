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

##take Global_active_power column and convert it to numeric
globalActivePower <- as.numeric(powerConsumptionFiltered$Global_active_power)

##take Date and Time columns and convert to datetime
datetime <- strptime(paste(powerConsumptionFiltered$Date, powerConsumptionFiltered$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

##create the plot and save it
png("plot2.png", width=480, height=480)
plot(datetime, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
