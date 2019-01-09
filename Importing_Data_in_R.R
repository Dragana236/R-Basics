##### Base R functions #####

# CSV files
# Import swimming_pools.csv
pools <- read.csv('swim.csv')

# Check the structure of pools
str(pools)

# Import swimming_pools.csv correctly
pools <- read.csv('swim.csv', stringsAsFactors = FALSE)

str(pools)


# Tab-delim file
# Import hotdogs.txt
hotdogs <- read.delim('hotdogs.txt', header = FALSE, stringsAsFactors = FALSE)

head(hotdogs)

str(hotdogs)

# Summarize hotdogs
summary(hotdogs)

# Import the hotdogs.txt file
hotdogs1 <- read.table('hotdogs.txt', 
                       sep = '\t', 
                       col.names = c('type','calories','sodium'))

str(hotdogs1)

head(hotdogs1)

hotdogs2 <- read.delim('hotdogs.txt',
                       header = FALSE, 
                       col.names = c('type','calories','sodium'))

# which.min() and which.max() return an index
index <- which.min(hotdogs2$calories)
hotdogs2[index,]

hotdogs2[which.max(hotdogs2$sodium),]

# When some columns should be factors and other characters colClasses is useful
# Set column classes argument
hotdogs3 <- read.delim('hotdogs.txt', 
                       header = FALSE, 
                       col.names = c('type','calories','sodium'),
                       colClasses =c('character','NULL','numeric'))

str(hotdogs3)

head(hotdogs3)

# There are also read.csv2() and read.delim2() functions for 
# dealing with decimal delimiter in floating numbers


##### readr package ######

library(readr)

# Import potatoes.csv with read_csv()
potatoes <- read_csv('potatoes.csv')

potatoes

# Column names
properties <- c("area", "temp", "size", "storage", "method",
                "texture", "flavor", "moistness")

potatoes <- read_tsv('potatoes.txt', col_names = properties)

# Call head() on potatoes
head(potatoes_tsv)

# Import potatoes.txt using read_delim()
potatoes <- read_delim('potatoes.txt', 
                       delim = '\t', 
                       col_names = properties)

# Print out potatoes
potatoes

# Skip first 6 rows including column names, and load next 5 rows
potatoes_fragment <- read_tsv('potatoes.txt', 
                              skip = 6, n_max = 5, 
                              col_names = properties)

head(potatoes_fragment)

# Import all data, but force all columns to be character
potatoes_types <- read_tsv('potatoes.txt', 
                           col_types = 'cccccccc', 
                           col_names = properties)

# Print out structure of potatoes_char
str(potatoes_types)

head(potatoes_types)

# Setting column types with colector functions
fac <- col_factor(levels = c('Beef','Meat','Poultry'))
int <- col_integer()

# Import the data correctly
hotdogs_factor <- read_tsv('hotdogs.txt',
                           col_names = c('type','calories','sodium'),
                           col_types = list(fac, int, int))

str(hotdogs_factor)

summary(hotdogs_factor)

# Read file with '/' delimiter with read_delim() function
potatoes2 <- read_delim("potatoes2.txt", delim = "/")

# Read dataset without column names
potatoes2 <- read_delim("potatoes2.txt", delim = "/", col_names = FALSE)

# Read dataset with specified column types
potatoes2 <- read_delim("potatoes2.txt", delim = "/", col_types = "cciiid_d")

# Read dataset so that we skip first two rows and read 3 rows in total
potatoes2 <- read_delim("potatoes2.txt", 
                        delim = "/", 
                        skip = 2, 
                        n_max = 3)

# Read dataset as before but now with specified columns
potatoes2 <- read_delim("potatoes2.txt", 
                        delim = "/", 
                        col_names = properties, 
                        skip = 2, 
                        n_max = 3)

head(potatoes2)

##### data.table package #####

library(data.table)

# Import potatoes.csv with fread() 
potatoes <- fread('potatoes.csv')

# Import potatoes.csv with fread() 
(potatoes <- fread('potatoes2.csv'))

# Import columns 6 and 8 of potatoes.csv
(potatoes <- fread('potatoes.csv', select = c(6,8)))

