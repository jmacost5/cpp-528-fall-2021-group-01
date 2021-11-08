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

# Lab 03 Functions and Data Steps
# Date: November 3, 2021

#-------------------------------------------------------------------------------

# The following functions were created by:
# Author:     Jesse Lecy
# Maintainer: Cristian Nuno
# Date:       March 21, 2021
# Purpose:    Create custom functions to pre-process the LTDB raw data files

# load necessary packages ----
library( dplyr )
library( here )
library( knitr )
library( pander )

# create custom cleaning function ----
# convert variables to numeric
# and remove missing values placeholders;
# impute missing values with mean
clean_x <- function( x )
{
  x <- as.numeric( x )
  x[ x == -999 ] <- NA
  mean.x <- mean( x, na.rm=T )
  x[ is.na(x) ] <- mean.x
  return(x)
}

# apply the clean var x function to all columns 
clean_d <- function( d, start_column )
{
  these <- start_column:ncol(d)
  d[ these ] <- lapply( d[ these ], clean_x )
  
  return( d )
}

# FIX VARIABLE NAMES
# input dataframe
# standardize variable names 
# output data frame with fixed names
fix_names <- function( d )
{
  nm <- names( d )
  nm <- tolower( nm )
  
  nm[ nm == "statea"  ] <- "state"
  nm[ nm == "countya" ] <- "county"
  nm[ nm == "tracta"  ] <- "tract"
  nm[ nm == "trtid10" ] <- "tractid"
  nm[ nm == "mar-70"  ] <- "mar70"
  nm[ nm == "mar-80"  ] <- "mar80"
  nm[ nm == "mar-90"  ] <- "mar90"
  nm[ nm == "mar.00"  ] <- "mar00"
  nm[ nm == "x12.mar" ] <- "mar12"  
  nm <- gsub( "sp1$", "", nm )
  nm <- gsub( "sp2$", "", nm )
  nm <- gsub( "sf3$", "", nm )
  nm <- gsub( "sf4$", "", nm )
  
  # nm <- gsub( "[0-9]{2}$", "", nm )
  
  names( d ) <- nm
  return( d )
}

# FIX TRACT IDS
# put into format: SS-CCC-TTTTTT
fix_ids <- function( x )
{
  x <- stringr::str_pad( x, 11, pad = "0" )
  state <- substr( x, 1, 2 )
  county <- substr( x, 3, 5 )
  tract <- substr( x, 6, 11 )
  x <- paste( "fips", state, county, tract, sep="-" )
  return(x)
}


tidy_up_data <- function( file.name )
{
  # store the file path as a character vector
  path <- paste0( "data/raw/", file.name )
  # read in the file path using here::here()
  d <- read.csv( here::here(path), colClasses="character" ) 
  type <- ifelse( grepl( "sample", file.name ), "sample", "full" )
  year <- substr( file.name, 10, 13 )
  
  # fix names 
  d <- fix_names( d )
  
  # fix leading zero problem in tract ids
  d$tractid <- fix_ids( d$tractid )
  
  # drop meta-vars
  drop.these <- c("state", "county", "tract", "placefp10",
                  "cbsa10", "metdiv10", "ccflag10", 
                  "globd10", "globg10","globd00", "globg00",
                  "globd90", "globg90","globd80", "globg80")
  d <- d[ ! names(d) %in% drop.these ]
  
  # column position where variables start after IDs
  d <- clean_d( d, start_column=2 )
  
  # add year and type (sample/full)
  d <- data.frame( year, type, d, stringsAsFactors=F )
  
  return( d )
}

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

# wk03_project_data_steps ------------------------------------------------------

# The following functions were taken from the wk03_project_data_steps file

# Author:     Jesse Lecy
# Maintainer: Cristian Nuno
# Date:       March 21, 2021
# Purpose:    Create custom functions to pre-process the LTDB raw data files
#

# load necessary functions ----
# note: all of these are R objects that will be used throughout this .rmd file
import::here("build_year",
             "RELEVANT_FILES",
             "obtain_crosswalk",
             "create_final_metadata_file",
             # notice the use of here::here() that points to the .R file
             # where all these R objects are created
             .from = here::here("labs/utilities.R"),
             .character_only = TRUE)

# for each relevant file, run the build_year() function ----
# note: this populates the data/rodeo/ directory with clean files
for (relevant_file in RELEVANT_FILES) {
  print(paste0("Starting on ", relevant_file[["year"]]))
  build_year(fn1 = relevant_file[["fullcount"]],
             fn2 = relevant_file[["sample"]],
             year = relevant_file[["year"]])
  if (relevant_file[["year"]] < 2010) {
    print("Finished! Moving onto the next decade.")
  } else {
    print("Finished! No more data to parse.")
  }
}

# load the crosswalk ----
# note: this stores a copy in the data/raw/ directory
cw <- obtain_crosswalk()

# create the final meta data file ----
# note: this stores a copy within the data/rodeo/ directory
create_final_metadata_file(file_names = RELEVANT_FILES,
                           crosswalk = cw)

# end of script #

#-------------------------------------------------------------------------------

# The following data processing steps were created using instructions and code 
# from the Lab 03 Data Steps tutorial.

# load necessary packages ----
library( dplyr )
library( import )
library( here )
library( knitr )
library( pander )

# import specific functions ----
import::here("clean_d",
             "tidy_up_data",
             "build_year",
             "RELEVANT_FILES",
             "obtain_crosswalk",
             "create_final_metadata_file",
             # notice the use of here::here() that points to the .R file
             # where all these R objects are created
             .from = here::here("labs/wk03/wk03_utilities.R"),
             .character_only = TRUE)

# load all data as character vecs ----
d.2010.samp <- read.csv( here::here("data/raw/ltdb_std_2010_sample.csv"),
                         colClasses="character" )

# Remove missing value codes ----
# first four columns are unique IDs - leave them as character vectors
d.2010.samp <- clean_d( d.2010.samp, start_column=5 )

# Standardize datasets across all years ----

file.name <- "ltdb_std_2010_sample.csv"
d.2010.s <- tidy_up_data( file.name )
file.name <- "LTDB_Std_2010_fullcount.csv"
d.2010.f <- tidy_up_data( file.name )
d2 <- bind_rows( d.2010.s, d.2010.f )
file.name <- "ltdb_std_2000_sample.csv"
d.2010.s <- tidy_up_data( file.name )
file.name <- "LTDB_Std_2000_fullcount.csv"
d.2010.f <- tidy_up_data( file.name )
d2 <- bind_rows( d.2010.s, d.2010.f )

# for each relevant file, run the build_year() function ----
# note: this populates the data/rodeo/ directory with clean files
for (relevant_file in RELEVANT_FILES) {
  print(paste0("Starting on ", relevant_file[["year"]]))
  build_year(fn1 = relevant_file[["fullcount"]],
             fn2 = relevant_file[["sample"]],
             year = relevant_file[["year"]])
  if (relevant_file[["year"]] < 2010) {
    print("Finished! Moving onto the next decade.")
  } else {
    print("Finished! No more data to parse.")
  }
  
}

# import the clean file ----
d <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )


# load the crosswalk ----
# note: this stores a copy in the data/raw/ directory
cw <- obtain_crosswalk()

# create the final meta data file ----
# note: this stores a copy within the data/rodeo/ directory
create_final_metadata_file(file_names = RELEVANT_FILES,
                           crosswalk = cw)

#-------------------------------------------------------------------------------


# function to control plot() formatting ----

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

#-------------------------------------------------------------------------------
