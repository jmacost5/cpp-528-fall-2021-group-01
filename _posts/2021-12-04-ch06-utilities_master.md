---
title: Data Manifest
subtitle: "Functions and data steps used in analysis. Taken from *utilities_master.R*"
---

```
# Set stargazer type
s.type <- "html"
```

# Lab 02 Functions--------------------------------------------------------------

## Create example function
```
today <- function() {

  # store today's date
  today_date <- format(Sys.time(), '%B %d, %Y')
  
  # return today's date back to Global Environment
  return(today_date)
}
```


## Function One

This function filters the data by categories.

```
# will need to load (tidyverse) library 
# search.cat will work in combination of multiple search terms 
# search.cat <- c("first search term" ,"second search term" , "third search term" )
# example = search.cat <- c("family" , "nationality")

cat_filter <- function(data , search.cat ){
  cat_filter <- data%>%
    filter(category == search.cat )
  return(cat_filter)
}
```

## Function Two

Function that searches variable descriptions for a specific string and returns any variables that match. For example, if I searched for "income" I would want variables like median household income and per capita income.

```
search_description <- function(data , keywords) {
  search_description <- grepl(keywords , data$definition , ignore.case =T )
  search.keywords <- data[search_description , c("root", "category" ,"definition" )]
  return(search.keywords)
}
```

## Function Three

Function to filter variables by time periods. Specifically, the user will specify the time periods of interest for the study and the function will identify all variables that have measures for those periods. 

```
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
```

# Lab 03 Functions--------------------------------------------------------------

```
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
```

```
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
```

```
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
```

```
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

```

## Make final metadata file.

```
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
```

```
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
```

## Function to control plot() formatting 

```
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
```

## Wrangle data to create shapefile for chloropleth map

```
# load data
crosswalk <- read.csv( "https://raw.githubusercontent.com/DS4PS/cpp-529-master/master/data/cbsatocountycrosswalk.csv",  stringsAsFactors=F, colClasses="character" )

# search for cities names by strings, use the ^ anchor for "begins with" 

grep( "^SAN FRAN", crosswalk$msaname, value=TRUE ) 
these.sf <- crosswalk$msaname == "SAN FRANCISCO, CA"   # Find San Francisco (T/F)
these.fips <- crosswalk$fipscounty[ these.sf ]         # Find SF counties
these.fips <- na.omit( these.fips )

state.fips <- substr( these.fips, 1, 2 )                    # Substring state code
county.fips <- substr( these.fips, 3, 5 )                   # substring county codes

sf.pop <-
  get_acs( geography = "tract", variables = "B01003_001",
           state = "06", county = county.fips[state.fips=="06"], geometry = TRUE ) %>% 
  select( GEOID, estimate ) %>%
  rename( POP=estimate )
#sanfran.pop$GEOID<-substr(sanfran.pop$GEOID,2,length(sf.pop$GEOID)) # remove leading 0's

```


# Lab 04 Functions--------------------------------------------------------------

```
# load necessary packages 
`%>%` <- magrittr::`%>%`
```

```
# load necessary constants 

# stargazer settings
S_TYPE <- "text"

# inflation rate
INFLATION_RATE <- 1.28855 
```

## Load custom functions

```
# Helper functions for the **pairs()** correlation table 
panel.cor <- function(x, y, digits=2, prefix="", cex.cor)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex <- 0.8/strwidth(txt)
  
  test <- cor.test(x,y)
  # borrowed from printCoefmat
  Signif <- symnum(test$p.value, corr = FALSE, na = FALSE,
                   cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                   symbols = c("***", "**", "*", ".", " "))
  
  text(0.5, 0.5, txt, cex = 1.5 )
  text(.7, .8, Signif, cex=cex, col=2)
}

panel.smooth <- function (x, y, col = par("col"), bg = NA, pch = par("pch"), 
                          cex = 0.5, col.smooth = "red", span = 2/3, iter = 3, ...) 
{
  points(x, y, pch = 19, col = gray(0.7,0.2), bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok)) 
    lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), 
          col = col.smooth, lwd=2, ...)
}
```

