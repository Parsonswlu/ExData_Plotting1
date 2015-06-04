## This program reads in a file on Household Power Consumption and outputs a line graph
## of Global Active Power (in kilowatts) over time

# Read in the file as a table
filename <- "household_power_consumption.txt"
file<- read.table(filename,header=TRUE,sep=";")

# Convert the Date variable to a date format
file$Date<-as.Date(file$Date, format="%d/%m/%Y")

# Identify the range of dates specified for the project and subset only rows that correspond
# to those dates
requiredRows<-(file$Date == "2007-02-01" | file$Date == "2007-02-02")
file<-file[requiredRows,]

# Coerce the variable "Global_active_power" to numeric to be correctly interpreted by the plotting system
file$Global_active_power <- as.numeric(as.character(file$Global_active_power))


# Open lubridate library in order to add date and time together
library(lubridate)

# Coerce the variable "Time" to a POSIXct class using lubridate's hms() function then add to Date
file$Time <- hms(file$Time)
file$Date <- file$Date + file$Time

# Open a .png file and plot the line graph for plot 2
plot.new()
png("plot2.png",width=480,height=480)
plot(file$Date,file$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")

# Close the connection to the file
dev.off()