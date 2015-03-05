library(lubridate)

file <- "household_power_consumption.txt"

# read the file
data <- read.table(file, sep = ";", header = TRUE, 
                   stringsAsFactors = FALSE, na.strings = "?")

# Converting the time using lubridate
data[,1] <- dmy(data[,1])

# subset to the dates required
date1 <- ymd("2007-02-01")
date2 <- ymd("2007-02-02")
data.eda <- data[data[,1] >= date1 & data[,1] <= date2, ]

#cleaning and merging data
date_time <- paste(data.eda[,1], data.eda[,2])
plot4.data <- cbind(data.eda[,], ymd_hms(date_time))

#Save to PNG file
png("plot4.png")

#global graphing parameter
par(cex = 0.75, mfcol = c(2,2))

#plot 1 of 4 - topleft
plot(plot4.data[,3] ~ plot4.data[,10], type = "l", 
     xlab = "", ylab = "Global Active Power")

#plot 2 of 4 - bottomleft
plot(plot4.data[,7] ~ plot4.data[,10], type = "l", 
     xlab = "", ylab = "Energy sub metering")
points(plot4.data[,8] ~ plot4.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "red")
points(plot4.data[,9] ~ plot4.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = names(plot4.data)[7:9], lty = 1, bty = "n")

#plot 3 of 4 - topright
with(plot4.data, plot( Voltage ~ plot4.data[,10], type = "l", 
                       xlab = "datetime", ylab = "Voltage"))

#plot 4 of 4 - bottomright
with(plot4.data, plot( Global_reactive_power ~ plot4.data[,10], type = "l", 
                       xlab = "datetime"))

# off the device
dev.off()