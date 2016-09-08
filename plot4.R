#Reads the source data. 
#Subsets the values for 2007/02/01 and 2007/02/02 
#converts the date and time to a single POSIXct value


setwd("C:/R")

household_power<-read.csv("household_power_consumption.txt", sep=";", na.strings = "?")
household_subset<-subset(household_power, household_power$Date=="1/2/2007" | household_power$Date=="2/2/2007")
household_subset$Date<-as.POSIXct(paste(household_subset$Date,household_subset$Time), format="%d/%m/%Y %H:%M:%S")
household_subset$Time<-NULL
names(household_subset)[names(household_subset)=="Date"]<-"DateTime"

rm(household_power)

Sys.setlocale(category = "LC_ALL", locale = "english") # changes the language to english, for proper labeling of x axis

par(mfrow= c(2,2))
  plot(household_subset$DateTime, household_subset$Global_active_power, type =  "n",xlab="",sub="", ylab="Global active power")
  lines(household_subset$DateTime, household_subset$Global_active_power,xlab="",sub="", ylab="Global active power(kilowatts)")
  plot(household_subset$DateTime, household_subset$Voltage,type = "n" ,xlab="datetime", sub="", ylab= "Voltage")
  lines(household_subset$DateTime, household_subset$Voltage)
  plot(household_subset$DateTime, household_subset$Sub_metering_1, type =  "n",xlab="",sub="", ylab="Energy sub metering")
  lines(household_subset$DateTime, household_subset$Sub_metering_1, col="black")
  lines(household_subset$DateTime, household_subset$Sub_metering_2, col="red")
  lines(household_subset$DateTime, household_subset$Sub_metering_3, col="blue")
##TODO:increasefont size!!!
  legend( "topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col= c("black", "red", "blue")
          ,lty=c(1,1,1), cex=0.6 , y.intersp = 0.3, bty="n" )
  plot(household_subset$DateTime, household_subset$Global_reactive_power, type="n", ylab="Global_reactive_power", xlab="datetime", sub="")
  lines(household_subset$DateTime, household_subset$Global_reactive_power)
  dev.copy(png, file= "plot4.png", width=480, height=480)
  dev.off()  