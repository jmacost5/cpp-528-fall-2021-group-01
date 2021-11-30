# CPP 528 Template

Template GitHub repo for CPP 528.

## Overview Of Project for Change in the Neighborhood

We'll conduct a thorough evaluation of the program's effectiveness. We'll look at whether two huge government initiatives aimed at revitalizing blighted areas in American cities have been effective.

The majority of the parts will be devoted to explaining the approach to the audience and guiding them through the results generation process. The style of these chapters will be more instructive or code-through than the final report. The purpose of those parts is to make the technique as visible as feasible, as well as to make it simple for others to replicate and extend the work.

We'll gather the data needed for the research, run various models, and write a final report outlining our findings on the impact of two programs, We'll look at general patterns in neighborhood transformation from 2000 to 2010, then see if the communities targeted by the programs have had any greater success than they would have had without the billions in government subsidies.

**Low-Income Housing Tax Credits (Program 1)**

Low-income housing tax credits (LIHTC) are one of the most common policy tools used in the United States to encourage the building of new affordable housing units.

**Tax Credits for New Markets (Program 2)**

New Market Tax Credits (NMTC) are a type of tax credit aimed to spur economic development in underserved areas by encouraging private-sector investment.

**This Project will help to Answer this Research Question:  Has each government program been successful in assisting troubled towns with economic development?**

**This Project will Present the following chapters :**

- Descriptive analysis of neighborhood change
- Predicting median home value change, 2000 to 2010
- Adding federal program data to your predictive models
- Test reproducible work flow with a parameter change

### Table of Contents

1- Executive Summary :
- Overview / Research Question Program Details
- Data
- Methods
- Results

2 -Part I: Neighborhood Change :
- Data sources
- Median Home Value
- Gentrification

Descriptive Analysis of Neighborhood Change : 
- Average change in MHV from 2000 to 2010

Predicting Change Based on 2000 Neighborhood characteristics : 
- Neighborhood demographics
- Spatial characteristics (population density, adjacent tracts)

3-Part II: Evaluation of Tax Credits :
- Overview of Programs:
- New Market Tax Credits(NMTC)
- Low Income Housing Tax Credit(LIHTC)

Data sources

Descriptive Statistics For :
- Dollars given out
- Characteristics of neighborhoods that received them
- Characteristics of those that did not

Predictive Analysis :
- Aggregate credits given between 2000 and 2010
- Update models by adding tax credit amounts

4- Part III – Results and Conclusion


### Overview Of Project Code

The import::here() function operates similarly to the source() function, with the extra benefit of allowing you to designate particular objects to be made available in the Global Environment , This is recommended practice since the Global Environment will only have the relevant objects, not all of the objects produced in your.R file.
When someone else on your team wants to familiarize themselves with code, it's far easier to provide them a GitHub link to a.R file than than a.rmd file.

**Example of using import specific functions from your R File.**

```
# set randomization seed ----
set.seed( 1234 )
# load necessary functions and objects ----
# note: all of these are R objects that will be used throughout this .rmd file
import::here("S_TYPE",
             "INFLATION_RATE",
             "panel.cor",
             "panel.smooth",
             "jplot",
             "d1",
             "d2",
             "d",
             "df",
             "md",
             "cbsa_stats_df",
             # notice the use of here::here() that points to the .R file
             # where all these R objects are created
             .from = here::here("labs/wk06/Unified_Data_Steps.R"),
             .character_only = TRUE)
```

**Important Data Cleaning Steps we need follow :** 

- Inspecting Data : To Avoid problems with missing data coded will need to make sure to remove missing value codes, which will cause issues with any analysis .

- Tidy Up Dataframes : We'd want to standardize datasets across all years so that they're all clean, have the same structure, and use the same variable names.

- Creating Meta-Data Table : Each file has redundant meta-data in it. We can eliminate it to make merges easier, and we can combine all of the meta-data (county and census tract information) into a single file for convenience.

- You can find more about [Data Steps Requierd](https://watts-college.github.io/cpp-528-fall-2021/labs/PROJECT-DATA-STEPS.html)

#### Reading Data As RDS Format 

```
d1 <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )
d2 <- readRDS( here::here( "data/rodeo/LTDB-2010.rds" ) )
md <- readRDS( here::here( "data/rodeo/LTDB-META-DATA.rds" ) )

```

**RDS files by default are compressed, which means they take up less space on your hard drive and are easier to share. On average they are less than one-third the size of equivalent CSV files**


## Context

The [`index.html`](index.html) file serves a purpose which is to ensure that the `README.md` file does not get displayed back to the user on the home page of the website.

## About page

The [about page](about.md) is a markdown file that relies on a data stored within the YAML header to populate photos, a brief bio, and hyperlinked icons about each team member. 

```yaml
---
title: About
subtitle: The humans behind this project
team:
  - name: Romi and Phoebe
    img: ../assets/img/about/romi_and_phoebe.jpg
    desc: Two excellent rescue hounds who bring much joy to our family.
    url: https://www.aspca.org/adopt-pet/adoptable-dogs-your-local-shelter
    website: https://www.aspca.org/adopt-pet/adoptable-dogs-your-local-shelter
    github: https://github.com/cenuno
    twitter: https://twitter.com/cenuno_
---
```

As your team grows, be sure to update this file accordingly, specifically the `team` sub-section.

## Potential problems

Some Mac user may experience problems building their website using this custom Jekyll theme. The following steps are needed to overcome this problem:

1. Download the Ruby 2.7 version via [homebrew](https://brew.sh/)

```bash
brew install ruby@2.7
```

2. Download the Jekyll bundler which contains the "remote" theme

```bash
sudo gem install jekyll bundler
```

## Installing Requierd Pacakges 

 ```Pacakges
# Data wrangling 
install.packages(tidyverse)        # Package assists with data wrangling
install.packages(here)             # Package allows for relative file path references in code , enable easy file referencing in project-oriented workflows
install.packages( httr)            # Provides a wrapper for the curl package
install.packages(jsonlite)         # Simple and Robust JSON Parser and Generator for R
install.packages( geojsonio )      # read shapefiles
install.packages( sp )             # work with shapefiles
install.packages( sf )             # work with shapefiles - simple features format
install.packages( tmap )           # theme maps                   
install.packages( dplyr )          # data wrangling
install.packages( pander )         # nice tables 
install.packages( mclust )         # cluster analysis 
install.packagesy( ggplot2 )       # graphing 
install.packages( ggthemes )       # nice formats for ggplots


# Tables
install.packages( DT )             # provides an R interface to the JavaScript library DataTables
install.packages( knitr )          # Provides a general-purpose tool for dynamic report generation
install.packages( stargazer )      # create a summary statistics table
install.packages( scales )         # inverse of scaling, making guides (legends and axes) 
install.packages(formattable)      # creating nice tables 


# Maps
install.packages( ggmap )         # to retrieve raster map tiles from popular online mapping services
install.packages( leaflet )       # open-source JavaScript libraries for interactive maps
install.packages( viridis )       # viridisLite provides the base functions for generating the color maps
install.packages( tidycensus)     # help R users get Census data that is pre-prepared for exploration
install.packages( pals )          # Memory use is reduced by compressing colormaps to fewer colors
install.packages( cartogram )     # spatial maps w/ tract size bias reduction
install.packages( tidyverse)      # tidyverse makes data science faster, easier and more fun with
install.packages( gtools)         # developing, updating, and maintaining R and R packages
install.packages( maptools )      # spatial object manipulation 
```


