# This R script creates the plot plot4.png.
# It requires that the dataset "household_power_consumpiton.txt" is in the working directory
# and that packages sqldf and dplyr are installed.

Sys.setlocale("LC_TIME", "English")

require(sqldf)
file <- c("household_power_consumption.txt")
data_subset <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')")

library(dplyr)
data <- mutate(data_subset,hour = paste(Date,Time))

library(lubridate)
data <- mutate(data,time = dmy_hms(hour))

data <- select(data,-Date,-Time,-hour)
data <- select(data,time,Global_active_power:Sub_metering_3)

rm(file,data_subset)

png(file="plot4.png")

par(mfrow=c(2,2))
with(data,plot(time,Global_active_power,type="n",ylab="Global Active Power",xlab=""))
with(data,lines(time,Global_active_power))

with(data,plot(time,Voltage,type="n",ylab="Voltage",xlab="datetime"))
with(data,lines(time,Voltage))

with(data,plot(time,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
with(data,lines(time,Sub_metering_1,col="black"))
with(data,lines(time,Sub_metering_2,col="red"))
with(data,lines(time,Sub_metering_3,col="blue"))
legend("topright",names(data)[6:8],lty=1,col=c(1,2,4),border="white",bty="n")

with(data,plot(time,Global_reactive_power,type="n",xlab="datetime"))
with(data,lines(time,Global_reactive_power))

dev.off()
