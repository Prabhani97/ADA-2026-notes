library(tidyverse)
library(data.table)

f<-"/Users/pha268/Downloads/ANT 388C/ada-datasets-main/random-people.csv"
data<-read_csv(f, col_names=TRUE)

#6) Data frames

#Create one

df <- data.frame(
  firstName = c("Rick", "Negan", "Dwight", "Maggie", "Michonne"),
  community = c("Alexandria", "Saviors", "Saviors", "Hiltop", "Alexandria"),
  sex = c("M", "M", "M", "F", "F"),
  age = c(42, 40, 33, 28, 31)
)
df

#7) Reading the CSV (random-people.csv)

df <- read.csv(f, stringsAsFactors = FALSE)

#Immediately inspecting data

head(df)
str(df)
glimpse(df)   # from tidyverse, very readable

#8) Selecting columns from a data frame

df[, 4]

#By name using $
df$name.last

#By [[ ]] (also column extraction)
df[[4]]

#A) Vector vs data frame: [ ] vs [[ ]] vs $
#1) Extract ONE column as a vector

#These give a vector (simple list of values):
  
df[[4]]
df[["name.last"]]
df$name.last

length(df$name.last)
unique(df$name.last)

#2) Extract ONE column but keep it as a data frame

#These give a data frame with 1 column (still a table):
  
df[4]
df["name.last"]


# Why important:Useful when we want to keep it “table-shaped”, for joining, writing to CSV, selecting multiple columns.

class(df[4])
class(df[[4]])

#B) Adding columns: cbind() vs $ vs df[["new"]]
#1) Add an ID column

df$id <- 1:nrow(df)
head(df)

#Why important:IDs are needed to merge datasets, track participants, link tables.

#2) Add a new categorical column (school)

df$school <- c("UT","UT","A&M","A&M","UT","Rice","Texas Tech",
                 "UT","UT","Texas State","A&M","UT","Rice","UT",
                 "A&M","Texas Tech","A&M","UT","Texas State","A&M")
str(df$school)


#Why important:Most models use categorical predictors (group, condition, site, etc.)

#3) Why cbind() can be annoying

#cbind(df, school=...) can sometimes convert character to factor (depends on settings and what df already is).

#Use $ or df[["new"]] <- ...

df[["school"]] <- df$school  # same result, just different syntax
df

#C) Filtering rows using logical conditions 
#1) Filter UT only

new_df <- df[df$school == "UT", ]
new_df
df$school == "UT"

#2) AND condition: UT AND female

new_df <- df[df$school == "UT" & df$gender == "female", ]
new_df

#3) OR condition: UT OR female, and select only 3 columns

new_df <- df[df$school == "UT" | df$gender == "female",
             c("gender", "name.first", "name.last")]
new_df


#D) Selecting columns: by name, by position, by excluding
#1) Select by names

df[, c("name.last", "name.first", "school")]

#2) Select by column numbers and reorder

df[, c(1, 4, 3)]

#3) Exclude columns using minus -

df[, -c(1, 2, 5:18)]

#E) Factors - A factor is a categorical variable stored efficiently


df$school_factor <- as.factor(df$school)
str(df$school_factor)
df$school_factor

df$school_char <- as.character(df$school_factor)
str(df$school_char)

#F) NA, Inf, NaN (fast)

sqrt(-1)      # NaN
1/0           # Inf
0/0           # NaN
as.numeric("hi")  # NA

x <- c(1, 2, NA, 4)
mean(x)            # NA
mean(x, na.rm=TRUE) # works

#G) Challenge answers 

#1) Store numbers as 5x3 matrix, row-wise
m <- matrix(c(3,0,1, 23,1,2, 33,1,1, 42,0,1, 41,0,2),
            nrow = 5, ncol = 3, byrow = TRUE)
m

#2) Coerce to data frame
d <- as.data.frame(m)
d

#3) Make 2nd column logical
d[[2]] <- as.logical(d[[2]])
d

#4) Make 3rd column factor
d[[3]] <- as.factor(d[[3]])
d

#5) Check types
str(d)

#H) data.table vs data.frame vs tibble (quick differences)

#1) data.table: fast + clean filtering syntax
library(data.table)

dt <- as.data.table(df)
dt[school == "UT"]          # filter
dt[gender == "male", .(name.first, name.last)]  # select cols


# Why important:When datasets get big, data.table is much faster and simpler for filtering.

#2) tibble: safer data frame (tidyverse default)
library(tidyverse)

t <- as_tibble(df)
t
t[, "name.title"]      # always returns a tibble (never surprises you)


#Why important:Tibbles avoid weird behaviors (partial matching, silent recycling).

