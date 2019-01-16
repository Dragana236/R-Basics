##### Base R #####

# Entering strings
"This is R"
"This is "R"
line <- "This is \"R\""

# Display: 
# This is a really 
# really really 
# long string
writeLines("This is a really \nreally really \nlong string")


# Escape sequence
writeLines("hello\n\U1F30D")

# Display: To have a \ you need \\
writeLines("To have a \\ you need \\\\")


line1 <- "This is R"
line2 <- "This is 'R"
line3 <- "This is \"R\""

# Putting lines in a vector
lines <- c(line1, line2, line3)

# Print lines
lines


# Use writeLines() on lines to see the content of strings you've created
writeLines(lines)

writeLines(lines, sep = ". ")


# Putting strings together with paste() function
paste("anchovies", "artichoke", "bacon", "breakfast bacon", "cheese")
paste("anchovies", "artichoke", "bacon", "breakfast bacon", "cheese",
      sep = "-")

paste(c("anchovies", "artichoke", "bacon", "breakfast bacon", "cheese"), 'a')


Toppings <- c("anchovies", "artichoke", "bacon", "breakfast bacon",
              "Canadian bacon", "cheese", "chicken", "chili peppers",
              "feta", "garlic", "green peppers", "grilled onions",
              "ground beef", "ham", "hot sauce", "meatballs", "mushrooms", 
              "olives", "onions", "pepperoni", "pineapple", "sausage", "spinach",
              "sun-dried tomato","tomatoes")


(my_toppings <- sample(Toppings, size = 3))

(my_toppings_and <- paste(c("", "", "and "), my_toppings, sep = ""))


# Collapse with comma and space
(one_topping <- paste(my_toppings_and, collapse = ", "))


# Add rest of sentence
(my_order <- paste("I want to order a pizza with ", one_topping, ".", sep = ""))

writeLines(my_order)

cat("I want to order a pizza with ", one_topping, ".", sep = "")


# Combining numbers and strings with paste() function
debt <- 4000
cash <- 3000
while(debt > 0){
  debt <- debt - 500
  cash <- cash - 500
  print(paste("Debt remaining:", debt, "and Cash remaining:", cash))
  if (cash == 0) {
    print("You ran out of cash!")
    break
  }
  
  
}


# Base R functions for strings
nchar("Count the number of characters")

# Extract the substring
substring("Extract", 5, 7)

# Split the string
strsplit("Extract", split = "")
strsplit("Extract", split = "")[[1]]


# Functions from base R with patterns
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org",
            "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")


# Use grepl() to match for "edu"
grepl("edu", emails)

which(grepl(pattern = "edu", x = emails))

# Use grep() to match for "edu", save result to hits
hits <- grep("edu", emails)
emails[hits]


emails[grep("^e", emails)]
emails[grep("g$", emails)]

# Use grep() to match for .edu addresses more robustly
hits <- grep("@.*\\.edu$", emails)
emails[hits]

# Use sub() to convert the email domains to .com
sub("@.*\\.edu$", ".com", emails)

sub("@.*\\.edu$|@.*\\.tv$", ".com", emails)
emails

awards <- c("Won 1 Oscar.", 
            "Won 1 Oscar. Another 9 wins & 24 nominations.",
            "1 win and 2 nominations.",
            "2 wins & 3 nominations.",
            "Nominated for 2 Golden Globes. 1 more win & 2 nominations.",
            "4 wins & 1 nomination.")

sub(".*\\s([0-9]+)\\snomination.*$", "\\1", awards)


##### Stringr package #####
library(stringr)

# str_c()
(my_order <- str_c("I want to order a pizza with ", one_topping, "."))

my_toppings <- c("cheese", NA, NA)
(my_toppings_and <- paste(c("", "", "and "), my_toppings, sep = ""))
(my_toppings_str <- str_c(c("", "", "and "), my_toppings))
paste(my_toppings_and, collapse = ", ")
str_c(my_toppings_str, collapse = ", ")

str_length(c('This', 'is', 'R'))


# Splitting Strings
?str_split()
date_ranges <- c("23.01.2017 - 29.01.2017", 
                 "30.01.2017 - 06.02.2017")
# Split dates using " - "
split_dates <- str_split(date_ranges, fixed(" - "))

split_dates


# Split dates with n and simplify specifed
(split_dates_n <- str_split(date_ranges, fixed(" - "), 
                            n = 2, simplify = TRUE))
# Split start_dates into day, month and year pieces
split_dates_n <- str_split(split_dates_n, fixed("."), simplify = TRUE)

