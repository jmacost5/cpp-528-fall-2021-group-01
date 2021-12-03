---
title: Predicting MHV Change
subtitle: "Creating a Hedonic Pricing Model to predict neighborhood change."
---

In this chapter, control variables will be selected to create a regression model using median home value (MHV) growth as a dependent variable. 
The reason for choosing MHV growth is explained in our [Lab 04 Lecture](https://watts-college.github.io/cpp-528-fall-2021/sched/week-04/); "*The main insight is that home price is a variable that aggregates a tremendous amount of information about characteristics of houses, neighborhoods, and cities. We can use regression to separate out these difference attributes at different levels, and see they each contributes to the market value of a home.*"
   

``` r
# load necessary packages ----
library( dplyr )
library( here )
library( knitr )
library( pander )
library(tidycensus)
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
options(tigris_use_cache = TRUE)
```

# Part 1 - Data

Preview the data sets (**d**, **df**, and **cbsa\_stats\_df**).

**d** contains select variables from the census tract data. The data set
was cleaned and created in the `utilities_master.R file`.

``` r
head(d) %>% pander()
```

|      tractid       | mhmval00 | mhmval12 | hinc00 | hu00 | vac00 | own00 |
| :----------------: | :------: | :------: | :----: | :--: | :---: | :---: |
| fips-01-001-020100 |  76600   |  121500  | 36685  | 769  |  93   |  518  |
| fips-01-001-020200 |  72900   |  130500  | 30298  | 731  |  67   |  452  |
| fips-01-001-020300 |  79900   |  118700  | 46731  | 1263 |  61   |  869  |
| fips-01-001-020400 |  89800   |  133500  | 46142  | 1871 |  111  | 1390  |
| fips-01-001-020500 |  116594  |  174500  | 58886  | 2282 | 80.39 | 1671  |
| fips-01-001-020600 |  70400   |  129600  | 33699  | 1310 | 139.5 | 960.9 |

Table continues below

| rent00 | h30old00 | empclf00 | clf00 | unemp00 | prof00 | dpov00 | npov00 |
| :----: | :------: | :------: | :---: | :-----: | :----: | :----: | :----: |
|  158   |   225    |   826    |  872  |   46    |  221   |  1790  |  227   |
|  212   |   329    |   722    |  802  |   80    |  154   |  1907  |  433   |
|  333   |   452    |   1414   | 1456  |   42    |  438   |  3262  |  250   |
|  370   |   979    |   2114   | 2191  |   77    |  673   |  4551  |  207   |
| 531.3  |  152.5   |   2906   | 2955  |  49.35  |  1173  |  6048  | 223.3  |
| 209.2  |  450.4   |   1497   | 1584  |  87.18  | 364.2  |  3272  | 497.9  |

Table continues below

| ag25up00 | hs00 | col00 | pop00.x | nhwht00 | nhblk00 | hisp00 | asian00 |
| :------: | :--: | :---: | :-----: | :-----: | :-----: | :----: | :-----: |
|   1227   | 635  |  192  |  1921   |  1723   |   145   |   12   |    8    |
|   1157   | 740  |  170  |  1892   |   671   |  1177   |   16   |   12    |
|   2130   | 990  |  478  |  3339   |  2738   |   498   |   55   |   27    |
|   3072   | 1477 |  708  |  4556   |  4273   |   118   |  101   |   40    |
|   3785   | 1257 | 1214  |  6054   |  5427   |  367.5  | 95.24  |  113.1  |
|   1977   | 1179 | 317.7 |  3272   |  2615   |  553.1  | 63.93  |  10.65  |

Table continues below

| cbsa  |    cbsaname    | mhv.00 | mhv.10 | mhv.change | mhv.growth | p.white |
| :---: | :------------: | :----: | :----: | :--------: | :--------: | :-----: |
| 33860 | Montgomery, AL | 98703  | 121500 |   22797    |    23.1    |  89.69  |
| 33860 | Montgomery, AL | 93935  | 130500 |   36565    |   38.93    |  35.47  |
| 33860 | Montgomery, AL | 102955 | 118700 |   15745    |   15.29    |   82    |
| 33860 | Montgomery, AL | 115712 | 133500 |   17788    |   15.37    |  93.79  |
| 33860 | Montgomery, AL | 150237 | 174500 |   24263    |   16.15    |  89.64  |
| 33860 | Montgomery, AL | 90714  | 129600 |   38886    |   42.87    |  79.93  |

Table continues below

| p.black | p.hisp | p.asian | p.hs  | p.col | p.prof | p.unemp | p.vacant |
| :-----: | :----: | :-----: | :---: | :---: | :----: | :-----: | :------: |
|  7.548  | 0.6247 | 0.4164  | 67.4  | 15.65 | 26.76  |  5.275  |  12.09   |
|  62.21  | 0.8457 | 0.6342  | 78.65 | 14.69 | 21.33  |  9.975  |  9.166   |
|  14.91  | 1.647  | 0.8086  | 68.92 | 22.44 | 30.98  |  2.885  |   4.83   |
|  2.59   | 2.217  |  0.878  | 71.13 | 23.05 | 31.84  |  3.514  |  5.933   |
|  6.07   | 1.573  |  1.867  | 65.29 | 32.07 | 40.38  |  1.67   |  3.522   |
|  16.9   | 1.954  | 0.3256  | 75.7  | 16.07 | 24.34  |  5.505  |  10.65   |

Table continues below

| mhv.change.00.to.10 | p.mhv.change | pov.rate |
| :-----------------: | :----------: | :------: |
|        44900        |    58.62     |  12.68   |
|        57600        |    79.01     |  22.71   |
|        38800        |    48.56     |  7.664   |
|        43700        |    48.66     |  4.548   |
|        57906        |    49.67     |  3.692   |
|        59200        |    84.09     |  15.22   |

**df** was created using the *mhv.00*, *mhv.10*, *mhv.change*, and
*mhv.growth* variables from data set **d**.

``` r
head(df) %>% pander()
```

| MedianHomeValue2000 | MedianHomeValue2010 | MHV.Change.00.to.10 |
| :-----------------: | :-----------------: | :-----------------: |
|        98703        |       121500        |        22797        |
|        93935        |       130500        |        36565        |
|       102955        |       118700        |        15745        |
|       115712        |       133500        |        17788        |
|       150237        |       174500        |        24263        |
|        90714        |       129600        |        38886        |

Table continues below

| MHV.Growth.00.to.12 |
| :-----------------: |
|        23.1         |
|        38.93        |
|        15.29        |
|        15.37        |
|        16.15        |
|        42.87        |

**cbsa\_stats\_df** displays the median median home value change and
growth for each metropolitan area.

``` r
head(cbsa_stats_df) %>% pander()
```

|          cbsaname           | metro.mhv.change | metro.mhv.growth |
| :-------------------------: | :--------------: | :--------------: |
|         Abilene, TX         |      12667       |       2182       |
|          Akron, OH          |     \-10634      |     \-887.3      |
| Albany-Schenectady-Troy, NY |      54413       |       4176       |
|         Albany, GA          |       5547       |      645.6       |
|       Albuquerque, NM       |      27947       |       1849       |
|       Alexandria, LA        |      23329       |       3274       |

Look at the summary statistics for **df**.

``` r
stargazer( df, 
           type=S_TYPE, 
           digits=0, 
           summary.stat = c("min", "p25","median","mean","p75","max") )
```

<table style="text-align:center">

<tr>

<td colspan="7" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Statistic

</td>

<td>

Min

</td>

<td>

Pctl(25)

</td>

<td>

Median

</td>

<td>

Mean

</td>

<td>

Pctl(75)

</td>

<td>

Max

</td>

</tr>

<tr>

<td colspan="7" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

MedianHomeValue2000

</td>

<td>

11,167

</td>

<td>

105,661

</td>

<td>

154,903

</td>

<td>

187,129

</td>

<td>

224,337

</td>

<td>

1,288,551

</td>

</tr>

<tr>

<td style="text-align:left">

MedianHomeValue2010

</td>

<td>

9,999

</td>

<td>

123,200

</td>

<td>

193,200

</td>

<td>

246,570

</td>

<td>

312,000

</td>

<td>

1,000,001

</td>

</tr>

<tr>

<td style="text-align:left">

MHV.Change.00.to.10

</td>

<td>

\-1,228,651

</td>

<td>

7,187

</td>

<td>

36,268

</td>

<td>

60,047

</td>

<td>

94,881

</td>

<td>

1,000,001

</td>

</tr>

<tr>

<td style="text-align:left">

MHV.Growth.00.to.12

</td>

<td>

\-97

</td>

<td>

6

</td>

<td>

25

</td>

<td>

33

</td>

<td>

50

</td>

<td>

6,059

</td>

</tr>

<tr>

<td colspan="7" style="border-bottom: 1px solid black">

</td>

</tr>

</table>

Complete one final step to clean the data.

1)  Omit cases that have a median home value less than $10,000 in 2000.

