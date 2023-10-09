# git-MichaelJosva

# for this assignment I chose to use Skeleton 2. 

setwd("/Users/michaeljosvawoldikechristensen/Desktop/Master_NHH/R_programming_for_Data_Science/Git_R_programmering/mj_assignment1/git-MichaelJosva")

library(tidyverse)    # Contains most of what we need.

raw_file <- readLines(con = "suites_dw_Table1.txt") # using readLine to read a txt file
Line_L <- 14 # here is the separator line for this dataset

  # Locating the lines defined y the first two letters == "--"
Lines <- substr(x = raw_file, start = 1, stop = 2)
Lines # see the answer

  # locating the first (minimum) index location for the separator line:
L <- (substr(x = raw_file, start = 1, stop = 2) == "--") %>%  # generates TRUE/FALSE list
  which() %>% # print index of TRUES with which function
  min() # selects minimum index (the first position) with minimum funcion

  # Save the description of the variables in a separate file:
cat(raw_file[1:(L-2)], sep = "\n", file = "descriptions")

  # Save the data for the varables in a separate file: (not necessary)
cat(raw_file[(L+1):length(raw_file)], sep = "\n", file = "data")


# Extract the variable names (i.e. line (L-1)), store the names in a vector.
    # To exract on line of variable names, I use the str_split funciont, and 
    # specifying the row L-1. 
    # It uses the pattern "\\|" as a separator. \\ avoids the have the program
    # interpet | as a logival operator.
    
variable_names <- 
  str_split(string = raw_file[L-1], pattern = "\\|") %>% # creates a list of oe observation with the whole row as values.
  unlist() %>% # unlists and creates a value vector
  str_trim() # trims for empty spaces

variable_names # for inspection

# to read the data:
  # transform to a comma separated file (a csv file) by replacing separators with
  # a comma, and eliminating empty spaces.

comma_separated_values <- 
  raw_file[L+1:length(raw_file)] %>% # sepcifices to use the data rows from L+1
  gsub("\\|", ",", .) %>%  # replaces the separator | with a comma
  gsub(" ", "", .) # removes empty spaces

comma_separated_values # for inspection

# combining the datasection and the variable name section
comma_separated_values_with_names <- 
  c(paste(variable_names, collapse = ","), # the collapse function 
        # specifies that the output should be a single string 
        # separated with commas. This creates the data for the csv file we want.
    comma_separated_values)    

comma_separated_values_with_names # for inspetion

# Using cat function we can generate a new file
  # using the separator "\n" tells the program to put this at the end of each line.
  # this is used the the csv file.
cat(comma_separated_values_with_names, sep = "\n", file = "raw_file_edit.csv")

# Read the file back in as a normal csv-file. The readr-package is part of
# tidyverse, so it is already loaded.
galaxies <- read_csv("raw_file_edit.csv")
summary(galaxies)

head(galaxies)
tail(galaxies)

# Now I have a CSV file with the variable names and data in the right positions
# in a dataframe. 





