---
title: Data Management - Metrics of Neighborhood Change
subtitle: "Building a neighborhood change database."
---
``` r
# Install necessary packages
install.packages("here")
```

### Running Needed Packages

``` r
# load necessary packages
library( tidyverse )
library( here )
library( pander )
```

### Part 1: Data Concordance

``` r
# Reading data files from specific file paths in my desktop


# store data dictionary file path
DD_FILEPATH <- here::here("data/raw/Ahmeds-ltdb_data_dictionary.csv")

# import data dictionary
dd <- read.csv(DD_FILEPATH , header=T,fill=T , stringsAsFactors=F)
head(dd) %>% pander()
```

|  root  | root2  |    category     |                             definition                              | X1970.f  |
| :----: | :----: | :-------------: | :-----------------------------------------------------------------: | :------: |
| state  | state  |       id        |                                state                                |  state   |
| county | county |       id        |                               county                                |  county  |
| tract  | tract  |       id        |               an area of land, typically a large one.               |  tract   |
| trtid  | trtid  |       id        | county are identified by a 4-digit basic code between 0001 and 9999 | TRTID10  |
|  cbsa  |  cbsa  | tract attribute |     both metropolitan statistical areas and micropolitan areas      |  cbsa10  |
| ccflag | ccflag | tract attribute |                                                                     | ccflag10 |

Table continues below

| X1970.s  | X1980.f  | X1980.s  | X1990.f  | X1990.s  | X2000.f  | X2000.s  |
| :------: | :------: | :------: | :------: | :------: | :------: | :------: |
|  state   |  state   |  state   |  state   |  state   |  state   |  state   |
|  county  |  county  |  county  |  county  |  county  |  county  |  county  |
|  tract   |  tract   |  tract   |  tract   |  tract   |  tract   |  tract   |
| TRTID10  | TRTID10  | trtid10  | TRTID10  | TRTID10  | TRTID10  | TRTID10  |
|  cbsa10  |  cbsa10  |  cbsa10  |  cbsa10  |  cbsa10  |  cbsa10  |  cbsa10  |
| ccflag10 | ccflag10 | ccflag10 | ccflag10 | ccflag10 | ccflag10 | ccflag10 |

Table continues below

| X2010.f | X2010.s |
| :-----: | :-----: |
|  state  | statea  |
| county  | countya |
|  tract  | tracta  |
| tractid | tractid |

``` r
# rename columns to lower case in both data frames 


dd <- as.data.frame( sapply( dd, tolower) )

ltdb.data <- as.data.frame( sapply( dd, tolower) )

# view a subset of columns 
dd[ c(1:5,15:17), ] %>% pander()
```

|        |  root  | root2  |    category     |                             definition                              |
| :----: | :----: | :----: | :-------------: | :-----------------------------------------------------------------: |
| **1**  | state  | state  |       id        |                                state                                |
| **2**  | county | county |       id        |                               county                                |
| **3**  | tract  | tract  |       id        |               an area of land, typically a large one.               |
| **4**  | trtid  | trtid  |       id        | county are identified by a 4-digit basic code between 0001 and 9999 |
| **5**  |  cbsa  |  cbsa  | tract attribute |     both metropolitan statistical areas and micropolitan areas      |
| **15** | a15asn | a15asn |    age-race     |           0-15 years old of asians and pacific islanders            |
| **16** | a15blk | a15blk |    age-race     |             percentage of 0-15 years old of black race              |
| **17** | a15hsp | a15hsp |    age-race     |             0-15 years old, persons of hispanic origins             |

Table continues below

|        | X1970.f  | X1970.s | X1980.f | X1980.s  | X1990.f  | X1990.s |
| :----: | :------: | :-----: | :-----: | :------: | :------: | :-----: |
| **1**  |  state   |  state  |  state  |  state   |  state   |  state  |
| **2**  |  county  | county  | county  |  county  |  county  | county  |
| **3**  |  tract   |  tract  |  tract  |  tract   |  tract   |  tract  |
| **4**  | trtid10  | trtid10 | trtid10 | trtid10  | trtid10  | trtid10 |
| **5**  |  cbsa10  | cbsa10  | cbsa10  |  cbsa10  |  cbsa10  | cbsa10  |
| **15** |          |         |         | a15asn80 | a15asn90 |         |
| **16** | a15blk70 |         |         | a15blk80 | a15blk90 |         |
| **17** |          |         |         | a15hsp80 | a15hsp90 |         |