2)  Omit cases with growth rates above 200%.

<!-- end list -->

``` r
d_clean <-
  d %>% 
  filter(mhv.00 > 10000) %>% 
  filter(mhv.growth < 200)

head(d_clean) %>% pander()
```

|      tractid       | mhmval00 | mhmval12 | hinc00 | hu00 | vac00 | own00 |
| :----------------: | :------: | :------: | :----: | :--: | :---: | :---: |
| fips-01-001-020100 |  76600   |  121500  | 36685  | 769  |  93   |  518  |
| fips-01-001-020200 |  72900   |  130500  | 30298  | 731  |  67   |  452  |
| fips-01-001-020300 |  79900   |  118700  | 46731  | 1263 |  61   |  869  |
| fips-01-001-020400 |  89800   |  133500  | 46142  | 1871 |  111  | 1390  |
| fips-01-001-020500 |  116594  |  174500  | 58886  | 2282 | 80.39 | 1671  |
| fips-01-001-020600 |  70400   |  129600  | 33699  | 1310 | 139.5 | 960.9 |

Table continues below

| rent00 | h30old00 | empclf00 | clf00 | unemp00 | prof00 | dpov00 | npov00 |
| :----: | :------: | :------: | :---: | :-----: | :----: | :----: | :----: |
|  158   |   225    |   826    |  872  |   46    |  221   |  1790  |  227   |
|  212   |   329    |   722    |  802  |   80    |  154   |  1907  |  433   |
|  333   |   452    |   1414   | 1456  |   42    |  438   |  3262  |  250   |
|  370   |   979    |   2114   | 2191  |   77    |  673   |  4551  |  207   |
| 531.3  |  152.5   |   2906   | 2955  |  49.35  |  1173  |  6048  | 223.3  |
| 209.2  |  450.4   |   1497   | 1584  |  87.18  | 364.2  |  3272  | 497.9  |

