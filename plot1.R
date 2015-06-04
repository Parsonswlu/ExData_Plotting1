## This program reads in a file on Household Power Consumption and outputs a frequency histogram
## of Global Active Power

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

# Open a .png file and plot the histogram for plot 1
plot.new()
png("plot1.png",width=480,height=480)
hist(file$Global_active_power,col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)")

# Close the connection to the file
dev.off()