# Pull months
split_dates_n[, 2]

# str_split()
# Define line1
line1 <- "The table was a large one, but the three were all crowded together at one corner of it:"

# Define line2
line2 <- '"No room! No room!" they cried out when they saw Alice coming.' 

# Define line3
line3 <- "\"There's plenty of room!\" said Alice indignantly, and she sat down in a large arm-chair at one end of the table."
lines <- c(line1, line2, line3)
lines

# Split lines into words
(words <- str_split(lines, " "))

# Number of words per line
(word_lengths <- lapply(words, str_length))

# Average word length per line
lapply(word_lengths, mean)


?str_replace_na
str_replace_na(my_toppings, 'we_replaced')

library(babynames)
library(dplyr)

babynames_2014 <- babynames %>% 
  filter(year == 2014)

boy_names <- filter(babynames_2014, sex == "M")$name
girl_names <- filter(babynames_2014, sex == "F")$name


# Find the length of all names
boy_length <- str_length(boy_names)
head(boy_length)
girl_length <- str_length(girl_names)

# Find the difference in mean length
mean(girl_length) - mean(boy_length)

# str_sub
?str_sub

str_sub(c("Michaele", "Sofia"), 1, 4)
str_sub(c("Michaele", "Sofia"), -4, -1)

# Tabulate occurrences of boy_first_letter
boy_first_letter <- str_sub(boy_names, 1, 1)
table(boy_first_letter) 

# Look for pattern 'zz' in boy_names
contains_zz <- str_detect(boy_names, fixed("zz"))
sum(contains_zz)
boy_names[contains_zz]

# Subsetting df with boy's names
boy_names_df <- babynames_2014 %>% 
  filter(sex == "M")

boy_names_df[contains_zz,]

# str_subset()
str_subset(boy_names, fixed("zz"))

# str_count()
number_as <- str_count(boy_names, fixed("a"))
table(number_as)

hist(number_as, 3)

boy_names[number_as == 4]


# str_replace()
?str_replace()

ids <- c("ID#: 192", "ID#: 118", "ID#: 001")


# Splitting Strings
date_ranges <- c("23.01.2017 - 29.01.2017", 
                 "30.01.2017 - 06.02.2017")
# Split dates using " - "
split_dates <- str_split(date_ranges, fixed(" - "))

split_dates


# Split dates with n and simplify specifed
(split_dates_n <- str_split(date_ranges, fixed(" - "), 
                            n = 2, simplify = TRUE))
# Split start_dates into day, month and year pieces
split_dates_n <- str_split(split_dates_n, fixed("."), simplify = TRUE)

# Pull months
split_dates_n[, 2]

# str_split()
# Define line1
line1 <- "The table was a large one, but the three were all crowded together at one corner of it:"

# Define line2
line2 <- '"No room! No room!" they cried out when they saw Alice coming.' 

# Define line3
line3 <- "\"There's plenty of room!\" said Alice indignantly, and she sat down in a large arm-chair at one end of the table."
lines <- c(line1, line2, line3)
lines

# Split lines into words
(words <- str_split(lines, " "))

# Number of words per line
(word_lengths <- lapply(words, str_length))

# Average word length per line
lapply(word_lengths, mean)

# str_replace()
ids <- c("ID#: 192", "ID#: 118", "ID#: 001")

# Replace "ID#: " with "" - empty string
(id_nums <- str_replace(ids, "ID#: ", ""))

# Turn id_nums into numbers
as.numeric(id_nums)

# Some (fake) phone numbers
phone_numbers <- c("510-555-0123", "541-555-0167")

# Use str_replace() to replace "-" with " "
str_replace(phone_numbers, fixed("-"), ".")

# Use str_replace_all() to replace "-" with "."
str_replace_all(phone_numbers, fixed("-"), ".")

# DNA sequence
dna

# Find the number of nucleotides in each sequence (gene)
str_length(dna)

# Find the number of T's occur in each sequence
str_count(dna, fixed("T"))

# Return the sequences that contain "TTTTTT"
str_subset(dna, fixed("TTTTTT"))

# Replace all the "A"s in the sequences with a "."
str_replace_all(dna, fixed("A"), ".")

# Task
names <- c("Diana Prince", "Clark Kent")

# Split into first and last names
(names_split <- str_split(names, fixed(" "), simplify = TRUE))

# Extract the first letter in the first name
(abb_first <- str_sub(names_split[, 1], 1, 1))

# Combine the first letter ". " and last name
str_c(abb_first, ". ", names_split[, 2])