Table continues below

| ag25up00 | hs00 | col00 | pop00.x | nhwht00 | nhblk00 | hisp00 | asian00 |
| :------: | :--: | :---: | :-----: | :-----: | :-----: | :----: | :-----: |
|   1227   | 635  |  192  |  1921   |  1723   |   145   |   12   |    8    |
|   1157   | 740  |  170  |  1892   |   671   |  1177   |   16   |   12    |
|   2130   | 990  |  478  |  3339   |  2738   |   498   |   55   |   27    |
|   3072   | 1477 |  708  |  4556   |  4273   |   118   |  101   |   40    |
|   3785   | 1257 | 1214  |  6054   |  5427   |  367.5  | 95.24  |  113.1  |
|   1977   | 1179 | 317.7 |  3272   |  2615   |  553.1  | 63.93  |  10.65  |

Table continues below

| cbsa  |    cbsaname    | mhv.00 | mhv.10 | mhv.change | mhv.growth | p.white |
| :---: | :------------: | :----: | :----: | :--------: | :--------: | :-----: |
| 33860 | Montgomery, AL | 98703  | 121500 |   22797    |    23.1    |  89.69  |
| 33860 | Montgomery, AL | 93935  | 130500 |   36565    |   38.93    |  35.47  |
| 33860 | Montgomery, AL | 102955 | 118700 |   15745    |   15.29    |   82    |
| 33860 | Montgomery, AL | 115712 | 133500 |   17788    |   15.37    |  93.79  |
| 33860 | Montgomery, AL | 150237 | 174500 |   24263    |   16.15    |  89.64  |
| 33860 | Montgomery, AL | 90714  | 129600 |   38886    |   42.87    |  79.93  |

Table continues below

