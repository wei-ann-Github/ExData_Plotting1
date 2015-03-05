getwd()
setwd("C:/Users/WeiAnn/Documents/github/ExData_Plotting1")

library(lubridate)

files <- list.files()
file_ind <- grep("household_power_consumption", files)

# read the file
data <- read.table(files[file_ind], sep = ";", header = TRUE, 
                   stringsAsFactors = FALSE, na.strings = "?")

# explore the structure of the data
dim(data)
head(data)
summary(data)
names(data)
str(data)

# Converting the time using lubridate
data[,1] <- dmy(data[,1])

# subset to the dates required
date1 <- ymd("2007-02-01")
date2 <- ymd("2007-02-02")
data.eda <- data[data[,1] >= date1 & data[,1] <= date2, ]
# and check
summary(data.eda)
dim(data.eda)

#global graphing parameter
par(cex = 0.75)

#plot1.R
hist(data.eda[,3], main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     col = "red", ylim = c(0,1200))

#plot2.R
date_time <- paste(data.eda[,1], data.eda[,2])
plot2.data <- cbind(data.eda[,], ymd_hms(date_time))
plot(plot2.data[,3] ~ plot2.data[,10], type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

#plot3.R
date_time <- paste(data.eda[,1], data.eda[,2])
plot3.data <- cbind(data.eda[,], ymd_hms(date_time))
plot(plot3.data[,7] ~ plot3.data[,10], type = "l", 
     xlab = "", ylab = "Energy sub metering")
points(plot3.data[,8] ~ plot3.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "red")
points(plot3.data[,9] ~ plot3.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = names(plot3.data)[7:9], lty = 1)

#plot4.R
windows()
par(mfcol = c(2,2))
plot4.data <- cbind(data.eda[,], ymd_hms(date_time))
plot(plot4.data[,3] ~ plot4.data[,10], type = "l", 
     xlab = "", ylab = "Global Active Power")

plot(plot4.data[,7] ~ plot4.data[,10], type = "l", 
     xlab = "", ylab = "Energy sub metering")
points(plot4.data[,8] ~ plot4.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "red")
points(plot4.data[,9] ~ plot4.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = names(plot4.data)[7:9], lty = 1, bty = "n")

with(plot4.data, plot( Voltage ~ plot4.data[,10], type = "l", 
     xlab = "datetime", ylab = "Voltage"))

with(plot4.data, plot( Global_reactive_power ~ plot4.data[,10], type = "l", 
                       xlab = "datetime"))

#Save to PNG file
png("plot1.png")
hist(data.eda[,3], main = "Global Active Power", 
     xlab ="Global Active Power (kilowatts)", ylab = "Frequency", 
     col = "red", ylim = c(0,1200))

png("plot2.png")
png("plot3.png")
png("plot4.png")

# off the device
dev.off()
