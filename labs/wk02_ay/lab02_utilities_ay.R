# create function ----
today <- function() {
  # store today's date
  today_date <- format(Sys.time(), '%B %d, %Y')
  # return today's date back to Global Environment
  return(today_date)
}

#-------------------------------------------------------

# Definition Keyword Search Function ----

# keywords <- c(" search term", "^search", "$keyword") #function to search for keywords
# example: keywords <- c("age")

keywords_search <- function( data, keywords )
{
  keyword.search <- grepl( keywords, data$category, ignore.case = TRUE)
  data.keywords <- data[ keyword.search, c("root", "root2", "category", "definition") ]
  
  return(data.keywords) # result of function
}

# data.keywords <- keywords_search(data, keywords) stores the results of function
# data.keywords # view results of function

#-------------------------------------------------------------

# Filter Data by Category Function ----

# library(tidyverse)

# search.terms <- c("first search term", "second search term", "third search term", "fourth search term")
# example: search.terms <- c("family", "nationality")

filter_data <- function( data, search.terms )
{
  filtered.data <- data %>% # input data set
    
    filter(category == search.terms) # filter data by search terms 
  
    return( filtered.data)
  
}

# Filter data by time periods ----

# time.periods <- ("timeperiod1", "timeperiod2", "timeperiod3")
# example: time.periods <- c("1990", "2000","2010")

#time.periods <- c("1990", "2000", "2010")
#data <- dd

variable_years <- function (data, time.periods) 
  {
  # Set column names to lowercase for easy searching
  colnames(data) <- tolower(colnames(data))
  
  # Set variable to lowercase for easy searching
  data <- mutate_all(data, .funs=tolower)
  
  # Remove empty strings and white spaces in data set
  data <- data[!grepl("^\\s+$", data)]
  
  # Select root and root 2 columns to keep in data set
  columns <- c("root", "root2")
  
  # Subset data to keep root, root2, and the columns that contain the names of our time period
  data_cleaned <- data[, c(grepl(paste(c(time.periods, columns), collapse = "|"), colnames(data)))]
  
  # List strings that we want to remove from our time period column names
  prefix <- c("x")
  suffix <- c(".f", ".s")
  
  # Remove x from front of column names and remove .f and .s from end of column names
  names <- colnames(data_cleaned) %>% str_remove(prefix) %>% str_remove(suffix)
  
  # Remove columns in data set
  colnames(data_cleaned) <- names
  
  # Change format of data set to have root, root2, a year column, and a variable column
  data_cleaned_long <- data_cleaned %>% pivot_longer(!columns, names_to = "year", values_to = "variable")
  
  # Remove missing variables, filter by year, and ensure output is distinct
  data_years <- data_cleaned_long %>% filter(root != "" & variable != "") %>% subset(year %in% time.periods)%>% distinct(root, year, variable)
  
  # Create data sets of distinct root and year variables
  root<- data_years %>% distinct(root) %>% select(root)
  year<- data_years %>% distinct(year) %>% select(year)
  
  # Merge root and year lists to create a reference of all possible roots and years
  root_lits <- crossing(root, year)
  
  # Perform a left join to root_list to identify variables for each year
  root_variables <- left_join(root_lits, data_years, by = c("root", "year"))
  
  # Find roots with variables missing for one of the years 
  root_missing <- root_variables %>% filter(is.na(variable))
  
  # Select all rows of data set that do not have any years missing
  data_final <- subset(data_years, !(data_years$root %in% root_missing$root))
  
  # Output data set
  data_final
}