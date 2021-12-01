#------------------------------------------------------------------------------------

# create function to return current date info 

today <- function(){
  
# store todays date 

  today_date<- format(Sys.time() ,'%B %d, %Y' )
  return(today_date)
  
}
#------------------------------------------------------------------------------------


# Function(1)

# function that filter the data by categories 

# will need to load (tidyverse) library 

# search.cat will work in combination of multiple search terms 

# search.cat <- c("first search term" ,"second search term" , "third search term" )

# example = search.cat <- c("family" , "nationality")

cat_filter <- function(data , search.cat ){
  cat_filter <- data%>%
    filter(category == search.cat )
      return(cat_filter)
}
#------------------------------------------------------------------------------------

# Function(2)

#  Function that searches variable descriptions for a specific string and returns any variables that match. 
#  For example, if I searched for "income" I would want variables like median household income and per capita income.

search_description <- function(data , keywords) {
  search_description <- grepl(keywords , data$definition , ignore.case =T )
     search.keywords <- data[search_description , c("root", "category" ,"definition" )]
        return(search.keywords)
}

#------------------------------------------------------------------------------------

# Function(3)

# Function to filter variables by time periods. Specifically, 
# The user will specify the time periods of interest for the study and 
# The function will identify all variables that have measures for those periods. 

search_years <- function(data, years)
{
  
  # set column names to lowercase
  colnames(data) <- tolower(colnames(data))
  
  # set variables to lowercase
  data <- mutate_all(data, .funs = tolower)
  
  # remove empty strings and white spaces
  data <- data[!grepl("^\\s+$", data)]
  
  # replace missing values with NA
  data[ data == ""] <- NA
  
  # select root, root2, category, and definition columns to keep in data set
  columns <- c("root", "root2", "category", "definition")
  
  #list strings that we want to remove from our time period column names
  prefix <- c("x")
  suffix <- c(".f", ".s")
  
  # select data to keep
  df.years <- data %>%
    select(root, root2, category, definition, contains(years))
  
  #subset data to keep root, root2, and the columns that contain the names of our time period
  #data_cleaned <- data[, c(grepl( paste( c( time.periods, columns), collapse = "|"), colnames(data) )) ]
  
  # remove prefix and suffix from column names
  names <- colnames(df.years) %>%
    str_remove(prefix) %>%
    str_remove(suffix)
  
  # rename columns
  colnames(df.years) <- names
  
  # change years columns to long
  df.years.long <- df.years %>% pivot_longer( !columns, names_to = "year", values_to = "variable" ) %>% 
    na.omit() %>%
    distinct( root, year, variable)
  
  # create data sets of distinct root and year variables and combine for reference of all possible root/year combinations
  root <- df.years.long %>% distinct(root) %>% select(root)
  year <- df.years.long %>% distinct(year) %>% select(year)
  root_list <- crossing( root, year )
  
  # Left join root_list and df.years.long to identify variables for each year.
  root_variables <- left_join( root_list, df.years.long, by = c( "root", "year"))
  
  # List of roots with missing variables
  root_missing <- root_variables %>% filter( is.na( variable ) )
  
  # create final dataset
  data_final <- subset(df.years.long, !(df.years.long$root %in% root_missing$root))
  
  # join back to original dataset to add category and definition (and verify accuracy)
  data_final <- left_join(data_final, data, by = "root") %>%
    select(root, year, variable, category, definition)
  
  return(data_final)
  
  
}