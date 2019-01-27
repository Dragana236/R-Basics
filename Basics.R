##### Variables #####
var <- 5
var1 <- 6
var + var1

var <- 'variable'
var

ls()

##### Operators #####

# Arithmetic operators
a <- c( 2,5.5,6)
b <- c(8, 3, 4)
a + b
a - b
a * b
a / b
a %% b
a %/% b
a ^ b

# Relational operators
a > b
a < b
a == b
a <= b 
a >= b
a != b

x <- c(1, 2, 3, 3, 5, 3)
length(x)
sum(x == 3)   # F, F, T, T, F, T
mean(x == 3)  

# Logical operators
value <- c(65, 61, 60)
(value > 59) & (value < 70)

(value > 66) | (value < 63)

!(value > 59) & (value < 70)

# Not operator very useful when filtering non-missing data
missing <- c(24.5, 25.7, NA, 28, 28.6, NA)
missing[!is.na(missing)]


(value > 66) && (value < 63)
(value > 66) || (value < 63)


# Miscellaneous Operators
v <- 2:8
v1 <- 8
v2 <- 12
belongs <- 1:10
v1 %in% belongs
v2 %in% belongs

##### Vectors #####

# Create a vector
(colors <- c('red','green','blue'))

c(TRUE, 2)

# Explicit coecrion
logi <- c(T, F, F, F)
as.numeric(logi)

# Another way of changing the class
class(logi) <- 'numeric'
class(logi)

# Creating a sequence from 6.6 to 12.6
(v <- 6.6:12.6)

# Create vector with elements from 5 to 9 incrementing by 0.4
print(seq(5, 9, by = 0.4))

# Sorting elements
sort(seq(5, 9, by = 0.4), decreasing = TRUE)

# Give names to vector element
names(colors) <- c('apple', 'brokoli', 'delphin')

colors

# The logical and numeric values are converted to characters
(s <- c('apple','red',5,TRUE))

# Accessing vector elements using position
(days <- c("Sun","Mon","Tue","Wed","Thurs","Fri","Sat"))

# Accessing vector elements using numbers
days[c(2,3,6)]

# Accessing vector elements using logical indexing
days[c(FALSE,TRUE,TRUE,FALSE,FALSE,TRUE,FALSE)]

# Accessing vector elements using negative indexing
days[c(-1,-4,-5,-7)]

# Accessing elements of vector using names
colors['apple']

# Select elements higher than 6
numbers <- 1:10
numbers[numbers > 6]

v1 <- c(3,8,4,5,0,11)
v2 <- c(4,11)

# Add two vectors of non equal length
v1 + v2

##### Lists #####
# Create a list
(list1 <- list(c(2, 5, 3),'blue', list(TRUE, c(1, 3, 5))))

# Create a list containing a vector, a matrix and a list
list_data <- list(c("Jan","Feb","Mar"), 
                  matrix(c(3,9,5,1,-2,8), nrow = 2),
                  list("green",12.3))

# Give names to the elements in the list
names(list_data) <- c("Vector", "Matrix", "List")

list_data

# Access the first element of the list
list_data[3]

# Access the list element using the name of the element
list_data$Matrix

list1[2]
list1[[2]]

list_data[[3]][[2]]

# Add element at the end of the list
list_data[4] <- "New element"

# Remove the last element
list_data[4] <- NULL

# Update the 3rd element
list_data[3] <- "updated element"

list1 <- list(1,2,3)

# Add two lists
full_list <- (c(list_data,list1))

unlist(list_data)

# List creating functions - split-apply-combine
debt <- data.frame(name = c('Dan', 'Dan', 'Dan', 'Rob', 'Rob', 'Rob'),
                   payment  = c(100, 200, 150, 50, 75, 100))

split_debt <- split(debt, debt$name)
split_debt$Dan$payment <- split_debt$Dan$payment * .8
split_debt$Rob$payment <- split_debt$Rob$payment * .9
unsplit(split_debt, debt$name)

##### Matrices #####

# Create a matrix
(M = matrix( 1:6, nrow = 2, ncol = 3, byrow = TRUE))

rownames = c("row1", "row2")
colnames = c("col1", "col2", "col3")

matrix(1:6, nrow = 2, ncol = 3, 
       byrow = TRUE, 
       dimnames = list(rownames, colnames))

# Another way to give names to columns and rows
colnames(M) <- colnames
rownames(M) <- rownames

# Calculate the sum of rows and columns
rowSums(M)
colSums(M)

# Access the element at 3rd column and 1st row
M[1,3]

# Access only the  2nd row
M[2,]

M[2, c('col2', 'col3')]

# Access only the 3rd column
M[,3]


(big_matrix <- cbind(M,M))

(big_matrix1 <- rbind(M,M))

x <- c(109.49, 109.90, 109.11, 109.95, 111.03)
y <- c(159.82, 160.02, 159.84, 160.35, 164.79)
cbind(x,y)
rbind(x,y)

##### Arrays #####

# Create an array
(a <- array(c('green','yellow'), dim = c(3,3,2)))

