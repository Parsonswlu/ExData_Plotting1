## This program reads in a file on Household Power Consumption and outputs a line graph
## of 3 Sub_metering variables over time

# Read in the file as a table
filename <- "household_power_consumption.txt"
file<- read.table(filename,header=TRUE,sep=";")

# Convert the Date variable to a date format
file$Date<-as.Date(file$Date, format="%d/%m/%Y")

# Identify the range of dates specified for the project and subset only rows that correspond
# to those dates
requiredRows<-(file$Date == "2007-02-01" | file$Date == "2007-02-02")
file<-file[requiredRows,]

# Coerce the Sub_metering variables to numeric to be correctly interpreted by the plotting system
file$Sub_metering_1 <- as.numeric(as.character(file$Sub_metering_1))
file$Sub_metering_2 <- as.numeric(as.character(file$Sub_metering_2))
file$Sub_metering_3 <- as.numeric(as.character(file$Sub_metering_3))

# Open lubridate library in order to add date and time together
library(lubridate)

# Coerce the variable "Time" to a POSIXct class using lubridate's hms() function then add to Date
file$Time <- hms(file$Time)
file$Date <- file$Date + file$Time

# Open a .png file and plot the line graphs for plot 3
plot.new()
png("plot3.png",width=480,height=480)
plot(file$Date,file$Sub_metering_1,type="l",xlab="",ylab="Energy Sub metering")
lines(file$Date,file$Sub_metering_2,col="red")
lines(file$Date,file$Sub_metering_3,col="blue")
legend("topright", lwd=1,col=c("black","red","blue"),legend = names(file[7:9]))

# Close the connection to the file
dev.off()