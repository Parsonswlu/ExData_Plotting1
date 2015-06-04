## This program reads in a file on Household Power Consumption and outputs four subplots


# Read in the file as a table
filename <- "household_power_consumption.txt"
file<- read.table(filename,header=TRUE,sep=";")

# Convert the Date variable to a date format
file$Date<-as.Date(file$Date, format="%d/%m/%Y")

# Identify the range of dates specified for the project and subset only rows that correspond
# to those dates
requiredRows<-(file$Date == "2007-02-01" | file$Date == "2007-02-02")
file<-file[requiredRows,]

# Coerce the required variables to numeric to be correctly interpreted by the plotting system
file$Global_active_power <- as.numeric(as.character(file$Global_active_power))
file$Global_reactive_power <- as.numeric(as.character(file$Global_reactive_power))
file$Voltage <- as.numeric(as.character(file$Voltage))
file$Sub_metering_1 <- as.numeric(as.character(file$Sub_metering_1))
file$Sub_metering_2 <- as.numeric(as.character(file$Sub_metering_2))
file$Sub_metering_3 <- as.numeric(as.character(file$Sub_metering_3))

# Open lubridate library in order to add date and time together
library(lubridate)

# Coerce the variable "Time" to a POSIXct class using lubridate's hms() function then add to Date
file$Time <- hms(file$Time)
file$Date <- file$Date + file$Time

# Open a .png file and plot the line graphs for plot 4
plot.new()
png("plot4.png",width=480,height=480)

# Partition the chart into 4 subcharts (2x2) using par function 
par(mfcol=c(2,2))

# Plot 1st subplot
plot(file$Date,file$Global_active_power,type="l",xlab="",ylab="Global Active Power")

# Plot 2nd subplot
plot(file$Date,file$Sub_metering_1,type="l",xlab="",ylab="Energy Sub metering")
lines(file$Date,file$Sub_metering_2,col="red")
lines(file$Date,file$Sub_metering_3,col="blue")
legend("topright", lwd=1,bty="n",col=c("black","red","blue"),legend = names(file[7:9]))

# Plot 3rd subplot
plot(file$Date,file$Voltage,type="l",xlab="datetime",ylab="Voltage")

# Plot 4th subplot
plot(file$Date,file$Global_reactive_power,type="l",xlab="datetime",ylabe="Global_reactive_power")

# Close the connection to the file
dev.off()