#
# Author:   Cristian Nuno
# Maintainers: April Peck, Ahmed Rashwan, Erin McIntyre, Alev Yuldasiz
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

cat_filter <- function(data , search.cat ){
  cat_filter <- data%>%
    filter(category == search.cat )
      return(cat_filter)
}

# TWO: Create a function that searches variable descriptions for a specific string and returns 
# any variables that match. For example, if I searched for “income” I would want variables like 
# median household income and per capita income.

# search for data with keyword ----

search_description <- function(data , keywords) {
  search_description <- grepl(keywords , data$definition , ignore.case =T )
     search.keywords <- data[search_description , c("root","root2", "category" ,"definition" )]
        return(search.keywords)
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



### Lab 03 Functions
build_year <- function( fn1, fn2, year )
{
  
  d1 <- tidy_up_data( fn1 )
  d1 <- dplyr::select( d1, - type )
  
  d2 <- tidy_up_data( fn2 )
  d2 <- dplyr::select( d2, - type )
  
  d3 <- merge( d1, d2, by=c("year","tractid"), all=T )
  
  # store the file path as a character vector
  file.name <- paste0( "data/rodeo/LTDB-", year, ".rds" )
  # export the object to the file path from above using here::here()
  saveRDS( d3, here::here( file.name ) )
  
}


# store relevant raw data files
relevant_files = list.files(here::here("data/raw"), pattern = "(s|S)td.*.csv")

# store relevant years
YEARS <- as.character(seq(1970, 2010, 10))

# create empty list
RELEVANT_FILES = list()

# for each relevant year
for (year in YEARS) {
  # extract year specific files
  year_condition = stringr::str_detect(relevant_files, year)
  # subset the relevant files
  year_files = relevant_files[year_condition]
  # subset the fullcount filename
  fullcount_file = year_files[stringr::str_detect(year_files, "fullcount")]
  # subset the sample filename
  sample_file = year_files[stringr::str_detect(year_files, "sample")]
  
  # add to the empty list
  RELEVANT_FILES[[year]] = list(
    "year" = year,
    "fullcount" = fullcount_file,
    "sample" = sample_file
  )
}


obtain_crosswalk = function() {
  # store crosswalk URL
  URL <- "https://data.nber.org/cbsa-msa-fips-ssa-county-crosswalk/cbsatocountycrosswalk.csv"
  # read in as data frame
  cw <- read.csv( URL, colClasses="character" )
  # note in the data dictionary for CBSA Name (copied below): “blanks are rural”
  cw$urban <- ifelse( cw$cbsaname == "", "rural", "urban" )
  # store relevant columns
  keep.these <- c( "countyname","state","fipscounty", 
                   "msa","msaname", 
                   "cbsa","cbsaname",
                   "urban" )
  # filter the crosswalk
  cw <- dplyr::select( cw, keep.these )
  
  # drop the duplicated fips county codes
  cw <- cw[ ! duplicated(cw$fipscounty) , ]
  
  # save for future use
  saveRDS( cw, here::here( "data/raw/cbsa-crosswalk.rds") )
  
  # return to user
  return(cw)
}


extract_metadata <- function( file.name )
{
  # store the file path as a character vector
  path <- paste0( "data/raw/", file.name )
  # import the file using the file path inside of here::here()
  d <- read.csv( here::here( path ), colClasses="character" )
  type <- ifelse( grepl( "sample", file.name ), "sample", "full" )
  year <- substr( file.name, 10, 13 )
  
  # fix names
  d <- fix_names( d )
  
  # fix leading zero problem in tract ids
  d$tractid <- fix_ids( d$tractid )
  
  # drop meta-vars
  keep.these <- c("tractid","state", "county", "tract", "placefp10",
                  "cbsa10", "metdiv10", "ccflag10",
                  "globd10", "globg10","globd00", "globg00",
                  "globd90", "globg90","globd80", "globg80")
  d <- d[ names(d) %in% keep.these ]
  return( d )
}

# make final metadata file
create_final_metadata_file = function(file_names, crosswalk) {
  # filter the crosswalk
  # note: unique ID still persists through the FIPS column
  cw = dplyr::select(crosswalk, -countyname, -state)
  
  # extract metadata for 1980-2000
  md_2000 <- extract_metadata( file.name=file_names[["2000"]][["fullcount"]] )
  
  md_1990 <- extract_metadata( file.name=file_names[["1990"]][["fullcount"]] )
  md_1990 <- dplyr::select( md_1990, tractid, globd90, globg90 )
  
  md_1980 <- extract_metadata( file.name=file_names[["1980"]][["fullcount"]] )
  md_1980 <- dplyr::select( md_1980, tractid, globd80, globg80 )
  
  # merge metadata into one data frame
  # note: these are outer joins, meaning if a record from 2000 isn't found in
  #       in 1990, those "missing" records are still returned
  md_complete <- merge( md_2000, md_1990, all=T )
  md_complete <- merge( md_complete, md_1980, all=T )
  
  # create the fips county column
  # TODO: avoid hard coding index values
  md_complete$fipscounty <- paste0( substr( md_complete$tractid, 6, 7 ),
                                    substr( md_complete$tractid, 9, 11 ) )
  
  # merge fips data onto metadata
  # note: this is a left join, all records from md_complete will be returned
  md_complete_with_cw <- merge( md_complete, 
                                cw, 
                                by="fipscounty", 
                                all.x=T )
  
  # save metadata
  saveRDS( md_complete_with_cw, here::here( "data/rodeo/LTDB-META-DATA.rds" ) )
}


# find common variables that are in two datasets
compare_dfs <- function( df1, df2 )
{
  # use regular expressions to remove numeric suffixes 
  var.names.1 <- names( df1 )
  var.names.1 <- gsub( "[.][xy]$", "", var.names.1 )
  var.names.1 <- gsub( "[0-9]{2}$", "", var.names.1 )
  
  var.names.2 <- names( df2 )
  var.names.2 <- gsub( "[.][xy]$", "", var.names.2 )
  var.names.2 <- gsub( "[0-9]{2}$", "", var.names.2 )
  
  shared <- intersect( var.names.1, var.names.2 ) %>% sort()
  print( "SHARED VARIABLES:")
  print( shared )
  
  not.shared <- c( setdiff( var.names.1, var.names.2 ),
                   setdiff( var.names.2, var.names.1 ) ) %>% sort()
  
  print( "NOT SHARED:" )
  print( not.shared )
  
  d.vars1 <- data.frame( type="shared", variables=shared, stringsAsFactors=F )
  d.vars2 <- data.frame( type="not shared", variables=not.shared, stringsAsFactors=F )
  dd <- rbind( d.vars1, d.vars2 )
  
  return( dd )
}


# function to control plot() formatting 
jplot <- function( x1, x2, lab1="", lab2="", draw.line=T, ... )
{
  
  plot( x1, x2,
        pch=19, 
        col=gray(0.6, alpha = 0.2), 
        cex=2.5,  
        bty = "n",
        xlab=lab1, 
        ylab=lab2, cex.lab=1.5,
        ... )
  
  if( draw.line==T ){ 
    ok <- is.finite(x1) & is.finite(x2)
    lines( lowess(x2[ok]~x1[ok]), col="red", lwd=3 ) }
  
}