Table continues below

|        | X2000.f  | X2000.s | X2010.f  | X2010.s  |
| :----: | :------: | :-----: | :------: | :------: |
| **1**  |  state   |  state  |  state   |  statea  |
| **2**  |  county  | county  |  county  | countya  |
| **3**  |  tract   |  tract  |  tract   |  tracta  |
| **4**  | trtid10  | trtid10 | tractid  | tractid  |
| **5**  |  cbsa10  | cbsa10  |          |          |
| **15** | a15asn00 |         | a15asn10 | a15asn12 |
| **16** | a15blk00 |         | a15blk10 | a15blk12 |
| **17** | a15hsp00 |         | a15hsp10 | a15hsp12 |

### Part 2: Build a Variable Filter

### Loading functions from utilities\_master.R file

``` r
# Loading functions from source files

import::here("today",
             "cat_filter",
             "search_description",
             "search_years",
             # notice the use of here::here() that points to the .R file
             # where all these R objects are created
             .from = here::here("analysis/utilities_master.R"),
             .character_only = TRUE)
```

    ## Getting data from the 2015-2019 5-year ACS

    ## Downloading feature geometry from the Census website.  To cache shapefiles for use in future sessions, set `options(tigris_use_cache = TRUE)`.

### Run functions

``` r
# Run the date function

today()
```

    ## [1] "December 02, 2021"

#### cat_filter () function that takes as an argument one or more of the groups that we just created in the concordance file under the “category” field and returns all of the variables associated with that group.

``` r
# will need to load (tidyverse) library 

# search.cat will work in combination of multiple search terms 

# search.cat <- c("first search term" ,"second search term" , "third search term" )

# example = search.cat <- c("family" , "nationality")

cat_filter(dd,c("age", "race")) %>% head(10) %>% pander 
```

|  root  | root2  | category |                       definition                       | X1970.f  |
| :----: | :----: | :------: | :----------------------------------------------------: | :------: |
| a60up  | a60up  |   age    |             persons age 60 years and over              | a60up70  |
| ag15up | ag15up |   age    |              population 15 years and over              | ag15up70 |
| ag18cv | ag18cv |   age    |         civilian population 18 years and over          |          |
| ag5up  | ag5up  |   age    |                persons 5 years and over                |          |
| black  | black  |   race   |                 persons of black race                  | black70  |
| cni16u | cni16u |   age    | civilian non-institutionalized persons 16-64 years old |          |
| dflabf | dflabf |   age    |   females 16 years and over, except in armed forces    |          |
|  hisp  |  hisp  |   race   |               persons of hispanic origin               |          |
| india  | india  |   race   |              persons of asian indian race              | india70  |
|  irfb  |  irfb  |   race   |            persons who were born in ireland            |          |

Table continues below

| X1970.s  | X1980.f  | X1980.s  | X1990.f  | X1990.s  | X2000.f | X2000.s  |
| :------: | :------: | :------: | :------: | :------: | :-----: | :------: |
|          | a60up80  |          | a60up90  |          | a60up00 |          |
|          | ag15up80 |          | ag15up90 |          |         | ag15up00 |
|          |          |          |          |          |         | ag18cv00 |
|          |          | ag5up80  |          | ag5up90  |         | ag5up00  |
| cni16u70 |          | cni16u80 |          | cni16u90 |         | cni16u00 |
| dflabf70 |          | dflabf80 |          | dflabf90 |         | dflabf00 |
|          |  hisp80  |          |  hisp90  |          | hisp00  |          |
|          | india80  |          | india90  |          | india00 |          |
|  irfb70  |          |  irfb80  |          |  irfb90  |         |  irfb00  |

Table continues below

| X2010.f | X2010.s  |
| :-----: | :------: |
| a60up10 | a60up12  |
|         | ag15up12 |
|         | ag18cv12 |
|         | ag5up12  |
|         | dflabf12 |
| hisp10  |  hisp12  |
| india10 | india12  |
|         |  irfb12  |


#### search_description () function that searches variable descriptions for a specific string and returns any variables that match. For example, if I searched for “income” I would want variables like median household income and per capita income.

