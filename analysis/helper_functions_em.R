#
# Author: Erin McIntyre
# Date: October 27, 2021
# Purpose: Helper functions I create will be recorded here instead of in "utilities.R".
#

#-------------------------------------------------------------------------------

# Filter Data by Category Function ----

# library(tidyverse)

# search.terms <- c("first search term", "second search term", "third search term", "fourth search term") # function to search for keywords
# example: search.terms <- c("family", "nationality")

filter_data <- function( data, search.terms )
{
  
  filtered.data <- data %>% # input data set
    
    filter(category == search.terms) %>% # filter data by search terms designated above
    select(root, root2, category, definition) # limit which rows are output
  
  return( filtered.data) # results of function
  
}

# filtered.data <- filter_data(data, search.terms) # store results of function
# filtered.data # view results


#-------------------------------------------------------------------------------

# Definition Keyword Search Function ----

# keywords <- c(" search term", "^search", "$keyword") # function to search for key words
# example: keywords <- c(" age")

keyword_search <- function( data, keywords)
{
  
  keywords.search <- grepl( keywords, data$definition, ignore.case = T) # function to search definitions for identified keywords
  data.keywords <- data [ keywords.search, c("root", "root2", "category", "definition")] # filter data set for variables that match definitions
  
  return( data.keywords ) # results of function
  
}

# data.keywords <- keyword_search (data, keywords) # store results of function
# data.keywords # view results of function


#-------------------------------------------------------------------------------

# Filter Variables by Time Period ----

# chosen.time <- c("$decade") # select specific time periods or decades from 1970 to 2010 and 2012
# example: chosen.time <- c("$80", "$90")

## **The function below contains code that does not work. I explain the error 
## messages received from the code. The code that has been commented out within 
## the function was a second attempt which also failed due to an error message.**

filter_time_period <- function( data, chosen.time)
{
#  filtered.time <- data %>% 
#    col.time <- select(X1970.f:X2010.s) %>% 
    # tried to do select c("X1970.f", "X1970.s", "X1980.f", "X1980.s", "X1990.f", "X1990.s", "X2000.f", "X2000.s", "X2010.f", "X2010.s") %>% 
#    filter(col.time == chosen.time)
    
#    return(filtered.time) ## resulted in error message about X1970.f not existing. 
  
  filtered.time <- grepl( chosen.time, data$X1970.f, data$X1970.s, 
                          data$X1980.f, data$X1980.s,
                          data$X1990.f, data$X1990.s,
                          data$X2000.f, data$X2000.s,
                          data$X2010.f, data$X2010.s) # function to search time period variables for the chosen time
  data.time.period <- data [ filtered.time, c("root", "root2", "category", "definition")]
  
  return(data.time.period) # returns a table of variables for that chosen time
}


## Thought process on how I would describe data steps:

## 1) Function to identify all variables that have measures for periods specified by the user.

## 2) This function selects columns which contain the time variables.

## 3) Filters variables from the chosen time.

## 4) Returns a table with variables for the chosen time.



#-------------------------------------------------------------------------------
