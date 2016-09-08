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

hist(household_subset$Global_active_power, col="red", xlab="Global active power (kilowatts)", main="Global active power")
dev.copy(png, file= "plot1.png", width=480, height=480)
dev.off()