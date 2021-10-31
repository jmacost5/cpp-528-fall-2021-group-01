#
# Author:   Cristian Nuno
# Date:     March 14, 2021
# Purpose:  Create a function that will be sourced within another file
#

# create function ----
today <- function() {
  # store today's date
  today_date <- format(Sys.time(), '%B %d, %Y')
  # return today's date back to Global Environment
  return(today_date)
}


# ONE: Filter variables by theme or group. Write a function that takes as an argument one or more 
# of the groups that you just created in the concordance file under the “category” field and returns 
# all of the variables associated with that group.

# filter data by category ----

category_search <- function( data, search_term )
{
  keyword.search <- grepl( search_term, data$category, ignore.case = TRUE)
  data.category <- data[ keyword.search, c("root", "root2", "category", "definition") ]
  
  return(data.category)
}

# TWO: Create a function that searches variable descriptions for a specific string and returns 
# any variables that match. For example, if I searched for “income” I would want variables like 
# median household income and per capita income.

# search for data with keyword ----

search_word <- function( data, keyword )
{
  keyword.search <- grepl( keyword, data$definition, ignore.case = TRUE)
  data.keywords <- data[ keyword.search, c("root", "root2", "category", "definition")]
  
  return( data.keywords)
}


# THREE: Create a function to filter variables by time periods. Specifically, the user will 
# specify the time periods of interest for the study and the function will identify all variables 
# that have measures for those periods. For example, I if I want to use the data for a study that 
# covers 1990, 2000, and 2010 which variables are available for all three periods?

# Note that column names contain the time periods, so similar to the previous function you can use 
# grepl() to identify all columns that meet your critera. Once you have selected the appropriate columns 
# you need to write a logical statement that checks variable availability for each year. We do not care 
# whether the measure comes from the full Census, the long form sample, or the ACS as long as at least 
# one measure is availabe for each of the specified time periods.

# Return a table with all of the variables that meet the criteria.

# search by year(s) ----

search_years <- function(data, years)
{
  
  df.years <- data %>%
    select(root, root2, category, definition, contains(years))
  
  return(df.years)
  
}