```
# custom plot
jplot <- function( x1, x2, lab1="", lab2="", draw.line=T, ... )
{
  
  plot( x1, x2,
        pch=19, 
        col=gray(0.6, alpha = 0.2), 
        cex=0.5,  
        bty = "n",
        xlab=lab1, 
        ylab=lab2, cex.lab=1.5,
        ... )
  
  if( draw.line==T ){ 
    ok <- is.finite(x1) & is.finite(x2)
    lines( lowess(x2[ok]~x1[ok]), col="red", lwd=3 ) }
  
}
```

## Load necessary data

```
# remember to use the here::here() function
d1 <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )
d2 <- readRDS( here::here( "data/rodeo/LTDB-2010.rds" ) )
md <- readRDS( here::here( "data/rodeo/LTDB-META-DATA.rds" ) )

d1 <- dplyr::select( d1, - year )
d2 <- dplyr::select( d2, - year )

d <- merge( d1, d2, by="tractid" )
d <- merge( d, md, by="tractid" )
```

## Clean data

```
# filter rural districts
d <- dplyr::filter( d, urban == "urban" )

# adjust 2000 home values for inflation 
mhv.00 <- d$mhmval00 * INFLATION_RATE 
mhv.10 <- d$mhmval12

# change in MHV in dollars
mhv.change <- mhv.10 - mhv.00


# drop low 2000 median home values
# to avoid unrealistic growth rates.
#
# tracts with homes that cost less than
# $10,000 are outliers
mhv.00[ mhv.00 < 10000 ] <- NA

# change in MHV in percent
mhv.growth <- 100 * ( mhv.change / mhv.00 )

d$mhv.00 <- mhv.00
d$mhv.10 <- mhv.10
d$mhv.change <- mhv.change
d$mhv.growth <- mhv.growth 
```

## Create data sets

```
d.full <- d
```
```
d <- dplyr::select( d, tractid, 
                    mhmval00, mhmval12, 
                    hinc00, 
                    hu00, vac00, own00, rent00, h30old00,
                    empclf00, clf00, unemp00, prof00,  
                    dpov00, npov00,
                    ag25up00, hs00, col00, 
                    pop00.x, nhwht00, nhblk00, hisp00, asian00,
                    cbsa, cbsaname,
                    mhv.00, mhv.10, mhv.change, mhv.growth)


d <- 
  d %>%
  dplyr::mutate( p.white = 100 * nhwht00 / pop00.x,
                 p.black = 100 * nhblk00 / pop00.x,
                 p.hisp = 100 * hisp00 / pop00.x, 
                 p.asian = 100 * asian00 / pop00.x,
                 p.hs = 100 * (hs00+col00) / ag25up00,
                 p.col = 100 * col00 / ag25up00,
                 p.prof = 100 * prof00 / empclf00,
                 p.unemp = 100 * unemp00 / clf00,
                 p.vacant = 100 * vac00 / hu00,
                 mhv.change.00.to.10 = mhmval12 - mhmval00,
                 p.mhv.change = 100 * (mhmval12 - mhmval00) / mhmval00,
                 pov.rate = 100 * npov00 / dpov00 )
```

```
# create mini data frame
df <- data.frame( MedianHomeValue2000=mhv.00, 
                  MedianHomeValue2010=mhv.10, 
                  MHV.Change.00.to.10=mhv.change,
                  MHV.Growth.00.to.12=mhv.growth )
 ```
 
 ```
# average growth in median home value for the city
cbsa_stats_df <- 
  d %>%
  dplyr::group_by( cbsaname ) %>%
  dplyr::summarize( metro.mhv.change = median( mhv.change, na.rm=T ),
                    metro.mhv.growth = 100 * median( mhv.growth, na.rm=T ) ) %>%
  dplyr::ungroup() 
```


# Lab 05 Functions--------------------------------------------------------------

## Load Data

```
# obtain NMTC data
NMTC_URL <- "https://raw.githubusercontent.com/DS4PS/cpp-528-spr-2020/master/labs/data/raw/NMTC/nmtc-sheet-01.csv"
nmtc <- read.csv( NMTC_URL, stringsAsFactors=F )

# obtain LIHTC data
LIHTC_URL <- "https://raw.githubusercontent.com/DS4PS/cpp-528-spr-2020/master/labs/data/raw/LIHTC/LIHTCPUB.csv"
lihtc <- read.csv( LIHTC_URL, stringsAsFactors=F )

# load census data
d.lab05 <- d.full
```

