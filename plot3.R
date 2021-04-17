library(data.table)
library(tidyverse)
library(lubridate)

if(!dir.exists("data")) { dir.create("data") }

url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
path  <- "data/household_power_consumption.zip"
unzip <- "data/household_power_consumption.txt"

if(!file.exists(path) & !file.exists(unzip)) {
  download.file(url, path)
  unzip(path, exdir = "data")
}

data <- read_delim("data/household_power_consumption.txt",
                   delim = ";",
                   na    = c("?"),
                   col_types = list(col_date(format = "%d/%m/%Y"),
                                    col_time(format = ""),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number())) %>%
  filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

data <- mutate(data, datetime = ymd_hms(paste(Date, Time)))

png("plot3.png", height=480, width=480)

plot(Sub_metering_1 ~ datetime, data, type = "l",
     ylab = "Energy sub metering",
     xlab = NA)

lines(Sub_metering_2 ~ datetime, data, type = "l", col = "red")

lines(Sub_metering_3 ~ datetime, data, type = "l", col = "blue")

legend("topright",
       col = c("black",
               "red",
               "blue"),
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       lty = 1)

dev.off()
