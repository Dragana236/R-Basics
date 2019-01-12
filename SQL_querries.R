install.packages("RMySQL")
library(DBI) # library(RMySQL) not required

# Create a connection Object to MySQL database
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "financial",
                 host = "relational.fit.cvut.cz",
                 port = 3306,
                 user = "guest",
                 password = "relational")

# List table in a database
dbListTables(con)

# Import tables
dbReadTable(con, "loan")

##### Selecting columns #####

# Select the amount column from the loan table 
dbGetQuery(con, 'SELECT amount
           FROM loan
           LIMIT 10')

# Select the amount and duration column from the loan table 
dbGetQuery(con, 'SELECT amount, duration
           FROM loan
           LIMIT 10')

# Select all columns from the loan table 
dbGetQuery(con, 'SELECT *
           FROM loan
           LIMIT 10')

# Get all unique status
dbGetQuery(con,'SELECT DISTINCT status
           FROM loan')

# Count the number of dates present in loan table
dbGetQuery(con,'SELECT COUNT(date)
           FROM loan')

# How many row are in loan table?
dbGetQuery(con,'SELECT COUNT(*)
           FROM loan')

# Count the number of distinct statuses in loan table
dbGetQuery(con,'SELECT COUNT(DISTINCT(status))
           FROM loan')


##### Filtering results #####

# Filter only dates from 'account' table, for which frequency is "POPLATEK TYDNE"
dbGetQuery(con,'SELECT date
           FROM account
           WHERE frequency LIKE "POPLATEK TYDNE%" 
           LIMIT 10')

sqldf('SELECT *
      FROM trans')

# Filter account's id whose date when they took a laon was 1993-04-20
dbGetQuery(con,'SELECT account_id
           FROM account
           WHERE date = "1993-04-20" ')

# Filter account's id and frequency of persons whose date when they took a loan wasn't 1993-04-20
dbGetQuery(con,'SELECT account_id, frequency
           FROM account
           WHERE date <> "1993-04-20" 
           LIMIT 10')

# Get the number of 'POPLATEK PO OBRATU' frequency 
dbGetQuery(con,'SELECT COUNT(frequency)
           FROM account
           WHERE frequency = "POPLATEK PO OBRATU"')


# Get all details for all records with 'POPLATEK PO OBRATU' frequency 
dbGetQuery(con,'SELECT *
           FROM account
           WHERE frequency = "POPLATEK PO OBRATU" ')

# Filter account's id whose date when they took a loan was between 1993-04-20 and 1993-05-20
dbGetQuery(con,'SELECT account_id
           FROM account
           WHERE date > "1993-04-20"
           AND date < "1993-05-20"')

# Get all details for persons whose date when they took a loan was 1993-04-20 and whose frequency was 'POPLATEK PO OBRATU'
dbGetQuery(con,'SELECT *
           FROM account
           WHERE date > "1993-04-20"
           AND frequency = "POPLATEK PO OBRATU"')


# Get all details for persons whose frequency was 'POPLATEK PO OBRATU' and whose date when they took a loan was between 1993-04-20 and 1993-07-20
dbGetQuery(con,'SELECT *
           FROM account
           WHERE frequency = "POPLATEK PO OBRATU"
           AND date > "1993-04-20"
           AND date < "1993-07-20"')


# Filter account's id whose date when they took a loan was between 1993-04-20 and 1993-05-20
dbGetQuery(con,'SELECT account_id
           FROM account
           WHERE date 
           BETWEEN "1993-04-20" AND "1993-05-20"')

# Filter account's id and district_id for persons whose date when they took a loan was between 1993-04-20 and 1993-07-20 and whose frequency was'POPLATEK PO OBRATU'
dbGetQuery(con,'SELECT account_id, district_id
           FROM account
           WHERE date 
           BETWEEN "1993-04-20" AND "1993-07-20"
           AND frequency = "POPLATEK PO OBRATU"')


# Filter account's id whose date when they took a loan was either 1993-04-20 or 1993-05-20
dbGetQuery(con,'SELECT account_id
           FROM account
           WHERE date = "1993-04-20"
           OR date = "1993-05-20"')


# Get all details for persons whose frequency was 'POPLATEK PO OBRATU' or whose date when they took a loan was between 1993-04-20 and 1993-07-20
dbGetQuery(con,'SELECT *
           FROM account
           WHERE frequency = "POPLATEK PO OBRATU"
           OR date 
           BETWEEN "1993-04-20" AND "1993-05-20"
           LIMIT 10')


# Selects all loans that were took in 1993-04-20 or 1993-07-20 and whose frequency is 'POPLATEK MESICNE' or 'POPLATEK PO OBRATU'
dbGetQuery(con,'SELECT *
           FROM account
           WHERE (date = "1993-04-20" OR date = "1993-05-20")
           AND (frequency = "POPLATEK MESICNE" OR frequency = "POPLATEK PO OBRATU")')


dbGetQuery(con,'SELECT *
           FROM account
           WHERE (date = "1993-04-20" OR date = "1993-05-20")
           AND (frequency = "POPLATEK MESICNE" OR frequency = "POPLATEK PO OBRATU")
           AND (district_id > 50)')


# Filter all records where date of loan was 1993-04-20 or 1993-05-20 or 1993-06-20
# Not a good approach
dbGetQuery(con,'SELECT *
           FROM account
           WHERE date = "1993-04-20" 
           OR date = "1993-05-20"
           OR date = "1993-06-20"
           OR date = "1993-07-20"')

# Better approach
dbGetQuery(con,'SELECT *
           FROM account
           WHERE date 
           IN ("1993-04-20", "1993-05-20", "1993-06-20", "1993-07-20")')

# Filter all records where date of loan was 1993-04-20 or 1993-05-20 or 1993-06-20 and whose district_id was higher than 40
dbGetQuery(con,'SELECT *
           FROM account
           WHERE date 
           IN ("1993-04-20", "1993-05-20", "1993-06-20", "1993-07-20")
           AND district_id > 40')


# Count the number of missing dates
dbGetQuery(con,'SELECT COUNT(*)
           FROM account
           WHERE date IS NULL')


# Get only account's id people whose date is not missing
dbGetQuery(con,'SELECT account_id
           FROM account
           WHERE date IS NOT NULL
           LIMIT 10')


# Filter records for which frequency starts with 'POPLATEK TY'
dbGetQuery(con,'SELECT account_id
           FROM account
           WHERE frequency LIKE "POPLATEK TY"
           LIMIT 10')

# Matches all persons whose frequency has a 'O' as a second letter
dbGetQuery(con,'SELECT account_id
           FROM account
           WHERE frequency LIKE "_O%"
           LIMIT 10')


##### Agregate Functions #####

# Find the average, maximum and sum of values from the payments column in loan dataframe
dbGetQuery(con, 'SELECT AVG(payments)
           FROM loan')

dbGetQuery(con, 'SELECT MAX(payments)
           FROM loan')

dbGetQuery(con, 'SELECT SUM(payments)
           FROM loan')

# Find the minimum value of payment for the time between 1994-01-05 and 1995-01-05
dbGetQuery(con, 'SELECT MIN(payments)
           FROM loan
           WHERE date > "1994-01-05"
           AND date < "1996-04-29"')

# Find the difference between amount and payment for the time between 1994-01-05 and 1995-01-05, and alias as NET
dbGetQuery(con, 'SELECT amount - payments AS NET
           FROM loan
           WHERE date > "1994-01-05"
           AND date < "1996-04-29"
           LIMIT 10')

dbDisconnect(con)
