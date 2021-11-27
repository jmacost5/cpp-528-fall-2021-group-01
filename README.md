# CPP 528 Template

Template GitHub repo for CPP 528.

## Overview Of Project for Change in the Neighborhood

To conduct a thorough evaluation of the program's effectiveness. We'll look at whether two huge government initiatives aimed at revitalizing blighted areas in American cities have been effective.

We'll gather the data needed for the research, run various models, and write a final report outlining our findings on the impact of two programs, We'll look at general patterns in neighborhood transformation from 2000 to 2010, then see if the communities targeted by the programs have had any greater success than they would have had without the billions in government subsidies.

**Low-Income Housing Tax Credits (Program 1)**

Low-income housing tax credits (LIHTC) are one of the most common policy tools used in the United States to encourage the building of new affordable housing units. Learn more about the LIHTC:

**Tax Credits for New Markets (Program 2)**

New Market Tax Credits (NMTC) are a type of tax credit aimed to spur economic development in underserved areas by encouraging private-sector investment.

**This Project will help to Answer this Research Question:  Has each government program been successful in assisting troubled towns with economic development?**

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