## Create the Difference In Difference dataset

### Create a key that will allow us to obtain federal data for each tract 
```
# remove anything not a number from the string
d.lab05$id2 <- gsub( "[^0-9]", "", d.lab05$tractid )

# fix IDs so they are match
d.lab05$id2 <- as.numeric( d.lab05$id2 )
```

### Aggregate federal programs such that there is one record per tract 

```
lihtc.dollars <-
  lihtc %>% 
  dplyr::filter( yr_alloc >= 2000 & yr_alloc <= 2010 ) %>%
  dplyr::group_by( fips2010 ) %>%
  dplyr::summarize( num.lihtc = dplyr::n(), lihtc.total = sum( allocamt, na.rm=T ) )

# remove dollar sign and commas
nmtc$amount <- gsub( "[,$]", "", nmtc$QLICI.Amount ) %>%
  as.numeric( nmtc$amount ) %>% round(0)

nmtc.dollars <- 
  nmtc %>% 
  dplyr::filter( Origination.Year >= 2000 & Origination.Year <= 2010 ) %>%
  dplyr::group_by( X2010.Census.Tract ) %>% 
  dplyr::summarize( num.nmtc = dplyr::n(), nmtc.total = sum( amount, na.rm=T ) )
```

### Merge federal data onto census tracts
```
d.lab05 <- merge( d.lab05, nmtc.dollars, by.x="id2", by.y="X2010.Census.Tract", all.x=T )
d.lab05 <- merge( d.lab05, lihtc.dollars, by.x="id2", by.y="fips2010", all.x=T )
```

### Recode tracts and manipulate variables

```
# recode tracts that had no grants from NA to 0
d.lab05$num.nmtc[ is.na(d.lab05$num.nmtc) ] <- 0
d.lab05$nmtc.total[ is.na(d.lab05$nmtc.total) ] <- 0

d.lab05$num.lihtc[ is.na(d.lab05$num.lihtc) ] <- 0 
d.lab05$lihtc.total[ is.na(d.lab05$lihtc.total) ] <- 0

# adjust 2000 home values for inflation 
mhv.00 <- d.lab05$mhmval00 * INFLATION_RATE  
mhv.10 <- d.lab05$mhmval12

# change in MHV in dollars
mhv.change <- mhv.10 - mhv.00

# drop low year 2000 median home values
# to avoid unrealistic growth rates.
#
# tracts with homes that cost less than
# $10,000 are outliers
# approximately 200 out of 59,000 cases 
mhv.00[ mhv.00 < 10000 ] <- NA

# change in MHV in percent
mhv.growth <- 100 * ( mhv.change / mhv.00 )


# add variables to the main data frame 
d.lab05$mhv.00 <- mhv.00
d.lab05$mhv.10 <- mhv.10
d.lab05$mhv.change <- mhv.change
d.lab05$mhv.growth <- mhv.growth 

# save copy of full d.lab05
d.lab05.full <- d.lab05
```

### Select a few variables 

```
d.lab05 <- dplyr::select( d.lab05.full, 
                          
                          tractid, cbsa, cbsaname,            # ids / units of analysis
                          
                          mhv.00, mhv.10, mhv.change, mhv.growth,    # home value 
                          
                          hs00, hs12,  col00, col12, ag25up00, ag25up12,                # education
                          
                          unemp00, unemp12, clf00, clf12,            # employment
                          
                          vac00, vac10, hu00, hu10,                     # housing vacancies
                          
                          mhmval12, mhmval00,                   #median home values (for mutate)
                          
                          npov00, npov12, dpov00, dpov12, hinc00, hinc12,        # income/poverty
                          
                          pop00.x, pop10,  nhwht00, nhwht10,  # population/race
                          
                          num.nmtc, nmtc.total,              # tax policy data
                          num.lihtc, lihtc.total             # aggregated by census tract
                          
) # end select
```

### Add control variables

