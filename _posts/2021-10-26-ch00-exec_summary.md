---
title: Executive Summary
subtitle: Summarizing Group 1's Project Management Deliverables
---

### **Overview / Research Question Program Details**  
  
The following analysis aims to explain the dynamics of neighborhood changes in US metro areas between 1990 and 2010; then examine whether neighborhoods targeted by the           programs have achieved any more success than they would have without the billion of dollars in federal subsidies. For the project, the team has been hired by the federal         government to provide a rigorous assessment of program impact. We will assess whether two large federal programs designed to revitalize distressed neighborhoods in US cities     have been successful. Low Income Housing Tax Credits (LIHTC) are one of the primary policy instruments used to incentivize the construction of new affordable housing units in   the United States. New Market Tax Credits (NMTC) are mechanisms designed to catalyze economic development in distressed communities by attrating investments from private         developers.

### **Data**  

The data for analysis was extracted from Census Data and the harmonized Longitudinal Tracts Data Base (LTDB). The LTDB is a great resource for evaluating the changes in the     communities; however, minor redesign was needed to make the rest of the project smoother. This project used variable names that are standardized, combined files, made           accessible meta-data on tracts, and created a harmonization file to improve the usability of the data. Most of the variables used in this project (Harmonized Census Data Part-   01) come from the long-form version of the census (which is only administered to a sample of the population) or variables from the American Community Survey (the annual survey   given to a    subsample of citizens). The second dataset (Harmonized Census Data Part-02) contains only variables that come from the Decennial Census short form, and they are   population measures and not sample estimates. The variables are measured at the Census Tract level using 2010 census tracts. Also, we had to build a machine-readable data       dictionary which allowed us to find the variables we needed quickly.  

This analysis filters out all rural counties since they are not eligible for the programs of interest.  

### **Methods**  

The change in the Median Home Value (MHV) variable between 1990-2000 instead of 2000 to 2010 period was reproduced in Chapter 3. This chapters provides a descriptive analysis   of the notable difference in home values during the two-time frames. To conceptualize gentrification, new variables were added to our dataset to examine its prevalence in the   data. This chapter also displays a dorling cartogram of San Francsico city to describe the distribution of home values in 1990 and compare values in 2000 to changes in values   from 1990-2000.   

The dependent variable in our model is the median home value. Since we don???t have recent sales data that would tell us exactly how much people are paying for homes, the census   data uses the respondent???s estimate of how much the property (house and lot) would sell or if it were for sale. Chapter 4 shows our baseline model of neighborhood change         before adding the policy variables; omitting cases that have a median home value less than $10,000 in 2000 and cases with growth rates above 200%. It creates a regression       model using control variables, checks for variable skew, and multicollinearity, and adds a metro-level control. 

### **Results**  

The results are shown in detail in Chapter 6. This chapter summarizes the results of the predicted MHV change between 2000 and 2010 across all tracts and the impact of two       tax incentive programs: the Low Income Housing Tax Credit (LIHTC) and the New Market Tax Credit (NMTC).