column_names <- c("COL1","COL2","COL3")
row_names <- c("ROW1","ROW2","ROW3")
matrix_names <- c("Matrix1","Matrix2")

result <- array(c('green','yellow'), dim = c(3,3,2),
                dimnames = list(row_names, column_names, matrix_names))


# Print the third row of the second matrix of the array
result[3,,2]

# Print the element in the 1st row and 3rd column of the 1st matrix
result[1,3,1]

# Print the 2nd Matrix
result[,,2]

##### Factors #####

# Create a factor object
(factor_color <- factor(c('green','green','yellow','red','red','red','green')))

nlevels(factor_color)

as.integer(factor_color)

(factor_color <- factor(c('green','green','yellow','red','red','red','green'),
                        ordered = TRUE, 
                        levels = c('yellow', 'red', 'green')))

# Change the name of levels
vec_survey <- c("M", "F", "F", "M", "M")
fac_survey <- factor(vec_survey)
levels(fac_survey) <- c("Female", "Male")

# Check the counts in each category
table(fac_survey)
summary(fac_survey)

# Creating factors from numeric values
x <- 1:50
group_num <- cut(x, c(0, 10, 20, 30, 40, 50))

# Removing levels
fac_survey <- fac_survey[c(2,3)]
table(fac_survey)

fac_survey <- fac_survey[c(2,3), drop = TRUE]
table(fac_survey)

##### Dates #####
# Get the current date
(today <- Sys.Date())

# See what today looks like under the hood
unclass(today)

x <- as.Date('1971-01-01')
class(x)

as.Date('Jan-13-82') # error will be thrown
as.Date('Jan-13-82', format = '%b-%d-%y')


as.Date('13 January, 1982', format = '%d %B, %Y')

unclass(x)

# Transforming dates into another format
date <- as.Date('2008-10-13')
format(date, format = "%B %d, %Y")

# Extracting information from a date
dates <- as.Date(c('2018-01-03', '2018-01-04'))
weekdays(dates)

# Get the current time: now
(now <- Sys.time())

# See what now looks like under the hood
unclass(now)

as.POSIXct("1971-05-14 11:25:15")

x <- lubridate::ymd_hm('1970-01-01 01:00')
class(x)
unclass(x)

y <- as.POSIXlt(x)
attributes(y)

# Finding the difference
today <- as.Date("2018-12-02")
tomorrow <- as.Date("2018-12-03")
tomorrow - today


##### Data Frames #####
# Create the data frame
BMI <- 	data.frame(
  gender = c("Male", "Male","Female"), 
  height = c(152, 171.5, 165), 
  weight = c(81,93, 78),
  Age = c(42,38,26),
  date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15")),
  stringsAsFactors = FALSE
  
)

BMI

# Test if the gender column is a factor
is.factor(BMI$gender)
BMI$gender

head(BMI)
tail(BMI)

str(BMI)
summary(BMI)

# Obtain names of columns
names(BMI)

# Extract the first two rows and all columns
BMI[1:2,]

# Extract 1rd and 3th row with 2nd and 4th column
BMI[c(1,3),c(2,4)]

# Access column by name
BMI$gender

data.frame(BMI$gender, BMI$height)

BMI[, 'gender']
BMI['gender']

BMI[, 'gender', drop = FALSE]

BMI[, c('gender', 'weight')]
BMI[c('gender', 'weight')]

BMI[[1]]
BMI[['gender']]


BMI <- BMI[c(5, 1:4)]

BMI[BMI$height > 170,]

subset(BMI, date > as.Date("2013-09-21"))

subset(BMI, subset = height > 170)
subset(BMI, subset = height < 170 & weight == 81)

positions <- order(BMI$height)
BMI[positions,]

# Check the maximum value in column 'Age'
max(BMI$Age)

# Get the details of the person
subset(BMI, Age == max(Age))

# Changing the values in a column
BMI$gender
lut <- c('Male' = 'M', 'Female' = 'F')
lut
BMI$gender <- lut[BMI$gender]
BMI

# Add the 'job' column
BMI$job <- c("IT","Operations","IT")

# Delete the column
BMI$job <- NULL

# Grouping and calculating summary statistics
head(BMI)
BMI_summary <- aggregate(BMI[2:4], list(BMI$gender), mean)
BMI_summary
names(BMI_summary)[1] <- "BMI"


# NULL and Missing Values
# Missing Values
x <- c(1, 3, 5, NA, 5)
is.na(x)

# Data frame with missing value
BMI <- 	data.frame(
  gender = c("Male", "Male","Female"), 
  height = c(152, 171.5, 165), 
  weight = c(81,NA, 78),
  Age = c(42,38,26),
  date = as.Date(c("2012-01-01", "2013-09-23", "2014-11-15")),
  stringsAsFactors = FALSE
  
)

# Find rows with no missing values
complete.cases(BMI)

x[!is.na(x)]

subset(BMI, !is.na(weight))

# Subset data, keeping only complete cases
BMI[complete.cases(BMI),]

# Automatically removing rows with missing values
na.omit(BMI)

sum(is.na(x))