```
d.lab05 <- 
  d.lab05 %>%
  dplyr::mutate( p.hs.00 = 100 * (hs00+col00) / ag25up00,
                 p.hs.12 = 100 * (hs12 + col12) / ag25up12,
                 p.unemp.00 = 100 * unemp00 / clf00,
                 p.unemp.12 = 100 * unemp12 / clf12,
                 p.vacant.00 = 100 * vac00 / hu00,
                 p.vacant.10 = 100 * vac10 / hu10,
                 p.white.00 = 100 * nhwht00 / pop00.x,
                 p.white.10 = 100 * nhwht10 / pop10,
                 mhv.change.00.to.10 = mhmval12 - mhmval00,
                 p.mhv.change = 100 * (mhmval12 - mhmval00) / mhmval00,
                 pov.rate.00 = 100 * npov00 / dpov00,
                 pov.rate.12 = 100 * npov12 / dpov12) %>%
  # remove any NA or Inf values
  na.omit(use = "everything")
```

### Create new variables by cbsa

```
d.lab05 <-
  d.lab05 %>%
  dplyr::group_by( cbsaname ) %>%
  dplyr::mutate( # metro rank of home value in 2000
    metro.mhv.pct.00 = dplyr::ntile( mhv.00, 100 ),
    # metro rank of home value in 2010
    metro.mhv.pct.10 = dplyr::ntile( mhv.10, 100 ),
    # median pay for metro area 2000
    metro.median.pay.00 = median( hinc00, na.rm=T ),
    # median pay for metro area 2010
    metro.median.pay.10 = median( hinc12, na.rm=T ),
    # tract rank in metro area for diversity (% non-white) 2000
    metro.diversity.rank.00 = dplyr::ntile( (100-p.white.00), 100 ),
    # tract rank in metro area for diversity (% non-white) 2010
    metro.diversity.rank.10 = dplyr::ntile( (100-p.white.10), 100 ),
    # metro total population 2000
    metro.pop.total.00 = sum( pop00.x, na.rm=T ),
    # metro total population 2010
    metro.pop.total.10 = sum( pop10, na.rm=T ) ) %>%
  dplyr::ungroup() %>%
  dplyr::mutate( # change in relative rank of mhv in metro area 2000-2010
    metro.mhv.pctile.change = metro.mhv.pct.10 - metro.mhv.pct.00,
    # growth in ave pay in metro
    metro.pay.change = metro.median.pay.10 - metro.median.pay.00,
    # metro population growth 2000-2010
    metro.pop.growth = ( metro.pop.total.10 - metro.pop.total.00 ) / metro.pop.total.00,
    # increase in the proportion of whites in tract 
    increase.p.white = p.white.10 - p.white.00  )

```

### More cleaning

```
# inflation adjust income  
d.lab05$hinc00 <- INFLATION_RATE * d.lab05$hinc00

# Create a true/false code for recipient tracts 
d.lab05$LIHTC <- ifelse( d.lab05$num.lihtc > 0, "YES", "NO" )
d.lab05$NMTC <- ifelse( d.lab05$num.nmtc > 0, "YES", "NO" )

# create a growth column within the data frame 
# omit cases with growth rates above 200%
d.lab05$growth <- d.lab05$mhv.growth
d.lab05$growth[ d.lab05$growth > 200 ] <- NA
```

### Store plots in a list for easy access 

```
PLOTS <-
  list(
    "pov_rate_2000" = list(
      "nmtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=pov.rate.00, fill=NMTC )) +
        ggplot2::geom_density(alpha=0.4) + 
        ggplot2::ggtitle("2000 Poverty Rate Comparison of \nRecipient and Non-Recipient Communities"),
      "lihtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=pov.rate.00, fill=LIHTC)) +
        ggplot2::geom_density(alpha=0.4) +
        ggplot2::ggtitle("2000 Poverty Rate Comparison of \nRecipient and Non-Recipient Communities")
    ),
    "mhv_2000" = list(
      "nmtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=log10(mhv.00), fill=NMTC )) +
        ggplot2::geom_density( alpha=0.4 ) +
        ggplot2::ggtitle("2000 Median Home Value Comparison of \nRecipient and Non-Recipient Communities"),
      "lihtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=log10(mhv.00), fill=LIHTC )) +
        ggplot2::geom_density( alpha=0.4 )  +
        ggplot2::ggtitle("2000 Median Home Value Comparison of \nRecipient and Non-Recipient Communities")
    ),
    "mhv_growth" = list(
      "nmtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=growth, fill=NMTC )) +
        ggplot2::geom_density( alpha=0.4 )  +
        ggplot2::ggtitle("Comparision of MHV Growth 2000 to 2010: \nRecipients vs Non-Recipients"),
      "lihtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=growth, fill=LIHTC )) +
        ggplot2::geom_density( alpha=0.4 )  +
        ggplot2::ggtitle("Comparision of MHV Growth 2000 to 2010: \nRecipients vs Non-Recipients")
    )
  )
```

