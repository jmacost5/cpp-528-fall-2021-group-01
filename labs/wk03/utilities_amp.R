#
# Author:   April Peck
# Date:     October 21, 2021
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

# load necessary functions ----


# load all data as character vecs
d.2010.samp <- read.csv( here::here("data/raw/ltdb_std_2010_sample.csv"),
                         colClasses="character" )

# Remove missing value codes -999 and replace with variable mean or NAs.
d.2010.samp <- clean_d( d.2010.samp, start_column=5 )

# tidy up dataframes
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

# import the clean file 
d <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )

# load the crosswalk ----
# note: this stores a copy in the data/raw/ directory
cw <- obtain_crosswalk()

# create the final meta data file ----
# note: this stores a copy within the data/rodeo/ directory
create_final_metadata_file(file_names = RELEVANT_FILES,
                           crosswalk = cw)

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
