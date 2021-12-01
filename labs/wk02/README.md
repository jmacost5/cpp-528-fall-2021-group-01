## Overview 
This lab demonstrates a very minor redesign of the Longitudinal Tracts Database files to make the rest of the project smoother.
Variable names are standardized, files combined, meta-data on tracts made accessible, and a harmonization file is created to make it much faster and easier to use variables within the ten datasets.
You will follow the steps that were deployed to accomplish this, build a new data dictionary that has a more intuitive structure, and create a couple of functions to operationalize a more intuitive work flow with the data.

**Data**

You will find the Census Longitudinal Tabulated Database (LTDB) file here:

This Lab will need these Sample datasets [Harmonized Census Data Part-01](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB_Std_All_Sample.zip)

This Lab will need these Full datasets [Harmonized Census Data Part-02](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB_Std_All_fullcount.zip)


[Codebook](https://watts-college.github.io/cpp-528-fall-2021/data/LTDB-codebook.pdf) for Longitudinal Tract Data Base Census Data for 1970-2010 and ACS 2008-2012 

This Codebook will help you to create new concordance version of the data dictionary will be created by reading in all of the current datasets, 
compiling all of the current variable names, organizing them by source, copying some definitions from the current PDF of the LTDB dictionary, 
and saving the table as a new CSV file.

Most of the variables you need will come from the first dataset, which is comprised of variables that come from the long-form version of the census (which is only administered to a sample of the population) or variables from the American Community Survey (the annual survey given to a subsample of citizens).
The second dataset contains only variables that come from the Decennial Census short form, and thus they are population measures and not sample estimates.

**Data Preparation Process**

Although it can be tedious at times, data wrangling is one of the most important stages of the project because (1) it will be where you spend 80% of your time on most projects, and (2) it is the easiest place to introduce errors that are hard to find and can have a big effect on your final results.

Following steps needed :

**Data Understanding**

1- Collect Initial Data (Initial Data Collection Report)

2- Describe Data (Data Description Report)

3- Explore Data (Data Exploration Report)

4- Verify Data Quality (Data Quality Report)

**Data Data Preparation**

1- Select Data(The rationale for Inclusion/Exclusion)

2- Clean Data(Data Cleaning Report)

3- Construct Data(Derived Attributes ,Generated Records)

4- Integrate Data(Merged Data)

5- Format Data (Reformatted Data)

6- Dataset Description

### The End Goal

The end goal of data wrangling is for the data to be clean and easy to use during the analytical stage of the project. For this lab you will add meaningful metadata about the LTDB dataset to a machine-readable concordance file that will be used to greatly improve the usability of the data.

Data wrangling includes all of the steps in building, restructuring, and fixing the data through cleaning or reformatting. These processes should all occur during the data engineering steps. Feature engineering, the process of creating new measures by applying algorithms or mathematical models to existing data, often using advanced tools like geo-spatial algorithms or machine-learning models,is another kind of data engineering step.

Variable transformations, however, are an important component of the modeling process that often require interative processes of testing multiple specifications for model fit and to identify issues related to outliers, etc. As such, variable transformations are typically a part of the analysis dataset. So there is not a pure distinction between the two. Use your judgement about where to draw the line to keep the process well-organized and file delineation clear.

### Lab Steps

**Part 1: Data Concordance**

Download the data concordance spreadsheet that was created from the steps described above and store it within the **data/rodeo** directory. You will see that it has all of the information about variable changes over time, but it has incomplete meta-data that describes the variables.

Using the LTDB Codebook copy and paste the Census definitions of each field into the “description” column of the data within the data concordance spreadsheet.

Using the category column in the file, create meaningful groups for the variables by assigning a group label to each. The LTDB codebook includes some, such as “Variable Group 1: Race and Age by Race” on page 5. Use these as a guide, but feel free to create your own taxonomy that helps you make sense of the variables.

When you are done save the Excel file as a CSV file with in this location: **"data/rodeo/ltdb_data_dictionary.csv**

If you are unsure what the data/rodeo directory is, [please go back to the data directory structure](https://watts-college.github.io/cpp-528-fall-2021/labs/lab-02-instructions.html#data-directory-structure)

We now have a machine-readable data dictionary. This allows us to create some tools that make the full database easier to use.

**Part 2: Build a Variable Filter**

**Separate data processing steps within a separate file**

Create a couple of filters for your data dictionary that make the meta-data easier to access and easier to use. These functions will live in a separate file called utilties.R.

Import objects within that .R file into your .rmd file
You will then import your functions within that file into a .rmd file, where you will hide how you created these functions and merely show the user what they do. In your .rmd file, you need to use the source() function to import your functions within the utilties.R file.

**We will create the following custom functions:**

**ONE:** Filter variables by theme or group. function that takes as 

- Input: an argument one or more of the groups that you just created in the concordance file under the “category” field

- Output: The function should return all of the rows of the dataframe that belong to the group.

**TWO:** Function that searches variable descriptions for a specific string

- Input: variable descriptions for a specific string 

- Output: returns any variables that match. For example 

if I searched for “income” I would want variables like median household income and per capita income.

**THREE:** Function to filter variables by time periods.

- Input: User will specify the time periods of interest for the study and the 

- Output Function will identify all variables that have measures for those periods. 

For example, I if I want to use the data for a study that covers 1990, 2000, and 2010 which variables are available for all three periods

#### Loading funtions from source files

source(here::here("analysis/utilities.R"))

For More info about [here package](https://here.r-lib.org)



## References 

- Bryan , Jenny . "Naming things" , Reproducible Science Workshop, 2014.Web. 2 November 2021. [PDF file]. Available from "https://www2.stat.duke.edu/~rcs46/lectures_2015/01-markdown-git/slides/naming-slides/naming-slides.pdf"

- Quantum , "Data Science project management methodologies" , Aug 20, 2019 , Web. 3 November 2021 , Available from "https://medium.datadriveninvestor.com/data-science-project-management-methodologies-f6913c6b29eb"

-  IBM Corporation ,"IBM SPSS Modeler CRISP-DM Guide" 1994, 2011 , Web. 3 November 2021. [PDF file]. Available from "https://inseaddataanalytics.github.io/INSEADAnalytics/CRISP_DM.pdf"

-  R-bloggers , "CRISP-DM and why you should know about it" 2017 , Web. 4 November 2021 , Available from "https://www.r-bloggers.com/2017/01/crisp-dm-and-why-you-should-know-about-it/"

- Kappal , Sunil "Useful R Packages that Aligns with The CRISP DM Methodology" February 6, 2017 ,  Web. 4 November 2021 , Available from "https://www.datasciencecentral.com/profiles/blogs/userful-r-packages-that-aligns-with-the-crisp-dm-methodology"