## Prepare NMTC data

The transformations to create data set d3 are needed to run a difference-in-difference regression model. 

```
# log the variables
y1 <- log( d.lab05$mhv.00 )
y2 <- log( d.lab05$mhv.10 )
lp.vac.00 <- log10( d.lab05$p.vacant.00 + 1)
lp.vac.10 <- log10( d.lab05$p.vacant.10 + 1)
lp.hs.00 <- log10( d.lab05$p.hs.00 + 1)
lp.hs.12 <- log10( d.lab05$p.hs.12 + 1)
lp.unemp.00 <- log10( d.lab05$p.unemp.00 + 1)
lp.unemp.12 <- log10( d.lab05$p.unemp.12 + 1)

# create a variable that identifies if a tract received NMTC funding
nmtc.treat <- as.numeric( d.lab05$num.nmtc > 0 )

# store the year 2000 data
d1 <- data.frame( y=y1, treat=nmtc.treat, post=0 )
# store the year 2010 data
d2 <- data.frame( y=y2, treat=nmtc.treat, post=1 )

# stack the two time periods together
d3 <- rbind( d1, d2 )
```

### Controls 

```
#p.vac
d0 <- data.frame( lp.vac.00 = lp.vac.00, lp.vac.10 = lp.vac.10)

d0 <- d0 %>% tidyr::gather(key = "variable_name",
                           value = "p.vac")

# diff-in-diff data
d3$p.vac <- d0$p.vac


#p.hs
d0 <- data.frame( lp.hs.00 = lp.hs.00, lp.hs.12 = lp.hs.12)
d0 <- d0 %>% tidyr::gather(key = "variable-name", value = "p.hs")

# diff-in-diff data
d3$p.hs <- d0$p.hs


#p.unemp
d0 <- data.frame( lp.unemp.00 = lp.unemp.00, lp.unemp.12 = lp.unemp.12)
d0 <- d0 %>% tidyr::gather(key = "variable-name", value = "p.unemp")

# diff-in-diff data
d3$p.unemp <- d0$p.unemp
```

## Prepare LIHTC data

The transformations to create data set 13 are needed to run a difference-in-difference regression model. 

```
# create a variable that identifies if a tract received LIHTC funding
lihtc.treat <- as.numeric( d.lab05$num.lihtc > 0 )

# store the year 2000 data
l1 <- data.frame( y=y1, treat=lihtc.treat, post=0 )
# store the year 2010 data
l2 <- data.frame( y=y2, treat=lihtc.treat, post=1 )

# stack the two time periods together
l3 <- rbind( l1, l2 )

```

### Controls 

```
#p.vac
l0 <- data.frame( lp.vac.00 = lp.vac.00, lp.vac.10 = lp.vac.10)

l0 <- l0 %>% tidyr::gather(key = "variable_name",
                           value = "p.vac")

# diff-in-diff data
l3$p.vac <- l0$p.vac


#p.hs
l0 <- data.frame( lp.hs.00 = lp.hs.00, lp.hs.12 = lp.hs.12)

l0 <- l0 %>% tidyr::gather(key = "variable_name",
                           value = "p.hs")

# diff-in-diff data
l3$p.hs <- l0$p.hs


#p.unemp
l0 <- data.frame( lp.unemp.00 = lp.unemp.00, lp.unemp.12 = lp.unemp.12)

l0 <- l0 %>% tidyr::gather(key = "variable_name",
                           value = "p.unemp")

# diff-in-diff data
l3$p.unemp <- l0$p.unemp
```
