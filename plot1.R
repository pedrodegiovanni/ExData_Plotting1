# This R script creates the plot plot1.png.
# It requires that the dataset "household_power_consumpiton.txt" is in the working directory
# and that packages sqldf and dplyr are installed.

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

png(file="plot1.png")
hist(data$Global_active_power,col="red",xlab="Global Active Power (kilowatts)",main="Global Active Power")
dev.off()
