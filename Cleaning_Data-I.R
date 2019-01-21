library(readr)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)


weather

write.csv(weather, 'weather.csv')

# View its class
class(weather)

# View its dimensions
dim(weather)

# Look at column names
names(weather)

# View structure with str()
str(weather)

# View structure with glimpse
glimpse(weather)

# View a summary
summary(weather)

####Looking at the data####

# View the top
head(weather)

# View the bottom
tail(weather)

####Cleaning the data####

# Gather the columns
weather <- gather(weather, day, value, X1:X31, na.rm = TRUE)

# View the head
head(weather)

# Spread the data
weather <- spread(weather, measure, value)

# View the head
head(weather)

# Remove column of row names
weather <- weather[,-1]

####Preparing data for analysis####

# Remove X's from day column
weather$day <- str_replace(weather$day, 'X','')

# Unite the year, month, and day columns
weather <- unite(weather, date, year, month, day, sep = '-')

# Inspect the head of data
head(weather)

# Coerce date column to proper date format
weather$date <- ymd(weather$date)

# Look at the structure of data
glimpse(weather)

# Rearrange columns
weather <- select(weather, date, Events, CloudCover:WindDirDegrees)

# View the structure of weather
glimpse(weather)

# See what happens if we try to convert PrecipitationIn to numeric
as.numeric(weather$PrecipitationIn)

# 'T' is trace amount

# Replace T with 0 
weather$PrecipitationIn <- str_replace(weather$PrecipitationIn, 'T', '0')

# Convert characters to numeric
weather <- mutate_each(weather, funs(as.numeric), CloudCover:WindDirDegrees)


# Write above code with one line pipe
weather %>%
  gather(X1:X31, key = 'day', value = 'value', na.rm = TRUE) %>%
  select(-1) %>%
  spread(key = measure, value = value) %>%
  separate(day, c('extra', 'day'), sep = 1) %>%
  select(-3) %>%
  mutate_each(funs(as.character), c(year, month)) %>%
  unite(date, year, month, day, sep = '-') %>%
  mutate(date = ymd(date)) %>%
  select(date, Events, CloudCover:WindDirDegrees) %>%
  mutate_each(funs(as.numeric), CloudCover:WindDirDegrees)


# Look at result
glimpse(weather)

####Inspecting missing and suspected values####

# Count missing values
sum(is.na(weather))

# Find missing values
summary(weather)

# Find indices of NAs in Max.Gust.SpeedMPH
ind <- which(is.na(weather$Max.Gust.SpeedMPH))

# Subset data frame
weather[ind,]

# Review distributions for all variables
summary(weather)

# Find row with Max.Humidity of 1000
ind <- which(weather$Max.Humidity == 1000)
weather[ind, ]
ind

# Change 1000 to 100
weather$Max.Humidity[ind] <- 100

# Look at summary of Mean.VisibilityMiles
summary(weather$Mean.VisibilityMiles)

# Get index of row with -1 value
ind <- which(weather$Mean.VisibilityMiles == -1)

# Look at full row
weather[ind, ]

# Set Mean.VisibilityMiles to the appropriate value
weather$Mean.VisibilityMiles[ind] <- 10

# Look at histogram for MeanDew.PointF
hist(weather$MeanDew.PointF)

# Look at histogram for Min.TemperatureF
hist(weather$Min.TemperatureF)

# Compare to histogram for Mean.TemperatureF
hist(weather$Mean.TemperatureF)

# Clean up column names
names(weather) <- new_colnames

# Replace empty cells in events column
weather$Events[weather$Events == ""] <- "None"

# Inspect one more time
glimpse(weather)
