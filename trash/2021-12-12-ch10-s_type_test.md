---
title: S_TYPE Test
subtitle: "Testing html for S_TYPE instead of text."
---


``` r
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

``` r
# Omit cases that have a median home value less than $10,000 in 2000.
# Omit cases with growth rates above 200%.

d_clean <-
  d %>% 
  filter(mhv.00 > 10000) %>% 
  filter(mhv.growth < 200)

# Select predictors of change in MHV or mhv.growth
d_predict <- select(d_clean, mhv.growth, pov.rate, p.unemp, hinc00, p.white, p.col, p.prof)


# recode some vars to remove outliers and skew
d_predict$p.unemp <- log10( d_predict$p.unemp + 1 )
d_predict$hinc00 <- log10( d_predict$hinc00 + 1 )
d_predict$p.white <- log10( d_predict$p.white + 1  )
d_predict$pov.rate <- log10( d_predict$pov.rate + 1 )
d_predict$p.col <- log10( d_predict$p.col + 1 )
d_predict$p.prof <- log10( d_predict$p.prof + 1 )
```

``` r
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

    ## 
    ## <table style="text-align:center"><tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="5"><em>Dependent variable:</em></td></tr>
    ## <tr><td></td><td colspan="5" style="border-bottom: 1px solid black"></td></tr>
    ## <tr><td style="text-align:left"></td><td colspan="5">mhv.growth</td></tr>
    ## <tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td><td>(5)</td></tr>
    ## <tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">pov.rate</td><td>12.93<sup>***</sup></td><td></td><td></td><td></td><td>14.37<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td>(0.42)</td><td></td><td></td><td></td><td>(0.66)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">p.unemp</td><td></td><td>15.57<sup>***</sup></td><td></td><td></td><td>3.57<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td>(0.56)</td><td></td><td></td><td>(0.87)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">p.white</td><td></td><td></td><td>-14.82<sup>***</sup></td><td></td><td>-15.09<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td>(0.35)</td><td></td><td>(0.45)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">p.prof</td><td></td><td></td><td></td><td>4.27<sup>***</sup></td><td>37.54<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td>(0.74)</td><td>(0.95)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">Constant</td><td>16.69<sup>***</sup></td><td>17.43<sup>***</sup></td><td>54.97<sup>***</sup></td><td>23.04<sup>***</sup></td><td>-17.73<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td>(0.44)</td><td>(0.46)</td><td>(0.62)</td><td>(1.11)</td><td>(2.08)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>58,798</td><td>58,801</td><td>58,839</td><td>58,797</td><td>58,788</td></tr>
    ## <tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.02</td><td>0.01</td><td>0.03</td><td>0.001</td><td>0.06</td></tr>
    ## <tr><td style="text-align:left">Residual Std. Error</td><td>34.89 (df = 58796)</td><td>34.94 (df = 58799)</td><td>34.65 (df = 58837)</td><td>35.16 (df = 58795)</td><td>34.17 (df = 58783)</td></tr>
    ## <tr><td colspan="6" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="5" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
    ## </table>

``` r
# Remove p.unemp and run the regression model again. 

m6 <- lm( mhv.growth ~  pov.rate + p.white + p.prof, data=d_predict )

stargazer( m1, m3, m4, m6,
           type=S_TYPE, digits=2,
           omit.stat = c("rsq","f") )
```

    ## 
    ## <table style="text-align:center"><tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="4"><em>Dependent variable:</em></td></tr>
    ## <tr><td></td><td colspan="4" style="border-bottom: 1px solid black"></td></tr>
    ## <tr><td style="text-align:left"></td><td colspan="4">mhv.growth</td></tr>
    ## <tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td></tr>
    ## <tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">pov.rate</td><td>12.93<sup>***</sup></td><td></td><td></td><td>15.68<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td>(0.42)</td><td></td><td></td><td>(0.57)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">p.white</td><td></td><td>-14.82<sup>***</sup></td><td></td><td>-15.66<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td>(0.35)</td><td></td><td>(0.42)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">p.prof</td><td></td><td></td><td>4.27<sup>***</sup></td><td>36.85<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td>(0.74)</td><td>(0.94)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">Constant</td><td>16.69<sup>***</sup></td><td>54.97<sup>***</sup></td><td>23.04<sup>***</sup></td><td>-14.27<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td>(0.44)</td><td>(0.62)</td><td>(1.11)</td><td>(1.90)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Observations</td><td>58,798</td><td>58,839</td><td>58,797</td><td>58,788</td></tr>
    ## <tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.02</td><td>0.03</td><td>0.001</td><td>0.06</td></tr>
    ## <tr><td style="text-align:left">Residual Std. Error</td><td>34.89 (df = 58796)</td><td>34.65 (df = 58837)</td><td>35.16 (df = 58795)</td><td>34.18 (df = 58784)</td></tr>
    ## <tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="4" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
    ## </table>

``` r
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

    ## 
    ## <table style="text-align:center"><tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"></td><td colspan="4"><em>Dependent variable:</em></td></tr>
    ## <tr><td></td><td colspan="4" style="border-bottom: 1px solid black"></td></tr>
    ## <tr><td style="text-align:left"></td><td colspan="4">mhv.growth</td></tr>
    ## <tr><td style="text-align:left"></td><td>(1)</td><td>(2)</td><td>(3)</td><td>(4)</td></tr>
    ## <tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">pov.rate</td><td>12.93<sup>***</sup></td><td></td><td></td><td>13.47<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td>(0.42)</td><td></td><td></td><td>(0.48)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">p.white</td><td></td><td>-14.82<sup>***</sup></td><td></td><td>-1.39<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td>(0.35)</td><td></td><td>(0.40)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">p.prof</td><td></td><td></td><td>4.27<sup>***</sup></td><td>8.97<sup>***</sup></td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td>(0.74)</td><td>(0.80)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td style="text-align:left">Constant</td><td>16.69<sup>***</sup></td><td>54.97<sup>***</sup></td><td>23.04<sup>***</sup></td><td>-0.26</td></tr>
    ## <tr><td style="text-align:left"></td><td>(0.44)</td><td>(0.62)</td><td>(1.11)</td><td>(4.41)</td></tr>
    ## <tr><td style="text-align:left"></td><td></td><td></td><td></td><td></td></tr>
    ## <tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left">Metro Fixed Effects:</td><td>NO</td><td>NO</td><td>NO</td><td>YES</td></tr>
    ## <tr><td style="text-align:left">Observations</td><td>58,798</td><td>58,839</td><td>58,797</td><td>58,788</td></tr>
    ## <tr><td style="text-align:left">Adjusted R<sup>2</sup></td><td>0.02</td><td>0.03</td><td>0.001</td><td>0.42</td></tr>
    ## <tr><td style="text-align:left">Residual Std. Error</td><td>34.89 (df = 58796)</td><td>34.65 (df = 58837)</td><td>35.16 (df = 58795)</td><td>26.84 (df = 58406)</td></tr>
    ## <tr><td colspan="5" style="border-bottom: 1px solid black"></td></tr><tr><td style="text-align:left"><em>Note:</em></td><td colspan="4" style="text-align:right"><sup>*</sup>p<0.1; <sup>**</sup>p<0.05; <sup>***</sup>p<0.01</td></tr>
    ## </table>