# Plot texture (x) and moistness (y) of potatoes
plot(potatoes$texture, potatoes$moistness)

# Import potatoes.csv file, exluding 6 and 8 columns
(potatoes <- fread('potatoes.csv', drop = c('texture', 'moistness')))


head(potatoes)

##### Excel files #####

library(readxl)

# Print out the names of both spreadsheets
excel_sheets('urbanpop.xlsx')

# Read the sheets, one by one
pop_1 <- read_excel("urbanpop.xlsx", sheet = 1)
pop_2 <- read_excel("urbanpop.xlsx", sheet = 2)
pop_3 <- read_excel("urbanpop.xlsx", sheet = 3)


head(pop_1)

# Put pop_1, pop_2 and pop_3 in a list: pop_list
pop_list <- list(pop_1, pop_2, pop_3)

# Display the structure of pop_list
str(pop_list)

# Reading multiple sheets at once
pop_list <- lapply(excel_sheets('urbanpop.xlsx'), 
                   read_excel, 
                   path = 'urbanpop.xlsx')

# Display the structure of pop_list
str(pop_list)

pop_list[2]

# Import the the first Excel sheet of urbanpop_nonames.xlsx
(pop_a <- read_excel('urbanpopnonames.xlsx', col_names = FALSE))


# Import the the first Excel sheet of urbanpop_nonames.xlsx (specify col_names)
cols <- c('country', paste0('year_', 1960:1966))
(pop_a <- read_excel('urbanpopnonames.xlsx', col_names = cols))

# Import the the first Excel sheet of urbanpop.xlsx (specify col_types)
(pop_a <- read_excel('urbanpop.xlsx', 
                     col_types = c('text', 'text', 'text', 'numeric', 'blank', 'blank', 'text', 'text')))

# Import the second sheet of urbanpop.xlsx, skipping the first 21 rows
pop_b <- read_excel('urbanpop.xlsx', sheet = 2, col_names = FALSE, skip = 21)

# Print out the first observation from urbanpop_sel
pop_b[1,]

##### XLConnect package ###

library(XLConnect)

# Build connection to urbanpop.xlsx
mybook <- loadWorkbook('urbanpop.xlsx')

# Print out the class of my_book
class(mybook)

# List the sheets in my_book
getSheets(mybook)

# Import the second sheet in my_book as a data frame
loaded <- readWorksheet(mybook, sheet = '1960-1966')

# Call head on loaded
head(loaded)

# Get an overview of our Excel file
sheets <- getSheets(mybook)
all <- lapply(sheets, readWorksheet, object = mybook)
str(all)

all[2]

# Import columns 3, 4, and 5 from second sheet in my_book
urbanpop_sel <- readWorksheet(mybook, sheet = 2, startCol = 3, endCol = 5)

head(urbanpop_sel)

# Import first column from second sheet in my_book
countries <- readWorksheet(mybook, sheet = 2, startCol = 1, endCol = 1)

all <-  cbind(countries, urbanpop_sel)

head(all)

# Add a worksheet to my_book, named "data_summary"
createSheet(mybook, "data_summary")

# Use getSheets() on my_book to verify that my_book now represents an Excel file with four sheets
getSheets(mybook)

# Add a worksheet to my_book, named "data_summary"
sheets <- getSheets(mybook)[1:3]
dims <- sapply(sheets, function(x) dim(readWorksheet(mybook,sheet = x)),
               USE.NAMES = FALSE)

# Create data frame
summ <- data.frame(sheets = sheets,
                   nrows = dims[1, ],
                   ncols = dims[2, ])

# Add data in summ to "data_summary" sheet
writeWorksheet(mybook, summ, 'data_summary')

# Save workbook as summary.xlsx
saveWorkbook(mybook, "summary.xlsx")

# Rename "data_summary" sheet to "summary"
renameSheet(mybook, "data_summary", "summary")

# Save workbook to "renamed.xlsx"
saveWorkbook(mybook, file = "renamed.xlsx")

# Build connection to renamed.xlsx
mybook <- loadWorkbook('renamed.xlsx')

# Remove the fourth sheet
removeSheet(mybook, 4)

# Save workbook to "clean.xlsx"
saveWorkbook(mybook, file = "clean.xlsx")