``` r

# For example, if I searched for "income" I would want variables like median household income and per capita income.

search_description(dd , "*income*") %>% head() %>% pander
```

|        | root  |       category       |         definition          |
| :----: | :---: | :------------------: | :-------------------------: |
| **77** | hinc  | socioeconomic status |   median hh income, total   |
| **78** | hinca | socioeconomic status | median hh income, asian/pi  |
| **79** | hincb | socioeconomic status |  median hh income, blacks   |
| **80** | hinch | socioeconomic status | median hh income, hispanics |
| **81** | hincw | socioeconomic status |  median hh income, whites   |
| **89** | incpc | socioeconomic status |      per capita income      |


#### search_years() function to filter variables by time periods. Specifically, the user will specify the time periods of interest for the study and the function will identify all variables that have measures for those periods. For example, I if I want to use the data for a study that covers 1990, 2000, and 2010 which variables are available for all three periods.

``` r

# The user will specify the time periods of interest for the study .

# Function will identify all variables that have measures for those periods .

search_years(dd, year = c("1990", "2000", "2010")) %>% head(20) %>% pander
```

|  root  | year | variable | category |                             definition                              |
| :----: | :--: | :------: | :------: | :-----------------------------------------------------------------: |
| state  | 1990 |  state   |    id    |                                state                                |
| state  | 2000 |  state   |    id    |                                state                                |
| state  | 2010 |  state   |    id    |                                state                                |
| state  | 2010 |  statea  |    id    |                                state                                |
| county | 1990 |  county  |    id    |                               county                                |
| county | 2000 |  county  |    id    |                               county                                |
| county | 2010 |  county  |    id    |                               county                                |
| county | 2010 | countya  |    id    |                               county                                |
| tract  | 1990 |  tract   |    id    |               an area of land, typically a large one.               |
| tract  | 2000 |  tract   |    id    |               an area of land, typically a large one.               |
| tract  | 2010 |  tract   |    id    |               an area of land, typically a large one.               |
| tract  | 2010 |  tracta  |    id    |               an area of land, typically a large one.               |
| trtid  | 1990 | trtid10  |    id    | county are identified by a 4-digit basic code between 0001 and 9999 |
| trtid  | 2000 | trtid10  |    id    | county are identified by a 4-digit basic code between 0001 and 9999 |
| trtid  | 2010 | tractid  |    id    | county are identified by a 4-digit basic code between 0001 and 9999 |
| a15asn | 1990 | a15asn90 | age-race |           0-15 years old of asians and pacific islanders            |
| a15asn | 2000 | a15asn00 | age-race |           0-15 years old of asians and pacific islanders            |
| a15asn | 2010 | a15asn10 | age-race |           0-15 years old of asians and pacific islanders            |
| a15asn | 2010 | a15asn12 | age-race |           0-15 years old of asians and pacific islanders            |
| a15blk | 1990 | a15blk90 | age-race |             percentage of 0-15 years old of black race              |


## References 

- Bryan , Jenny . "Naming things" , Reproducible Science Workshop, 2014.Web. 2 November 2021. [PDF file]. Available from "https://www2.stat.duke.edu/~rcs46/lectures_2015/01-markdown-git/slides/naming-slides/naming-slides.pdf"

- Kappal , Sunil "Useful R Packages that Aligns with The CRISP DM Methodology" February 6, 2017 ,  Web. 4 November 2021 , Available from "https://www.datasciencecentral.com/profiles/blogs/userful-r-packages-that-aligns-with-the-crisp-dm-methodology"

-  IBM Corporation ,"IBM SPSS Modeler CRISP-DM Guide" 1994, 2011 , Web. 3 November 2021. [PDF file]. Available from "https://inseaddataanalytics.github.io/INSEADAnalytics/CRISP_DM.pdf"

- Quantum , "Data Science project management methodologies" , Aug 20, 2019 , Web. 3 November 2021 , Available from "https://medium.datadriveninvestor.com/data-science-project-management-methodologies-f6913c6b29eb"

-  R-bloggers , "CRISP-DM and why you should know about it" 2017 , Web. 4 November 2021 , Available from "https://www.r-bloggers.com/2017/01/crisp-dm-and-why-you-should-know-about-it/"

