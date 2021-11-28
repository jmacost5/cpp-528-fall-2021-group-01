Anything that documents the data collection process lives here,will focus on refining the documentation and implementing some helper functions that will allow us to query the Longitudinal Tracts Data Base (LTDB) to get the variables we need for our study, as well as expediting the process of making sense of the data.

The LTDB is an excellent resource for community over-time analysis since it has harmonized 40 years of census data by apportioning old data to suit the new 2010 census tracts, allowing for the examination of consistent geographic units throughout time (if we are changing your tract boundaries and adding more tracts but not changing older data our analysis will be completely meaningless).To address this, we'll rearrange our input census datasets such that we may fully use the data's over-time features.

We'll also create a machine-readable data dictionary so we can quickly retrieve the variables we need with the help of some custom functions you'll develop.

Using 2010 census tracts, the variables are assessed at the census tract level. The meta-data characterizing tracts is scarce and inconsistent, despite the fact that the tracts are consistent throughout all of the data.

The structuring of data by census form is helpful for census workers who are creating datasets, but it is inconvenient for anybody trying to use the information. When looking for variables, it encourages the user to look at many more datasets than is necessary. It also forces the user to perform more mergers.

We created a new data dictionary to address these concerns. It allows us to search for variables by subject and availability during our research period, as well as access the data dictionary in real time while performing analysis.

Start creating a guide to use of the data in this project , will have the following folders :

- Raw Folder : All of the raw data files will go in the raw folder , contain scripts used to download data from APIs or scripts that scrape data from websites

- Wrangling : This folder documents the process of converting raw data into the “rodeo” dataset you use for your models and descriptive statistics

- Rodeo : This folder contains datasets that have been cleaned and processed, and are ready for analysis.
Data Preparation

As we all know, bad input inevitably leads to bad output. Therefore no matter what you do in modeling — if you made major mistakes while preparing the data — you will end up returning to this stage and doing it over again.

- Select Data :The rationale for Inclusion/Exclusion

- Clean Data :Data Cleaning Report

- Construct Data :Derived Attributes

- Generated Records :Integrate Data

- Merged Data : Format Data

- Reformatted Data :Dataset Description


