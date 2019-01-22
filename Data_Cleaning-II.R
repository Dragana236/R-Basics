library(tidyr)
library(dplyr)
library(tidyr)
library(lubridate)
library(stringr)
library(readxl)
library(ggplot2)
library(data.table)

setwd("C:/Users/...")

who

help(who)

# View its class
class(who)

# View its dimensions
dim(who)

# Look at column names
names(who)

# View structure
glimpse(who)

# View the top
head(who)

###Cleaning the data####

# Gather the columns
who1 <- who %>%
  gather(
    new_sp_m014:newrel_f65, key = 'key', 
    value = 'cases',
    na.rm = TRUE)
# Inspect new dataframe
head(who1)

# Count values
who1 %>%
  count(key)

# Look at the unique values
unique(who1$key)

# Replace newrel with new_rel
who2 <- who1 %>%
  mutate(key = str_replace(key, 'newrel', 'new_rel'))

who2

# Separate values
who3 <- who2 %>%
  separate(key, c('new', 'type', 'sexage'), sep = '_')

who3

# Count the values in the columns
who3 %>%
  count(type)

who3 %>%
  count(new)

who4 <- who3 %>%
  select(-new, -iso2, -iso3)

who4

who5 <- who4 %>%
  separate(sexage, c('sex', 'age'), sep = 1)

who5

# Express with one line pipe
who %>%
  gather(new_sp_m014:newrel_f65, key = 'key', value = 'cases',na.rm = TRUE) %>%
  mutate(key = str_replace(key, 'newrel', 'new_rel')) %>%
  separate(key, c('new', 'type', 'sexage'), sep = '_') %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c('sex', 'age'), sep = 1)


####sales.csv####
sales <- read.csv("sales.csv", stringsAsFactors = FALSE)

# View dimensions of sales
dim(sales)

# Inspect first 6 rows of sales
head(sales)

# Get a glimpse of sales
glimpse(sales)

# View a summary of sales
summary(sales)

# Remove the first column of sales
sales2 <- sales[, 2:ncol(sales)]

# Alternative removing
#sales2 <- sales[, -1]

# Create logical vectors indicating missing values
date_cols <- names(sales2)
missing <- lapply(sales2[, date_cols], is.na)
sapply(missing, sum)

# Define a vector of column indices
keep <- 5:(ncol(sales2) - 15)

# Subset sales2 using keep: sales3
sales3 <- sales2[, keep]

head(sales3)

# Split event_date_time
sales4 <- separate(sales3, event_date_time, 
                   c("event_dt", "event_time"), sep = " ")

# Split sales_ord_create_dttm
sales5 <- separate(sales4, sales_ord_create_dttm, 
                   c("ord_create_dt", "ord_create_time"), sep = " ")

# Define an issues vector
issues <- c(2516, 3863, 4082, 4183)

# Print values of sales_ord_create_dttm at these indices
sales3$sales_ord_create_dttm[issues]

# Find columns of sales5 containing "dt"
date_cols <- str_detect(names(sales5), "dt")

# Coerce date columns into Date objects
sales5[, date_cols] <- lapply(sales5[, date_cols], ymd)

# Create logical vectors indicating missing values
missing <- lapply(sales5[, date_cols], is.na)

# Create a numerical vector that counts missing values: num_missing
sapply(missing, sum)

# Combine the venue_city and venue_state columns
sales6 <- unite(sales5, venue_city_state, 
                venue_city, venue_state, sep = ", ")
# View the head of sales6
head(sales6)

###mbta dataset####

# Import mbta.xlsx and skip first row: mbta
mbta <- read_excel("mbta.xlsx", skip = 1)

# Examining the data

# View the structure of mbta
str(mbta)

# View the first 6 rows of mbta
head(mbta, 11)

# View a summary of mbta
summary(mbta)

# Convert characters to numeric
# mbta <- mutate_each(mbta, funs(as.numeric), c('2007-01':'2007-02'))
# sum(is.na(mbta))

# Remove rows 1, 7, and 11 of mbta
mbta2 <- mbta[-c(1, 7, 11), ]

