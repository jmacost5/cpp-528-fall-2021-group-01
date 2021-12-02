---
title: This is an example page
subtitle: "The title above can be anything you want. However, the file name must be in this specific format: `YYYY-MM-DD-chXX-short_name.md`."
---

## Today’s Date

Today’s date is March 14, 2021.

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax
for authoring HTML, PDF, and MS Word documents. For more details on
using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that
includes both content as well as the output of any embedded R code
chunks within the document. You can embed an R code chunk like this:

``` r
summary(cars)
```

    ##      speed           dist       
    ##  Min.   : 4.0   Min.   :  2.00  
    ##  1st Qu.:12.0   1st Qu.: 26.00  
    ##  Median :15.0   Median : 36.00  
    ##  Mean   :15.4   Mean   : 42.98  
    ##  3rd Qu.:19.0   3rd Qu.: 56.00  
    ##  Max.   :25.0   Max.   :120.00

## Including Plots

You can also embed plots, for example:

![](../assets/img/2021-03-14-ch01-example_page_files/figure-gfm/pressure-1.png)<!-- -->

![](../assets/img/2021-03-14-ch01-example_page_files/figure-gfm/airquality-1.png)<!-- -->

Note that the `echo = FALSE` parameter was added to the code chunk to
prevent printing of the R code that generated the plot.

## Including regression output

``` r
# load necessary packages ----
library(stargazer)

# load constants ----
STARGAZER_OUTPUT_TYPE = "html"

# create model ----
first_lm <- lm(Ozone ~ Wind, data = datasets::airquality)

# display model
stargazer::stargazer(
  first_lm,
  type = STARGAZER_OUTPUT_TYPE,
  title = "Table 1. Linear regression using airquality dataset to predict Ozone values using Wind values."
)
```

<table style="text-align:center">

<caption>

<strong>Table 1. Linear regression using airquality dataset to predict
Ozone values using Wind values.</strong>

</caption>

<tr>

<td colspan="2" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

<em>Dependent variable:</em>

</td>

</tr>

<tr>

<td>

</td>

<td colspan="1" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

Ozone

</td>

</tr>

<tr>

<td colspan="2" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Wind

</td>

<td>

\-5.551<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.690)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

</tr>

<tr>

<td style="text-align:left">

Constant

</td>

<td>

96.873<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(7.239)

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

</td>

</tr>

<tr>

<td colspan="2" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

Observations

</td>

<td>

116

</td>

</tr>

<tr>

<td style="text-align:left">

R<sup>2</sup>

</td>

<td>

0.362

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.356

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

26.467 (df = 114)

</td>

</tr>

<tr>

<td style="text-align:left">

F Statistic

</td>

<td>

64.644<sup>\*\*\*</sup> (df = 1; 114)

</td>

</tr>

<tr>

<td colspan="2" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

<em>Note:</em>

</td>

<td style="text-align:right">

<sup>*</sup>p\<0.1; <sup>**</sup>p\<0.05; <sup>***</sup>p\<0.01

</td>

</tr>

</table>