| p.black | p.hisp | p.asian | p.hs  | p.col | p.prof | p.unemp | p.vacant |
| :-----: | :----: | :-----: | :---: | :---: | :----: | :-----: | :------: |
|  7.548  | 0.6247 | 0.4164  | 67.4  | 15.65 | 26.76  |  5.275  |  12.09   |
|  62.21  | 0.8457 | 0.6342  | 78.65 | 14.69 | 21.33  |  9.975  |  9.166   |
|  14.91  | 1.647  | 0.8086  | 68.92 | 22.44 | 30.98  |  2.885  |   4.83   |
|  2.59   | 2.217  |  0.878  | 71.13 | 23.05 | 31.84  |  3.514  |  5.933   |
|  6.07   | 1.573  |  1.867  | 65.29 | 32.07 | 40.38  |  1.67   |  3.522   |
|  16.9   | 1.954  | 0.3256  | 75.7  | 16.07 | 24.34  |  5.505  |  10.65   |

Table continues below

| mhv.change.00.to.10 | p.mhv.change | pov.rate |
| :-----------------: | :----------: | :------: |
|        44900        |    58.62     |  12.68   |
|        57600        |    79.01     |  22.71   |
|        38800        |    48.56     |  7.664   |
|        43700        |    48.66     |  4.548   |
|        57906        |    49.67     |  3.692   |
|        59200        |    84.09     |  15.22   |

# Part 2 - Predict MHV Change

The next step is to create a regression model using control variables
which can predict changes in median home value. There are a few tests
which need to be completed before finalizing the regression model to
predict MHV change. The code below will review the following steps:

1)  Select control variables.

2)  Check for variable skew and perform log transformation if needed.

3)  Check for multicolinearity.

4)  Add a metro-level control.

Check variables available for the regression model.

``` r
# Check variables available for regression model
colnames(d)
```

    ##  [1] "tractid"             "mhmval00"            "mhmval12"            "hinc00"              "hu00"                "vac00"               "own00"              
    ##  [8] "rent00"              "h30old00"            "empclf00"            "clf00"               "unemp00"             "prof00"              "dpov00"             
    ## [15] "npov00"              "ag25up00"            "hs00"                "col00"               "pop00.x"             "nhwht00"             "nhblk00"            
    ## [22] "hisp00"              "asian00"             "cbsa"                "cbsaname"            "mhv.00"              "mhv.10"              "mhv.change"         
    ## [29] "mhv.growth"          "p.white"             "p.black"             "p.hisp"              "p.asian"             "p.hs"                "p.col"              
    ## [36] "p.prof"              "p.unemp"             "p.vacant"            "mhv.change.00.to.10" "p.mhv.change"        "pov.rate"

Select variables to predict MHV change. Compare the scatter plots of the
variables.

``` r
# Select predictors of change in MHV or mhv.growth
d_predict <- select(d_clean, mhv.growth, pov.rate, p.unemp, hinc00, p.white, p.col, p.prof)

# reduce data density for visualization
set.seed( 1234 )
d1 <- sample_n( d_predict, 10000 ) %>% na.omit()

# correlation plots
pairs(d1, panel = panel.cor, lower.panel = panel.smooth )
```

![](../assets/img/2021-11-13-ch03-predicting_change_files/figure-gfm/scatter%20plot%201-1.png)<!-- -->

Many scatter plots are clustered to one side, do not produce a linear
path, or have outliers. These plots indicate that the data is skewed.
The data must be manipulated to create a model of better fit.

To do this, perform log transformations to get rid of varibale skew.
Compare the scatter plots again.

``` r
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

![](../assets/img/2021-11-13-ch03-predicting_change_files/figure-gfm/scatter%20plot%202-1.png)<!-- -->

These scatter plots look a bit better.

Next, test for multicollinearity by running a regression model comparing
selected variables. *hinc00* and *p.col* were not selected due to their
high correlation with *pov.rate* and *p.prof*. These variables measure
similar outcomes and do not add any new information.

``` r
# multicollinearity test 1

m1 <- lm( mhv.growth ~  pov.rate, data=d_predict )
m2 <- lm( mhv.growth ~  p.unemp, data=d_predict )
m3 <- lm( mhv.growth ~  p.white, data=d_predict )
m4 <- lm( mhv.growth ~  p.prof, data=d_predict )
m5 <- lm( mhv.growth ~  pov.rate + p.unemp + p.white + p.prof, data=d_predict )

stargazer( m1, m2, m3, m4, m5,
           type=S_TYPE, digits=2,
           omit.stat = c("rsq","f") )
