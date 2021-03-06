
#EDA 
#Week 1
#Course Project

##########Plot 3


setwd("~\\DataScienceclass\\EDA")

library(lubridate)
library(lattice)
library(ggplot2)

#Read in data
power<-read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?")


#Change the Date Variable from a Factor to a Date variable.
Date<-power$Date
Date<-dmy(Date)

power<-power[2:9]
power<-cbind(Date,power)

#Subset the Data to the 2 days of interest
sub_power<-subset(power, Date == "2007-02-01" | Date == "2007-02-02")

#Add Weekdays to the dataset
Date<-sub_power$Date
Weekday<-weekdays(Date)
sub_power<-cbind(Weekday, sub_power)

#Add a variable to denote the number of minutes from the start time of the dataset.
id<-seq(1:2880)
sub_power<-cbind(id,sub_power)

#Create a couple of parameters used in the plots using the lattice package (xyplot)
#This is not used for the historam (Plot 1)
x.tick.number <-3
at<-seq(1,nrow(sub_power), length.out = x.tick.number)


##########Plot 3

png(filename = "plot3.png", width = 480, height = 480)

xyplot(Sub_metering_1+Sub_metering_2+Sub_metering_3~id, type = "l",data = sub_power, 
       ylab = "Global Active Power (kilowatts)", xlab = " ", col = c("black","red","blue"),
       scales=list(
         x=list(at=at, labels = c("Thu","Fri", "Sat"), rot=90),tck = c(1,0)),
       key=list(corner = c(1,1), border = TRUE,
                
                lines=list(col=c("black","red", "blue"),  lwd=2),
                
                text=list(c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
                
       ))

dev.off()

