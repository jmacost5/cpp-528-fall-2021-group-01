---
title: "Lab02-AhmedRashwan"
output:
  html_document:
    theme: readable
    highlight: zenburn
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r, eval=FALSE}

# Install necessary packages
install.packages("here")

```
### Runing Needed Packages 
```{r , warning=FALSE}

# load necessary packages
library( tidyverse )
library( here )
library( pander )


```

### Part 1: Data Concordance
```{r , , warning=FALSE}
# Reading data files from specific file paths in my desktop


# store data dictionary file path
DD_FILEPATH <- here::here("data/rodeo/Ahmeds-ltdb_data_dictionary.csv")

# import data dictionary
dd <- read.csv(DD_FILEPATH , header=T,fill=T , stringsAsFactors=F)
head(dd) %>% pander()

```

```{r , , warning=FALSE}

# rename columns to lower case in both data frames 


dd <- as.data.frame( sapply( dd, tolower) )

ltdb.data <- as.data.frame( sapply( dd, tolower) )

# view a subset of columns 
dd[ c(1:5,15:17), ] %>% pander()

```
### Part 2: Build a Variable Filter


### Loading funtions from utilities.R file

```{r , warning=FALSE}

# Loading funtions from source files

source(here::here("analysis/utilities.R"))

```

### Running functions 

```{r , warning=FALSE}
# Run the date function

today()

cat_filter(dd,c("age", "race")) %>% head(10) %>% pander 

search_description(dd , "*income*") %>% head() %>% pander

search_years(dd, year = c("1990", "2000", "2010")) %>% head(20) %>% pander

```