```

<table style="text-align:center">

<tr>

<td colspan="6" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="5">

<em>Dependent variable:</em>

</td>

</tr>

<tr>

<td>

</td>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="5">

mhv.growth

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(1)

</td>

<td>

(2)

</td>

<td>

(3)

</td>

<td>

(4)

</td>

<td>

(5)

</td>

</tr>

<tr>

<td colspan="6" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

pov.rate

</td>

<td>

12.93<sup>\*\*\*</sup>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

14.37<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.42)

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

(0.66)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

p.unemp

</td>

<td>

</td>

<td>

15.57<sup>\*\*\*</sup>

</td>

<td>

</td>

<td>

</td>

<td>

3.57<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

(0.56)

</td>

<td>

</td>

<td>

</td>

<td>

(0.87)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

p.white

</td>

<td>

</td>

<td>

</td>

<td>

\-14.82<sup>\*\*\*</sup>

</td>

<td>

</td>

<td>

\-15.09<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

(0.35)

</td>

<td>

</td>

<td>

(0.45)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

p.prof

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

4.27<sup>\*\*\*</sup>

</td>

<td>

37.54<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

(0.74)

</td>

<td>

(0.95)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

Constant

</td>

<td>

16.69<sup>\*\*\*</sup>

</td>

<td>

17.43<sup>\*\*\*</sup>

</td>

<td>

54.97<sup>\*\*\*</sup>

</td>

<td>

23.04<sup>\*\*\*</sup>

</td>

<td>

\-17.73<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.44)

</td>

<td>

(0.46)

</td>

<td>

(0.62)

</td>

<td>

(1.11)

</td>

<td>

(2.08)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td colspan="6" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Observations

</td>

<td>

58,798

</td>

<td>

58,801

</td>

<td>

58,839

</td>

<td>

58,797

</td>

<td>

58,788

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.02

</td>

<td>

0.01

</td>

<td>

0.03

</td>

<td>

0.001

</td>

<td>

0.06

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

34.89 (df = 58796)

</td>

<td>

34.94 (df = 58799)

</td>

<td>

34.65 (df = 58837)

</td>

<td>

35.16 (df = 58795)

</td>

<td>

34.17 (df = 58783)

</td>

</tr>

<tr>

<td colspan="6" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

<em>Note:</em>

</td>

<td colspan="5" style="text-align:right">

<sup>*</sup>p\<0.1; <sup>**</sup>p\<0.05; <sup>***</sup>p\<0.01

</td>

</tr>

</table>

The coefficient for *p.unemp* drops significantly from m1 to m5. This
indicates that the variable contains redundant information.

Remove *p.unemp* and run the regression model again.

``` r
# Create a new model with p.unemp removed.
m6 <- lm( mhv.growth ~  pov.rate + p.white + p.prof, data=d_predict )

stargazer( m1, m3, m4, m6,
           type=S_TYPE, digits=2,
           omit.stat = c("rsq","f") )
```

<table style="text-align:center">

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="4">

<em>Dependent variable:</em>

</td>

</tr>

<tr>

<td>

</td>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="4">

mhv.growth

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(1)

</td>

<td>

(2)

</td>

<td>

(3)

</td>

<td>

(4)

</td>

</tr>

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

pov.rate

</td>

<td>

12.93<sup>\*\*\*</sup>

</td>

<td>

</td>

<td>

</td>

<td>

15.68<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.42)

</td>

<td>

</td>

<td>

</td>

<td>

(0.57)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

p.white

</td>

<td>

</td>

<td>

\-14.82<sup>\*\*\*</sup>

</td>

<td>

</td>

<td>

\-15.66<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

(0.35)

</td>

<td>

</td>

<td>

(0.42)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

p.prof

</td>

<td>

</td>

<td>

</td>

<td>

4.27<sup>\*\*\*</sup>

</td>

<td>

36.85<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

(0.74)

</td>

<td>

(0.94)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

Constant

</td>

<td>

16.69<sup>\*\*\*</sup>

</td>

<td>

54.97<sup>\*\*\*</sup>

</td>

<td>

23.04<sup>\*\*\*</sup>

</td>

<td>

\-14.27<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.44)

</td>

<td>

(0.62)

</td>

<td>

(1.11)

</td>

<td>

(1.90)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Observations

</td>

<td>

58,798

</td>

<td>

58,839

</td>

<td>

58,797

</td>

<td>

58,788

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.02

</td>

<td>

0.03

</td>

<td>

0.001

</td>

<td>

0.06

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

34.89 (df = 58796)

</td>

<td>

34.65 (df = 58837)

</td>

<td>

35.16 (df = 58795)

</td>

<td>

34.18 (df = 58784)

</td>

</tr>

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

<em>Note:</em>

</td>

<td colspan="4" style="text-align:right">

<sup>*</sup>p\<0.1; <sup>**</sup>p\<0.05; <sup>***</sup>p\<0.01

</td>

</tr>

</table>

Variables may produce different effects in different tracts. Add a
metro-level control to anchor the dependent variable (*mhv.growth*) and
account for context. This will be the final data manipulation.

``` r
# Add metro-level control
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

