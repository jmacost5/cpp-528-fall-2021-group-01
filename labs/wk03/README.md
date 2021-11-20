## Overview 

This course will use the Longitudinal Tracts Data Base (LTDB) for over-time analysis with census data, as stated in the Week 02 lab instructions.
Because the researchers harmonized 40 years of census data by apportioning old data so that it fits the new 2010 census tracts and allows for analysis of consistent
geographic units over time, this is a great resource for communities. However, the data is not ready to use right away, so we must clean it first. 
The problem is that we need to rearrange the input census datasets in order to effectively leverage the data's over-time characteristics.

**Current Issues With LTDB Data**

***The database currently has the following issues:***

- Inconsistent variable names that make merges and over-time calculations hard.

- Capitalization is used inconsistently throughout.

- There is no concordance file that shows which variables are available over time.

- Datasets lack sufficient meta-data describing census tracts needed for most analysis.

- Datasets are organized by census tables instead of by time periods, making it hard to join them.

- The format of unique IDs needed to merge data changes.

- The 2010 data is inconsistently labeled as either 2010 or 2012, depending on the source.


**Solutions**

***The data is currently organized into 10 tables:***

- 1970 variables from the census long form (sample)

- 1970 variables from the full census (full)

- 1980 variables from the census long form (sample)

- 1980 variables from the full census (full)

- 1990 variables from the census long form (sample)

- 1990 variables from the full census (full)

- 2000 variables from the census long form (sample)

- 2000 variables from the full census (full)

- 2010 variables from the American Community Survey (sample)

- 2010 variables from the full census (full)


**For this part of the project we will be:**

1- Using the 2000 to 2010 template, calculate change in the MHV variable between 1990 and 2000.

2- Picking a city and create a new dorling cartogram to visualize our data.

3- Preparing descriptive statistics and chloropleth maps describing the MHV change variable.

**This phase emphasizes the important work of**:

- Creating new variables through variable transformations

- Exploratory and descriptive analysis

- Building basic models

- Preliminary hypothesis-testing

### Data Steps

**Part 1** 

**Cleaning the LTDB** 

### Using [Data Steps Tutorial](https://watts-college.github.io/cpp-528-fall-2021/labs/PROJECT-DATA-STEPS.html)

Select all the lines within the wk03/project_data_steps.R and run them all to produce all of the clean data files within data/rodeo 

#### import the clean file using below code

d <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )
head( d ) %>% pander()

#### Loading funtions from source files

source(here::here("analysis/Ahmeds.utilities.Rj"))

#### Part 1 -  Descriptive analysis demonstrated in the tutorial but do it for periods 1990 to 2000 instead of the 2000 to 2010 

### Data

**note: please do not use static file paths**

**note: notice down below the use of here::here()**

**d1 <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )**

**d2 <- readRDS( here::here( "data/rodeo/LTDB-2010.rds" ) )**

**md <- readRDS( here::here( "data/rodeo/LTDB-META-DATA.rds" ) )**




