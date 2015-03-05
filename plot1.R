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
png("plot1.png")
hist(data.eda[,3], main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     col = "red", ylim = c(0,1200))

# off the device
dev.off()