<table style="text-align:center">

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="4">

<em>Dependent variable:</em>

</td>

</tr>

<tr>

<td>

</td>

<td colspan="4" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td colspan="4">

mhv.growth

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(1)

</td>

<td>

(2)

</td>

<td>

(3)

</td>

<td>

(4)

</td>

</tr>

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

pov.rate

</td>

<td>

12.93<sup>\*\*\*</sup>

</td>

<td>

</td>

<td>

</td>

<td>

13.47<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.42)

</td>

<td>

</td>

<td>

</td>

<td>

(0.48)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

p.white

</td>

<td>

</td>

<td>

\-14.82<sup>\*\*\*</sup>

</td>

<td>

</td>

<td>

\-1.39<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

(0.35)

</td>

<td>

</td>

<td>

(0.40)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

p.prof

</td>

<td>

</td>

<td>

</td>

<td>

4.27<sup>\*\*\*</sup>

</td>

<td>

8.97<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

(0.74)

</td>

<td>

(0.80)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

Constant

</td>

<td>

16.69<sup>\*\*\*</sup>

</td>

<td>

54.97<sup>\*\*\*</sup>

</td>

<td>

23.04<sup>\*\*\*</sup>

</td>

<td>

\-0.26

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.44)

</td>

<td>

(0.62)

</td>

<td>

(1.11)

</td>

<td>

(4.41)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

<td>

</td>

<td>

</td>

<td>

</td>

</tr>

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Metro Fixed Effects:

</td>

<td>

NO

</td>

<td>

NO

</td>

<td>

NO

</td>

<td>

YES

</td>

</tr>

<tr>

<td style="text-align:left">

Observations

</td>

<td>

58,798

</td>

<td>

58,839

</td>

<td>

58,797

</td>

<td>

58,788

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.02

</td>

<td>

0.03

</td>

<td>

0.001

</td>

<td>

0.42

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

34.89 (df = 58796)

</td>

<td>

34.65 (df = 58837)

</td>

<td>

35.16 (df = 58795)

</td>

<td>

26.84 (df = 58406)

</td>

</tr>

<tr>

<td colspan="5" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

<em>Note:</em>

</td>

<td colspan="4" style="text-align:right">

<sup>*</sup>p\<0.1; <sup>**</sup>p\<0.05; <sup>***</sup>p\<0.01

</td>

</tr>

</table>

# Reflection

The higher the poverty rate in a metro area, the more growth they will
experience in median home value. Specifically, a 1% growth in poverty
rate results in a 12.93% growth in median home value. This result makes
the most sense based on what we know about gentrification. Median home
value will grow at a quicker rate (or higher percentage) in a
metropolitan area where the poverty rate was already high compared to a
richer area.

The higher the percentage of whites in the population in 2000, the less
growth in median home value a tract or metro area will experience.
Specifically, a 1% increase in percent white results in a 14.82%
decrease in median home value growth. However, upon adding the cbsa
variable to create a metro-level fixed effect, the coefficient decreases
immensely. This indicates that the percent of white in the population
has different effects on median home value growth depending on the
tract. This should be investigated further.

The higher the percentage of professional employees in the population in
2000, the more growth they will experience in median home value.
Specifically, a 1% increase in percent professional will result in a
4.27% growth in median home value. This result makes less sense since it
conceptually contradicts the trend seen with poverty rates. The increase
in the coefficient in the fourth model is also concerning. This
indicates some sort of difference in the effects of percent professional
on mhv.growth in separate tracts.

It is also interesting to note that all the control variables selected
are significant.


### Citations

(https://watts-college.github.io/cpp-528-fall-2021/sched/week-04/)

(https://watts-college.github.io/cpp-528-fall-2021/labs/lab-04-tutorial.html)
