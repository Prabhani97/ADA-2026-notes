#setup

install.packages("tidyverse")
install.packages("data.table")

library(tidyverse)
library(data.table)

f<-"/Users/pha268/Downloads/ANT 388C/ada-datasets-main/random-people.csv"
data<-read_csv(f, col_names=TRUE)

#1) Matrices (2D numeric table)

m <- matrix(data = c(1, 2, 3, 4), nrow = 2, ncol = 2)
m

#Column-wise vs row-wise filling
#Column-wise (default)

m <- matrix(1:6, nrow = 2, ncol = 3, byrow = FALSE)
m

#Row-wise

m <- matrix(1:6, nrow = 2, ncol = 3, byrow = TRUE)
m

#Build matrices from vectors: rbind() and cbind()

v1 <- c(1, 2, 3, 4)
v2 <- c(6, 7, 8, 9)

m1 <- rbind(v1, v2)  # rows
m2 <- cbind(v1, v2)  # columns

m1
m2

#metadata tools

class(m1)    # what type is it?
dim(m1)      # rows, columns
rownames(m1) # row names
colnames(m2) # column names
str(m1)      # structure (super useful)

#2) Arrays

# 3D Array

a <- array(data = 1:90, dim = c(5, 6, 3))
a

#3) Subsetting (extracting parts) using [ ]

#Vectors (1D)

v <- 1:100
v[1:15]              # first 15
v[c(2, 4, 6, 8, 10)]  # specific positions

#Try seq() indexing

v <- 101:200
v[seq(from = 1, to = 100, by = 2)]  # every 2nd element

#Matrices (2D): [row, col]

#Create the matrix:
  
m <- matrix(1:80, nrow = 8, ncol = 10, byrow = FALSE)
m

#Extract single element:
  
m[4, 5]

#Extract whole row:
  
m[4, ]

#Extract whole column:
  
m[, 5]

#Extract block:
  
m[2:6, 2:9]

# challenge answers (from text)
#2nd, 3rd, 6th columns
x <- m[, c(2, 3, 6)]
x

#6th to 8th rows
x <- m[6:8, ]
x

#Row 2 col 2 to row 6 col 9
x <- m[2:6, 2:9]
x

#4) Overwriting elements (changing values)

m <- matrix(1:80, nrow = 8, ncol = 10, byrow = FALSE)
m

m[7, 1] <- 564   # change one cell
m[, 8] <- 2      # entire column becomes 2
m[2:5, 4:8] <- 1 # a block becomes 1
m

#Important warning:
  
m[, 8] <- c("a", "b") #This will convert the whole matrix to character (because matrices can only hold one type).
#This is a common beginner bug.

#5) Lists (can hold different types)

#Lists are like “containers” that can store anything.

s <- c("this", "is", "a", "vector")
m <- matrix(1:40, nrow = 5, ncol = 8)
b <- FALSE

l <- list(s, m, b)
l

#Subsetting lists: [[ ]] vs [ ]

#Single element (gives the item itself):
  
l[[2]]  # returns the matrix

#Multiple items (returns a list):
  
l[2:3]

#[ ] keeps it as a list

#Access inside list element
l[[2]][2, 6]   # row 2, col 6 inside the matrix
l[[2]][2, ]    # entire row 2
l[[2]][, 6]    # entire column 6

#Naming list elements + $
names(l) <- c("string", "matrix", "logical")

l$string
l$matrix[3, 5]


