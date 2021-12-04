# CPP 528 Group 1 Project

This repository was created by Group 1 for the 2021 CPP 528 Project Management class.

## Contributing Authors and Contact Information:

Alev Yildiz: https://github.com/ayildiz84

Erin McIntyre: https://github.com/ekmcintyre

Ahmed Rashwan: https://github.com/AhmedRashwanASU

April Peck: https://github.com/AprilPeck

## Overview Of Project for Change in the Neighborhood

This project uses census data to analyze program effectiveness. A thorough evaluation of program effectiveness is conducted by analyzing the impact of two U.S. tax credit programs.

The majority of this project is devoted explaining our approach to the audience and guiding them through the results generation process. This project is more similar a code-through than a final report since the style of the chapters are instructive. All chapters can be found in the [Table of Contents](https://r-class.github.io/cpp-528-fall-2021-group-01/) on the project website. These chapters serve the purpose of making the technique as visible as possible, as well as to make it simple for others to replicate and extend the work.

Steps for this project include gathering the data needed for the research, running various models, and writing a final report outlining our findings on the impact of two programs: NMTC and LIHTC. We'll look at general patterns in neighborhood transformation from 2000 to 2010, then see if the communities targeted by the programs have had any greater success than they would have had without government subsidies.

**Tax Credits for New Markets (Program 1)**

The New Market Tax Credit (NMTC) is a type of tax credit aimed to spur economic development in underserved areas by encouraging private-sector investment. The NMTC Program enables economically distressed communities to leverage private investment capital by providing investors with a federal tax credit. All NMTC investments must meet statutory qualifications for their investors to be able to claim the tax credit.

**Low-Income Housing Tax Credits (Program 2)**

The Low-Income Housing Tax Credit (LIHTC) is the most important resource for creating affordable housing in the United States today. The program provides tax credits to developers based on an application process and goals laid out in the qualified action plan. Developers agree to rent the units at below-market rates.

### Research Question:  

**Has each government program been successful in assisting troubled towns with economic development?**

### Project Chapters

  - Data Management - Metrics of Neighborhood Change
  - Descriptive Analysis of Neighborhood Change
  - Predicting Median Home Value Change
  - Evaluation of Tax Credits
  - Results and Conclusion


### Data Sources:

Data files used in this project were taken from the following resources:

[Harmonized Census Data Part-01](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB_Std_All_Sample.zip)

[Harmonized Census Data Part-02](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB_Std_All_fullcount.zip)

[Codebook](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB-codebook.pdf)

Orginal and manipulated data files are located in the `data` folder.


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

## Data Cleaning Steps: 

- Inspecting Data : Missing value codes were removed to avoid problems.

- Tidy Up Dataframes : Datasets were standardized across all years to ensure they are all clean, have the same structure, and use the same variable names.

- Creating Meta-Data Table : Each file has redundant meta-data in it. Redundant data was eliminated and all meta-data (county and census tract information) was combined into a single file for convenience.

Some data cleaning instructions provided by course instructors can be found here: [Data Steps](https://watts-college.github.io/cpp-528-fall-2021/labs/PROJECT-DATA-STEPS.html) 

All data cleaning steps and functions used for the project are stored in the [Utilities Master File](https://github.com/R-Class/cpp-528-fall-2021-group-01/blob/main/analysis/utilities_master.R).


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

The [about page](about_.md) is a markdown file that relies on a data stored within the YAML header to populate photos, a brief bio, and hyperlinked icons about each team member. 


## Installing Required Pacakges 


This repository contains a `renv.lock` file that stores packages and their dependencies. To install the specific versions of the packages stored in that file, use the renv::restore() function.

```
renv::restore()
```

Alternatively, copy the following code which lists all of the packages necessary for this project.


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


## References 

- Bryan , Jenny . "Naming things" , Reproducible Science Workshop, 2014.Web. 2 November 2021. [PDF file]. Available from "https://www2.stat.duke.edu/~rcs46/lectures_2015/01-markdown-git/slides/naming-slides/naming-slides.pdf"

- Quantum , "Data Science project management methodologies" , Aug 20, 2019 , Web. 3 November 2021 , Available from "https://medium.datadriveninvestor.com/data-science-project-management-methodologies-f6913c6b29eb"

-  IBM Corporation ,"IBM SPSS Modeler CRISP-DM Guide" 1994, 2011 , Web. 3 November 2021. [PDF file]. Available from "https://inseaddataanalytics.github.io/INSEADAnalytics/CRISP_DM.pdf"

-  R-bloggers , "CRISP-DM and why you should know about it" 2017 , Web. 4 November 2021 , Available from "https://www.r-bloggers.com/2017/01/crisp-dm-and-why-you-should-know-about-it/"

- Kappal , Sunil "Useful R Packages that Aligns with The CRISP DM Methodology" February 6, 2017 ,  Web. 4 November 2021 , Available from "https://www.datasciencecentral.com/profiles/blogs/userful-r-packages-that-aligns-with-the-crisp-dm-methodology"

- Watts-College , "Descriptive Analysis" , October 29, 2021 ,  Web. 16 November 2021. Available from "https://watts-college.github.io/cpp-528-fall-2021/labs/lab-03-instructions.html"

- Urban Displacement , "UDP-Gentrification-Methodology" , 2012 , Web. 16 November 2021. [PDF File] Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/gentrification/udp-gentrification-methodology-austin.pdf"

- Urban Displacement , "Urban Displacement Project’s Methodology for San Francisco Bay Area, California, USA" , 2012 , Web. 16 November 2021. [PDF File] Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/gentrification/udp-gentrification-methodology-sf.pdf"

- Mychal Cohen , Kathryn L.S. Pettit , "GUIDE TO MEASURING NEIGHBORHOOD CHANGE TO UNDERSTAND AND PREVENT DISPLACEMENT", APRIL 2019 Web. 23 November 2021. Available from https://watts-college.github.io/cpp-528-fall-2021/articles/gentrification/guide_to_measuring_neighborhood_change_to_understand_and_prevent_displacement.pdf"

- Monson, Matt, Cornell MBA and PRE . "Valuation Using Hedonic Pricing Models" , 2009,.Web. 7 November 2021. [PDF file]. Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/home-value-change/valuation-using-hedonic-pricing.pdf"

- "Hedonic Pricing Method" , 1/1/2015  , Web. 7 November 2021. [PDF file]. Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/home-value-change/hedonic-pricing-method.pdf"

- HUD User Datasets , "LOW-INCOME HOUSING TAX CREDIT (LIHTC)" , 2018 , Web. 15 November 2021. Available from "https://www.huduser.gov/portal/datasets/lihtc.html"

- OFFICE OF POLICY DEVELOPMENT AND RESEARCH (PD&R), "Income limit information for LIHTC projects" , April 1, 2021  , Web. 15 November 2021. Available from "https://www.huduser.gov/portal/datasets/il.html#2021_faq"

- LIHTC database , 1997 , Web. 15 November 2021, Available from "https://github.com/DS4PS/cpp-528-spr-2020/blob/master/labs/data/raw/NMTC/nmtc-sheet-01.csv"

- COMMUNITY DEVELOPMENT FINANCIAL INSTITUTIONS FUND , "New Markets Tax Credit (NMTC)Public Data Release", November 2019 , Web. 16 November 2021. [PDF File] Available from "https://github.com/DS4PS/cpp-528-spr-2020/blob/master/labs/data/raw/NMTC/2019%20NMTC%20Public%20Data%20Release_FY_17-comments%20incorporated_BL%20Edits%20incorporated_Final.pdf"

- Novocradac , "Affordable Housing Resource Center" , 1993 , Web. 16 November 2021, Available from "https://www.novoco.com/resource-centers/affordable-housing-tax-credits/lihtc-basics/about-lihtc"

- GitHub , "GitHub Pages themes" , Web. 21 November 2021. Available from "https://github.com/pages-themes"

- GitHub , "Quickstart for GitHub Pages" , Web. 22 November 2021. Available from "https://docs.github.com/en/pages/quickstart"

- Birnbaum  , David J , "Configuring GitHub Pages" , 2020-01-19 , Web. 22 November 2021, Available from "https://dh.obdurodon.org/jekyll.xhtml"

- GitHub , "Transform your plain text into static websites and blogs", Web. 23 November 2021. Available from "https://jekyllrb.com/"

- Made Mistakes , "Mastering Jekyll" , Sep 10th, 2021 , Web. 24 November 2021, Available from "https://mademistakes.com/mastering-jekyll"

- w3schools , "Sass Introduction" , Web. 24 November 2021, Available from "https://www.w3schools.com/sass/sass_intro.php"

- Watts-College "Building a Neighborhood Change Database" Web. 2 November 2021. Available from "https://watts-college.github.io/cpp-528-fall-2021/sched/week-02/"

- Watts-College , "cleaning the LTDB" . Web. 2 November 2021. Available from "https://watts-college.github.io/cpp-528-fall-2021/labs/PROJECT-DATA-STEPS.html"
