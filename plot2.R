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

#Save to PNG file
png("plot2.png")
date_time <- paste(data.eda[,1], data.eda[,2])
plot2.data <- cbind(data.eda[,], ymd_hms(date_time))
plot(plot2.data[,3] ~ plot2.data[,10], type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

# off the device
dev.off()