# Remove the first column of mbta2
mbta3 <- mbta2[, -1]

# Gather columns of mbta3
mbta4 <- gather(mbta3, month, thou_riders, -mode)

# View the head of mbta4
head(mbta4)

# Coerce thou_riders to numeric
mbta4$thou_riders <- as.numeric(mbta4$thou_riders)

# Spread the contents of mbta4: mbta5
mbta5 <- spread(mbta4, mode, thou_riders)

# View the head of mbta5
head(mbta5)

# Split month column into month and year: mbta6
mbta6 <- separate(mbta5, month, c("year", "month"))

# View the head of mbta6
head(mbta6)

# View a summary of mbta6
summary(mbta6)

# Generate a histogram of Boat column
hist(mbta6$Boat)

# Find the row number of the incorrect value
i <- which(mbta6$Boat > 30)

# Replace the incorrect value with 4
mbta6$Boat[i] <- 4

# Generate a histogram of Boat column
hist(mbta6$Boat)

# Look at all T ridership over time
ggplot(mbta4, aes(x = month, y = thou_riders, col = mode)) + geom_point() + 
  scale_x_discrete(name = "Month", breaks = c(200701, 200801, 200901, 201001, 201101)) +  
  scale_y_continuous(name = "Avg Weekday Ridership (thousands)")

####Food dataset####

# Import food.csv
dt_food <- fread("food.csv", fill = TRUE)

# Convert dt_food to a data frame
food <- data.frame(dt_food)

# Examining the data

# View summary of food
summary(food)

# View head of food
head(food)

# View structure of food
str(food)

# View a glimpse of food
glimpse(food)

# View column names of food
names(food)

# Define vector of duplicate cols
duplicates <- c(4, 6, 11, 13, 15, 17, 18, 20, 22, 
                24, 25, 28, 32, 34, 36, 38, 40, 
                44, 46, 48, 51, 54, 65, 158)

# Remove duplicates from food
food2 <- food[, -duplicates]

# Define useless vector
useless <- c(1, 2, 3, 32:41)

# Remove useless columns from food2
food3 <- food2[, -useless]

# Create vector of column indices
nutrition <- str_detect(names(food3), "100g")

# View a summary of nutrition columns
summary(food3[, nutrition])

# Find indices of sugar NA values
missing <- is.na(food3$sugars_100g)

# Replace NA values with 0
food3$sugars_100g[missing] <- 0

# Checking once again
summary(food3$sugars_100g)

# Create first histogram
hist(food3$sugars_100g, breaks = 100)

# Create food4
food4 <- food3[food3$sugars_100g > 0, ]

# Create second histogram
hist(food4$sugars_100g, breaks = 100)

# Inspect the packaging column
head(food$packaging, 10)

# Find entries containing "plasti"
plastic <- str_detect(food3$packaging, "plasti")

# Print the sum of plastic
sum(plastic)

# Import the spreadsheet
att <- read_excel("attendance.xls")

# Print the column names 
names(att)

# Print the first 6 rows
head(att, 20)

# Print the last 6 rows
tail(att)

# Print the structure
glimpse(att)

# Create remove
remove <- c(3, 10, 16, 56:59)

# Create att2
att2 <- att[-remove, ]

# Create remove
remove <- c(2, 3, 5, 7, 9, 10, 11)

# Create att3
att3 <- att2[, -remove]

head(att3)

# Subset all schools: att4
att4 <- att3[, 1:5]

head(att4)

# Define cnames vector
cnames <- c("state", "avg_attend_pct", "avg_hr_per_day", 
            "avg_day_per_yr", "avg_hr_per_yr")

# Assign column names of att4
colnames(att4) <- cnames

# Remove first two rows of att4: att5
att5 <- att4[-c(1, 2), ]

# View the names of att5
names(att5)

head(att5)

# Remove all periods in state column
att5$state <- str_replace_all(att5$state, "\\.", "")

# Remove white space around state names
att5$state <- str_trim(att5$state)


# View the head of att5
head(att5)

# Change columns to numeric using dplyr
att6 <- mutate_each(att5, funs(as.numeric), -state)

head(att6)
