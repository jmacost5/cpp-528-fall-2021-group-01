---
title: "Predicting MHV Change"
subtitle: "Creating a Hedonic Pricing Model to predict neighborhood change."
author: "Erin McIntyre"
date: "11/13/2021"
---


# "Creating a Hedonic Pricing Model to predict neighborhood change."

## Author: Erin McIntyre

## Date: 12/1/2021

```r

# load necessary packages ----
library( dplyr )
library( here )
library( knitr )
library( pander )
library( stargazer )
library( scales )

# set randomization seed ----
set.seed( 1234 )

# load necessary functions and objects ----
# note: all of these are R objects that will be used throughout this .rmd file
import::here("S_TYPE",
             "panel.cor",
             "panel.smooth",
             "jplot",
             "d",
             "df",
             "cbsa_stats_df",
             # notice the use of here::here() that points to the .R file
             # where all these R objects are created
             .from = here::here("analysis/utilities_master.R"),
             .character_only = TRUE)

```


### Part 1 - Data


```r

head(df) %>% pander()

```

```r

head(d) %>% pander()

```

```r

head(cbsa_stats_df) %>% pander()

```


```r

stargazer( df, 
           type=S_TYPE, 
           digits=0, 
           summary.stat = c("min", "p25","median","mean","p75","max") )

```


```r
# Omit cases that have a median home value less than $10,000 in 2000.
# Omit cases with growth rates above 200%.

d_clean <-
  d %>% 
  filter(mhv.00 > 10000) %>% 
  filter(mhv.growth < 200)

head(d_clean) %>% pander()
```



### Part 2 - Predict MHV Change


```r

# Check variables available for regression model
colnames(d)

```

  

```r scatter plot 1
# Select predictors of change in MHV or mhv.growth

d_predict <- select(d_clean, mhv.growth, pov.rate, p.unemp, hinc00, p.white, p.col, p.prof)

# reduce data density for visualization
set.seed( 1234 )
d1 <- sample_n( d_predict, 10000 ) %>% na.omit()

# correlation plots
pairs(d1, panel = panel.cor, lower.panel = panel.smooth )

```



```r scatter plot 2
# Perform log transformation to get rid of varibale skew.

# reduce data density for visualization
set.seed( 1234 )

# recode some vars to remove outliers and skew
d_predict$p.unemp <- log10( d_predict$p.unemp + 1 )
d_predict$hinc00 <- log10( d_predict$hinc00 + 1 )
d_predict$p.white <- log10( d_predict$p.white + 1  )
d_predict$pov.rate <- log10( d_predict$pov.rate + 1 )
d_predict$p.col <- log10( d_predict$p.col + 1 )
d_predict$p.prof <- log10( d_predict$p.prof + 1 )


d2 <- sample_n( d_predict, 5000 ) %>% na.omit()

# correlation plots
pairs(d2, panel = panel.cor, lower.panel = panel.smooth )

```

#### Multicollinearity Test

```r

# Test for multicollinearity

m1 <- lm( mhv.growth ~  pov.rate, data=d_predict )
m2 <- lm( mhv.growth ~  p.unemp, data=d_predict )
m3 <- lm( mhv.growth ~  p.white, data=d_predict )
m4 <- lm( mhv.growth ~  p.prof, data=d_predict )
m5 <- lm( mhv.growth ~  pov.rate + p.unemp + p.white + p.prof, data=d_predict )

stargazer( m1, m2, m3, m4, m5,
           type=S_TYPE, digits=2,
           omit.stat = c("rsq","f") )


```

#### Multicollinearity Test 2

```r
# Remove p.unemp and run the regression model again. 

m6 <- lm( mhv.growth ~  pov.rate + p.white + p.prof, data=d_predict )

stargazer( m1, m3, m4, m6,
           type=S_TYPE, digits=2,
           omit.stat = c("rsq","f") )


```

#### Final Regression Model

```r
# Add a metro-level control

d_fixed <- 
  d_clean %>%
  group_by( cbsaname ) %>%
  mutate( metro.mhv.growth = 100 * median( mhv.growth, na.rm=T ) ) %>%
  ungroup() 

# Select variables for regression model.
d.reg <- select(d_fixed, mhv.growth, pov.rate, p.white, p.prof, cbsa)


# Perform log transformations
d.reg$p.white <- log10( d.reg$p.white + 1  )
d.reg$pov.rate <- log10( d.reg$pov.rate + 1 )
d.reg$p.prof <- log10( d.reg$p.prof + 1 )

# Regression Model
m1 <- lm( mhv.growth ~  pov.rate, data=d.reg )
m2 <- lm( mhv.growth ~  p.white, data=d.reg )
m3 <- lm( mhv.growth ~  p.prof, data=d.reg )
m4 <- lm( mhv.growth ~  pov.rate + p.white + p.prof + cbsa, data=d.reg )

stargazer( m1, m2, m3, m4,
           type=S_TYPE, digits=2,
           omit.stat = c("rsq","f"),
           omit="cbsa",
           add.lines = list(c("Metro Fixed Effects:", "NO", "NO", "NO", "YES")) )

```


### Reflection


**The higher the poverty rate in a metro area, the more growth they will experience in median home value. Specifically, a 1% growth in poverty rate results in a 12.93% growth in median home value. This result makes the most sense based on what we know about gentrification. Median home value will grow at a quicker rate (or higher percentage) in a metropolitan area where the poverty rate was already high compared to a richer area.**

**The higher the percentage of whites in the population in 2000, the less growth in median home value a tract or metro area will experience. Specifically, a 1% increase in percent white results in a 14.82% decrease in median home value growth. However, upon adding the cbsa variable to create a metro-level fixed effect, the coefficient decreases immensely. This indicates that the percent of white in the population has different effects on median home value growth depending on the tract. This should be investigated further.**

**The higher the percentage of professional employees in the population in 2000, the more growth they will experience in median home value. Specifically, a 1% increase in percent professional will result in a 4.27% growth in median home value. This result makes less sense since it conceptually contradicts the trend seen with poverty rates. The increase in the coefficient in the fourth model is also concerning. This indicates some sort of difference in the effects of percent professional on mhv.growth in separate tracts.**

**It is also interesting to note that all the control variables selected are significant.**


