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

# data cleaning and merging
date_time <- paste(data.eda[,1], data.eda[,2])
plot3.data <- cbind(data.eda[,], ymd_hms(date_time))

#Save to PNG file
png("plot3.png")
plot(plot3.data[,7] ~ plot3.data[,10], type = "l", 
     xlab = "", ylab = "Energy sub metering")
points(plot3.data[,8] ~ plot3.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "red")
points(plot3.data[,9] ~ plot3.data[,10], type = "l", 
       xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", col = c("black", "red", "blue"), 
       legend = names(plot3.data)[7:9], lty = 1)

# off the device
dev.off()