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

hist(data$Global_active_power,
     xlab = "Global Active Power (kilowatts)",
     col  = "red",
     main = "Global Active Power")

dev.copy(png, "plot1.png", height=480, width=480)

dev.off()