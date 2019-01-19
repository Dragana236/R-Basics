##### Statements #####
# If statements
x <- 3
if(x > 0) {
  print("x is a positive number")
}

# Else statement
x <- -3
if(x > 0) {
  print("x is a positive number")
} else {
  print("x is either a negative number or zero")
}

# else if statement
x <- 0
if(x > 0) {
  print("x is a positive number")
} else if(x == 0) {
  print("x is zero")
} else {
  print("x is a negative number")
}

x <- 6
if(x %% 2 == 0) {
  print("divisible by 2")
} else if(x %% 3 == 0) {
  print("divisible by 3")
} else {
  print("not divisible by 2 nor by 3")
}

num <- 5
if(num < 55 & num > 10) {
  print("Ok")
} else if(num >= 55 & num < 75) {
  print("Very big")
} else { 
  if(num >= 5) {
    print("Still fine")
  } else {
    print("Terrible")
  }
}


##### Loops #####

# while loop
a <- 1
while(a <= 7){
  print(paste("a is set to", a))
  a <- a + 1
}

# break statement
a <- 3
while(a <= 7){
  if(a %% 5 == 0) {
    break
  }
  print(paste("a is set to", a))
  a <- a + 1
}

# for loop
colors <- c("white", "yellow","grey", 
            "red", "green", "black")


for(col in colors) {
  print(col)
}

for (col in colors) {
  if (nchar(col) >= 5) {
    print("Long word")
  } else if (nchar(col) == 4) {
    print("Word with four characters")
  } else {
    print(col)
  }
}


colors <- list("white", "yellow","grey", 
               "red", "green", "black")

colors

for(col in colors) {
  print(col)
}


for(col in colors) {
  if(nchar(col) == 4) {
    break
  }
  print(col)
}


# next statement
for(col in colors) {
  if(nchar(col) == 6) {
    next
  }
  print(col)
}

# Iterate with for loops over the rows of data frame
IBM <- 	data.frame(
  gender = c("Male", "Male","Female"), 
  height = c(152, 171.5, 165), 
  weight = c(81,93, 78),
  age = c(42,38,26),
  date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15")),
  stringsAsFactors = FALSE
  
)


for (row in 1:nrow(IBM)) {
  age <- IBM[row, "age"]
  date  <- IBM[row, "date"]
  if(age > 27) {
    print(paste("Employee joined the company on", date, "."))
  } 
}


for (row in 1:nrow(IBM)) {
  age <- IBM[row, "age"]
  date  <- IBM[row, "date"]
  if(age > 27) {
    print(paste("Employee joined the company on", date, "."))
  } else {
    print(paste("This date:", date, 
                "we don't need for now."))
  }
}

# Looping over matrix
(M = matrix( 1:6, nrow = 2, ncol = 3, byrow = TRUE))


for(row in 1:nrow(M)) {
  for(col in 1:ncol(M)) {
    print(M[row,col])
  }
}


# looping 2
for(i in 1:length(colors)) {
  print(colors[[i]])
}


##### Functions #####
mean(c(1, 5, 6, 7))

help(mean)
? mean

# Required and optional arguments
x <- c(1.23, 5.33, 6.66, 7.01)
round(x, digits = 0)

mean(x = c(1, 5, 6, 7), 0, TRUE)

args(mean)


# Write a function
func_name <- function(arguments) {
  body
}

square <- function(x) {
  x^2
}

# Function with loop
new_function <- function(a) {
  for(i in 1:a) {
    b <- i^2
    print(b)
  }
}	

# Call a function
new_function(6)

# Create a function without an argument
new_function1 <- function() {
  for(i in 1:4) {
    print(i^2)
  }
}	


# Call the function without supplying an argument
new_function1()

# Create a function with default arguments
new_function2 <- function(a = 3, b = 6) {
  result <- a * b
  print(result)
}

new_function2(4)

new_function3 <- function(a, b = 1) {
  if(b == 0) {
    return(0)
  }
  a*b + a/b
}

new_function3(3, 0)

# Scope of the function
percent_to_decimal <- function(percent) {
  decimal <- percent / 100
  decimal
}
percent_to_decimal(6)
decimal

# Variable was defined outside of the function scope
hundred <- 100
percent_to_decimal <- function(percent) {
  percent / hundred
}
percent_to_decimal(6) 
hundred

##### Apply family #####
colors <- list(count = 10,
               color = c("white", "yellow","grey", 
                         "red", "green", "black"),
               fruit = TRUE)

# Using a for loop to find out the class
for(f in colors) {
  print(class(f))
}

# lapply
lapply(colors, class)


# Using a for loop to find out number of characters
colors <- c("white", "yellow","grey", 
            "red", "green", "black")
num_chars <- c()
for(i in 1:length(colors)) {
  num_chars[i] <- nchar(colors[i])
}
num_chars

lapply(colors, nchar)
unlist(lapply(colors, nchar))

# Using lapply with user created function
fruit_count <- list(3, 5, 3, 3, 7)
triple <- function(x) {
  3 * x
}
(result <- unlist(lapply(fruit_count, triple)))                           


# Using lapply with user created function that takes general argument
multiply <- function(x, factor) {
  x * factor
}

(times4 <- unlist(lapply(fruit_count, multiply, factor = 4)))

##### Anonymous functions #####

# Named function
triple <- function(x) { 
  3 * x 
}

# Anonymous function with same implementation
function(x) { 3 * x }

# Using anonymous function inside lapply()
lapply(list(1,2,3), function(x) { 3 * x })

# Applying lapply() on a data frame
lapply(IBM, class)

# sapply
sapply(colors, nchar)
sapply(colors, nchar, USE.NAMES = FALSE)

# Returning object is a matrix
first_and_last <- function(name) {
  letters <- strsplit(name, split = "")[[1]]
  c(first = letters[1], last = letters[length(letters)])
}

sapply(colors, first_and_last)

# Returning object is a list
unique_letters <- function(name) {
  letters <- strsplit(name, split = "")[[1]]
  unique(letters)
}

sapply(colors, unique_letters)

# Using sapply with anonymous function
sapply(list(runif (10), runif (10)), 
       function(x) c(min = min(x), mean = mean(x), max = max(x)))

# vapply
vapply(colors, nchar, numeric(1))

vapply(colors, first_and_last, character(2))

# Using vapply() on data frames
vapply(IBM[, 2:4], summary, numeric(6))


# Using vapply with anonymous function
vapply(runif (10), 
       function(x, y) { mean(x) > y }, logical(1), y = 0.4)  

crash <- list(number = 777.68, 
              date = as.POSIXct("2008-09-28"))

sapply(crash, class)
vapply(crash, class, FUN.VALUE = character(1))


# Packages
install.packages('dplyr')

library(dplyr)

# Check all the installed packages
library()

# Another way of loading the package
require(dplyr)
library(readr)

?require

# Get all packages currently loaded in the R environment
search()
