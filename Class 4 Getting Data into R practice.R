

#1) Picking a local file path

#Option A: Interactive picker

f <- file.choose() #Why important: Prevents path-typing mistakes when you’re new.
f

#Option B: Manually set the path

f <- "/Users/pha268/Downloads/ANT 388C/ada-datasets-main/CPDS-1960-2014-reduced.csv"
getwd()

#2) Reading a CSV (local)

#Base R method 1: read.table()

d <- read.table(f, header = TRUE, sep = ",", stringsAsFactors = FALSE)
head(d)

class(d)

#Base R method 2: read.csv() (simpler defaults)

d <- read.csv(f, header = TRUE, stringsAsFactors = FALSE)

#3) Reading a TXT/TSV (local)
#Base R with tab separator

f <- "/Users/pha268/Downloads/ANT 388C/ada-datasets-main/CPDS-1960-2014-reduced.txt"
d <- read.table(f, header = TRUE, sep = "\t", stringsAsFactors = FALSE, fill = TRUE)
head(d)

#Easier base R function: read.delim()

d <- read.delim(f, header = TRUE, stringsAsFactors = FALSE)

#4) Reading with tidyverse {readr} (recommended)

library(tidyverse)

#CSV

d <- read_csv(f, col_names = TRUE)
head(d)
class(d)

#TSV

f<-file.choose()
d <- read_tsv(f, col_names = TRUE)
head(d)

#What happens : Reads tab-separated text into a tibble.

#The “wrong delimiter” example in notes

d <- read_delim(f, delim = "\n", col_names = TRUE)

#Rule - If the file is tab-separated, your delimiter must be "\t", not "\n".

#Correct:
  
d <- read_delim(f, delim = "\t", col_names = TRUE)

#5) Reading Excel (.xlsx)

library(readxl)
f <- file.choose()
d <- read_excel(f, sheet = 1, col_names = TRUE)
head(d)
str(d)

#6) Reading directly from GitHub (remote files)

library(tidyverse)

url <- "https://raw.githubusercontent.com/difiore/ada-datasets/main/CPDS-1960-2014-reduced.csv"
d <- read_csv(url)
head(d)

url <- "https://raw.githubusercontent.com/difiore/ada-datasets/main/CPDS-1960-2014-reduced.txt"
d <- read_tsv(url)
head(d)

#curl() method (older style)

library(curl)
f <- curl("https://raw.githubusercontent.com/difiore/ada-datasets/main/CPDS-1960-2014-reduced.csv")
d <- read.csv(f, stringsAsFactors = FALSE)
head(d)




