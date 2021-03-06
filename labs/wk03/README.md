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

**For this part of the project we will:**

- Calculate change in the MHV variable between 2000 and 2010.
- Measure gentrification that occurs between 2000 and 2010.
- Pick a city and create a new dorling cartogram to visualize your data.
- Prepare descriptive statistics and chloropleth maps describing the MHV change variable and gentrification.

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

This file requires a census api key. It should run with the one provided in the geojson file, but if you require one, you can obtain one [here](https://api.census.gov/data/key_signup.html).

#### Part 1 -  Descriptive analysis demonstrated in the tutorial but do it for periods 1990 to 2000 instead of the 2000 to 2010 

### Data

**The following chunks depend on the files in the data/rodeo folder that are generated by following the first tutorial [Data Steps Tutorial](https://watts-college.github.io/cpp-528-fall-2021/labs/PROJECT-DATA-STEPS.html)**

**note: please do not use static file paths**
**note: notice down below the use of here::here()**

d1 <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )

d2 <- readRDS( here::here( "data/rodeo/LTDB-2010.rds" ) )

md <- readRDS( here::here( "data/rodeo/LTDB-META-DATA.rds" ) 

**we will follow below steps then :**

1- Filter Rural Districts

2- Identify Common Variables in 2000 and 2010 datasets:

3- Create Dataset for Analysis , Create subset for the analysis (Take sample of the data)

4- Exploration of Median Home Value

5- Build Histogram of MHV , Compare 2000 to 2010 distributions.

6- Build Histogram for the Change in MHV 2000-2010 "The change in value variable only reports absolute change, but does not provide a sense of whether that is a big or small amount for the census tract"

7- Find Group Growth Rates By Metro Area using dplyr makes this easy by grouping then summarizing the data


#### Part 02 - Measuring Gentrification Steps

1- Select Gentrification Variables

2- Descriptive Statistics of Change Variables

3- Operationalizing Gentrification


#### Part 03 - Spatial Visualization


we will pick one city that we can use as examples in your report. we will create a dorling cartogram for reporting since Census tracts introduce visual bias by over-empasizing lower density tracts and hiding a lot of the data where the greatest number of people reside in the city.Dorling cartograms correct for this by re-sizing administrative units proportion to the size of the population they represent.

![download](https://user-images.githubusercontent.com/77247268/143398681-5fe4ac91-05d7-4bef-9103-0df90fcdaeda.png)

The lab from CPP 528 that covers creating Dorling cartograms is located [here](https://ds4ps.org/cpp-529-master/labs/lab-04-instructions.html)

## Files overview
**create_dorling_amp.R**: an R Markdown file to create the dorling cartogram used within the lab03-peck_final.Rmd file.

**lab03-peck_final.Rmd**: An rmd file containing code to accomplish the overview. Functions and datasets used in the code are located in an R file ("analysis/utilities_master.R") which is loaded using the import::here() function.

**lab03-peck_final.html**: a knitted html file of the Rmd file. 

**sf_dorling.geojson**: a geojson file used to retrieve the dorling cartogram.

### Reference

- Watts-College , "Descriptive Analysis" , October 29, 2021 ,  Web. 16 November 2021. Available from "https://watts-college.github.io/cpp-528-fall-2021/labs/lab-03-instructions.html"

- Urban Displacement , "UDP-Gentrification-Methodology" , 2012 , Web. 16 November 2021. [PDF File] Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/gentrification/udp-gentrification-methodology-austin.pdf"

- Urban Displacement , "Urban Displacement Project???s Methodology for San Francisco Bay Area, California, USA" , 2012 , Web. 16 November 2021. [PDF File] Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/gentrification/udp-gentrification-methodology-sf.pdf"

- Mychal Cohen , Kathryn L.S. Pettit , "GUIDE TO MEASURING NEIGHBORHOOD CHANGE TO UNDERSTAND AND PREVENT DISPLACEMENT", APRIL 2019 Web. 23 November 2021. Available from https://watts-college.github.io/cpp-528-fall-2021/articles/gentrification/guide_to_measuring_neighborhood_change_to_understand_and_prevent_displacement.pdf"



