---
title: Evaluation of Tax Credits
subtitle: "Evaluation of New Market Tax Credit and Low Income Housing Tax Credit programs."
---

The following data and packages were loaded for the following analysis:

``` r
library(pander)
library(stargazer)
library(here)
library(dplyr)
library(tidycensus)
library(magrittr)
library(scales)
import::here("%>%",
             "S_TYPE",
             "d.lab05",
             "df",
             "d3",
             "l3",
             "PLOTS",
             # notice the use of here::here() that points to the .R file
             # where all these R objects are created
             .from = here::here("analysis/utilities_master.R"),
             .character_only = TRUE)
d <- d.lab05
```

# Overview of Programs

#### About the New Market Tax Credits Program

The NMTC Program enables economically distressed communities to leverage
private investment capital by providing investors with a federal tax
credit. All NMTC investments must meet statutory qualifications for
their investors to be able to claim the tax credit. The vast majority of
NMTC investments are made within statutorily defined “Low-Income
Communities.” Low-Income Communities are census tracts with a poverty
rate of 20 percent or greater, or a median family income at or below 80
percent of the applicable area median family income. In addition to
investments located in Low-Income Communities, investments can qualify
for NMTCs by using other statutory provisions designed to target certain
areas or populations, including provisions for Rural Counties, and
Low-Income Targeted Populations.

Through the first 15 application rounds of the NMTC Program, the CDFI
Fund has made 1,178 awards, allocating a total of $57.5 billion in tax
credit authority to CDEs through a competitive application process.

[Data download
website](https://github.com/DS4PS/cpp-528-spr-2020/blob/master/labs/data/raw/NMTC/nmtc-sheet-01.csv)

[Source](https://watts-college.github.io/cpp-528-fall-2021/labs/lab-05-tutorial.html)

[Additional
Information](https://www.cdfifund.gov/programs-training/programs/new-markets-tax-credit)

[NMTC Press
Release](https://github.com/DS4PS/cpp-528-spr-2020/blob/master/labs/data/raw/NMTC/2019%20NMTC%20Public%20Data%20Release_FY_17-comments%20incorporated_BL%20Edits%20incorporated_Final.pdf)

#### About the Low Income Housing Tax Credits Program

The Low-Income Housing Tax Credit (LIHTC) is the most important resource
for creating affordable housing in the United States today. The LIHTC
database, created by HUD and available to the public since 1997,
contains information on 47,511 projects and 3.13 million housing units
placed in service between 1987 and 2017.

According to the [National Housing Law
Project](https://www.nhlp.org/resources/how-the-lihtc-program-works/),
the program provides tax credits to developers based on an application
process and goals laid out in the qualified action plan. Developers
agree to rent the units at below-market rates.

The LIHTC program is not tied to specific census tracts. Rather,
developers are required to make a certain number of units available to
qualified households (lower income than the metro average) at
below-market costs. If they comply with program requirements they
receive tax credits that cover a large proportion of the initial
renovation or construction costs, and the developers can revert rents to
market rates after 15 or 30 years. So if they stick with the program a
large proportion of their real-estate investment gets paid for by
offering reduced rents for a couple of decades, then they hold a
valuable asset at the end of the program.

Although there are no strict guidelines about where the projects are
built, by design they create higher opportunity costs in wealthier
neighborhoods. The annual rent total is capped at 30% of the average
income of the community (cite). Say this is $1,500 a month. If a
landlord could rent an apartment for $2,000 at a market rate in a middle
income neighborhood, they are losing $500 a month. If they could rent a
similar apartment for $3,000 in a high-income neighborhood, they are now
losing $1,500 a month. As a result of the structure of these incentives
and the opportunity costs of each scenario, developers are better off
building the affordable housing project in a low or middle-income
communities.

From:
<https://www.novoco.com/resource-centers/affordable-housing-tax-credits/lihtc-basics/about-lihtc>

[Data download
website](https://github.com/DS4PS/cpp-528-spr-2020/blob/master/labs/data/raw/LIHTC/LIHTCPUB.csv)

[Source](https://watts-college.github.io/cpp-528-fall-2021/labs/lab-05-tutorial.html)

[Additional
Information](https://www.nhlp.org/resource-center/low-income-housing-tax-credits/)

*Broad economic principles influence where financed affordable housing
will be built. Tax credit housing is generally located where the land
costs are lower and the tax credit allowable rents are sufficient to
allow for market-rate rents. Economics generally make it more difficult
to build financed housing in major cities because land costs are higher
and low-income rents are substantially below market rate.*

So where NMTC place hard limits on the tracts that are eligible for
projects, LIHTC location choices are driven by market dynamics, but
affordable housing projects are more likely to end up in low-income
communities.

#### Recipient and Non-Recipient Tracts

Here is the hard part about evaluating economic development investments: they try to target the projects that have the greatest potential to
succeed, so by design you have sorted the sample. It’s similar to the
challenge of trying to decide if Harvard provides a better education
than a high-performing public university. Harvard has selected students
that have the highest grades, test scores, early-life achievements, and
privilege. Who can you compare this sample to? You have no similar
counterfactual\!

In this instance, NMTC projects target poor communities, so by design we
expect that program participants (tracts) and non-participants are
different.

The LIHTC program is different because affordable housing units can be
built anywhere, they just need to cap rents for residents. IN PRACTICE
they tend to go in poor communities because the capped rent will not be
that different from the rent they could have received, and the lower
rents help keep buildings are high occupancy rates. The government

We can look at some descriptive statistics from 2000 to determine if we
have an apples to oranges type of comparison:

``` r
gridExtra::grid.arrange( PLOTS$pov_rate_2000$nmtc, 
                         PLOTS$pov_rate_2000$lihtc, 
                         nrow = 1 )
```

![](../assets/img/021-11-14-ch04-evaluate_programs_files/figure-gfm/unnamed-chunk-2-1.png)<!-- -->

New Market Tax Credit recipients appear to be quite distinct, located in
poorer tracts. We see the LIHTC projects tend to favor tracts with
higher poverty than non-recipient tracts, but a large proportion of the
projects are still located in tracts with low to moderate levels of
poverty.

``` r
gridExtra::grid.arrange( PLOTS$mhv_2000$nmtc, 
                         PLOTS$mhv_2000$lihtc, 
                         nrow = 1 )
```

![](../assets/img/021-11-14-ch04-evaluate_programs_files/figure-gfm/unnamed-chunk-3-1.png)<!-- -->

# Evaluating Program Impact

Use the difference-in-difference framework introduced in the tutorial to
estimate the impact of each federal program: the NMTC and the LIHTC.

Use your baseline model predicting tract change from Lab 04 as the
starting point. Create a log-linear diff-in-diff model following these
steps and add your control variables from Lab 04

NMTC data was added to the dataset using the following code found in the
data manifest:

``` r
### NMTC
# log the variables
#y1 <- log( d$mhv.00 )
#y2 <- log( d$mhv.10 )
#lp.vac.00 <- log10( d$p.vacant.00 + 1)
#lp.vac.10 <- log10( d$p.vacant.10 + 1)
#lp.hs.00 <- log10( d$p.hs.00 + 1)
#p.hs.12 <- log10( d$p.hs.12 + 1)
#lp.unemp.00 <- log10( d$p.unemp.00 + 1)
#lp.unemp.12 <- log10( d$p.unemp.12 + 1)
# create a variable that identifies if a tract received NMTC funding
#nmtc.treat <- as.numeric( d$num.nmtc > 0 )
# store the year 2000 data
#d1 <- data.frame( y=y1, treat=nmtc.treat, post=0 )
# store the year 2010 data
#d2 <- data.frame( y=y2, treat=nmtc.treat, post=1 )
# stack the two time periods together
#d3 <- rbind( d1, d2 )
# controls ---
#p.vac
#d0 <- data.frame( lp.vac.00 = lp.vac.00, lp.vac.10 = lp.vac.10)
#d0 <- d0 %>% tidyr::gather(key = "variable_name",
#value = "p.vac")
# diff-in-diff data
#d3$p.vac <- d0$p.vac
#p.hs
#d0 <- data.frame( lp.hs.00 = lp.hs.00, lp.hs.12 = lp.hs.12)
#d0 <- d0 %>% tidyr::gather(key = "variable-name", value = "p.hs")
# diff-in-diff data
#d3$p.hs <- d0$p.hs
#p.unemp
#d0 <- data.frame( lp.unemp.00 = lp.unemp.00, lp.unemp.12 = lp.unemp.12)
#d0 <- d0 %>% tidyr::gather(key = "variable-name", value = "p.unemp")
# diff-in-diff data
#d3$p.unemp <- d0$p.unemp
#d3 <- d3 %>% na.omit(use = "everything")
```

LIHTC data was added to the dataset with the following code found in the
data manifest:

``` r
### LIHTC
# variables are already logged
#y1 <- log( d$mhv.00 )
#y2 <- log( d$mhv.10 )
#lp.vac.00 <- log10( d$p.vacant.00)
#lp.vac.10 <- log10( d$p.vacant.10)
#lp.hs.00 <- log10( d$p.hs.00)
#lp.hs.12 <- log10( d$p.hs.12)
#lp.unemp.00 <- log10( d$p.unemp.00)
#lp.unemp.12 <- log10( d$p.unemp.12)
# create a variable that identifies if a tract received LIHTC funding
#lihtc.treat <- as.numeric( d$num.lihtc > 0 )
# store the year 2000 data
#l1 <- data.frame( y=y1, treat=lihtc.treat, post=0 )
# store the year 2010 data
#l2 <- data.frame( y=y2, treat=lihtc.treat, post=1 )
# stack the two time periods together
#l3 <- rbind( l1, l2 )
# controls ---
#p.vac
#l0 <- data.frame( lp.vac.00 = lp.vac.00, lp.vac.10 = lp.vac.10)
#l0 <- l0 %>% tidyr::gather(key = "variable_name",
#value = "p.vac")
# diff-in-diff data
#l3$p.vac <- l0$p.vac
#p.hs
#l0 <- data.frame( lp.hs.00 = lp.hs.00, lp.hs.12 = lp.hs.12)
#l0 <- l0 %>% tidyr::gather(key = "variable_name",
#value = "p.hs")
# diff-in-diff data
#l3$p.hs <- l0$p.hs
#p.unemp
#l0 <- data.frame( lp.unemp.00 = lp.unemp.00, lp.unemp.12 = lp.unemp.12)
#l0 <- l0 %>% tidyr::gather(key = "variable_name",
#value = "p.unemp")
# diff-in-diff data
#l3$p.unemp <- l0$p.unemp
#l3 <- l3 %>% na.omit(use = "everything")
```

# Descriptive Statistics

Let’s take a look at the descriptive statistics for the data:

``` r
stargazer::stargazer( df, 
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

#### Change in MHV 2000-2010

If a home worth $10 million increased in value by $100k over ten years
it would not be that surprising. If a home worth $50k increased by $100k
over the same period that is a growth of 200% and is notable.

The change in value variable only reports absolute change, but does not
provide a sense of whether that is a big or small amount for the census
tract.

``` r
hist( d$mhv.change/1000, breaks=500, 
      xlim=c(-300,350), yaxt="n", xaxt="n",
      xlab="Thousand of US Dollars (adjusted to 2010)", cex.lab=1.5,
      ylab="", main="Change in Median Home Value 2000 to 2010",
      col="gray20", border="white" )
axis( side=1, at=seq( from=-100, to=500, by=100 ), 
      labels=paste0( "$", seq( from=-100, to=500, by=100 ), "k" ) )
        
mean.x <- mean( d$mhv.change/1000, na.rm=T )
abline( v=mean.x, col="darkorange", lwd=2, lty=2 )
text( x=250, y=1500, 
      labels=paste0( "Mean = ", dollar( round(1000*mean.x,0)) ), 
      col="darkorange", cex=1.4, pos=3 )
median.x <- median( d$mhv.change/1000, na.rm=T )
abline( v=median.x, col="dodgerblue", lwd=2, lty=2 )
text( x=250, y=2000, 
      labels=paste0( "Median = ", dollar( round(1000*median.x,0)) ), 
      col="dodgerblue", cex=1.4, pos=3 )
```

![](../assets/img/021-11-14-ch04-evaluate_programs_files/figure-gfm/unnamed-chunk-7-1.png)<!-- -->

#### Percent Change in MHV 2000 to 2010

The percent change variable provides some context for growth rates of
value in census tracts.

Plot the percent change variable:

``` r
pct.change <- d$mhv.change / d$mhv.00
hg <-
hist( pct.change, breaks=2000, 
      xlim=c(-1,2), yaxt="n", xaxt="n",
      xlab="", cex.main=1.5,
      ylab="", main="Growth in Home Value by Census Tract 2000 to 2010",
      col="gray40", border="white" )
axis( side=1, at=seq( from=-1, to=2, by=0.5 ), 
      labels=paste0( seq( from=-100, to=200, by=50 ), "%" ) )
ymax <- max( hg$count )
        
mean.x <- mean( pct.change, na.rm=T )
abline( v=mean.x, col="darkorange", lwd=2, lty=2 )
text( x=1, y=(0.5*ymax), 
      labels=paste0( "Mean = ", round(100*mean.x,0), "%"), 
      col="darkorange", cex=1.8, pos=4 )
median.x <- median( pct.change, na.rm=T )
abline( v=median.x, col="dodgerblue", lwd=2, lty=2 )
text( x=1, y=(0.6*ymax), 
      labels=paste0( "Median = ", round(100*median.x,0), "%"), 
      col="dodgerblue", cex=1.8, pos=4 )
```

![](../assets/img/021-11-14-ch04-evaluate_programs_files/figure-gfm/unnamed-chunk-8-1.png)<!-- -->

# Program Participation Criteria

Not all Census tracts are eligible for both programs. The New Market Tax
Credit program, in particular, is trying to attract private investment
in Census tracts that are considered high-risk because of their current
conditions. The tax credits support activities like real-estate
projects, small business loans, or building rehab that would
traditionally be too expensive or too risky without subsidies (in
theory).

The real challenging part about this sort of program is there are some
neighborhoods that community developers should not be working in because
the investments are not sustainable. You don’t want to incentivize those
sorts of investments because they tie up capital in projects that are
not sustainable, they raise hopes for the community then let them down,
and they waste government resources.

Alternatively, there are tracts that would have been lucrative
investments without the tax credits. If there are enough of these (maybe
the economy is going through a long period of expansion so investors
have extra capital that they need to invest), then all of the program
funds might be captured by projects that would have happened without the
nudge. The program is just padding the margins for developers, but not
catalyzing any new growth.

And then there are the goldilocks cases where the community is a pretty
good investment, but not lucrative enough to attract purely private
sector actors. The tax credits are just enough to offset some of the
risks, and projects will happen that would not have without the program.

If you are too narrow in the qualification criteria you could end up in
the first scenario (too many unsustainable investments in unstable
communities, thus low impact). If you are too broad you can end up in
the second secenario (tax credits supporting investments in stable
neighborhoods that would have attracted capital without the program).
The best case is a criteria that results in the most grants in the third
scenario - sustainable projects that would not have happened without the
tax credits.

The fact that private investors have a lot of capital in the projects
ensures that they are not simply taking free government money. The tax
credits are typically claimed after they spend the money in the
community, and thus are invested in projects that they need to be
successful to generate a profit. So some incentives are aligned.

The program participation criteria define which census tracts are
eligible, and will greatly shape where the program dollars (tax credits)
are allocated.

#### Recipient and Non-Recipient Tracts:

Here is the hard part about evaluating economic development investments: they try to target the projects that have the greatest potential to
succeed, so by design you have sorted the sample. It’s similar to the
challenge of trying to decide if Harvard provides a better education
than a high-performing public university. Harvard has selected students
that have the highest grades, test scores, early-life achievements, and
privilege. Who can you compare this sample to? You have no similar
counterfactual\!

In this instance, NMTC projects target poor communities, so by design we
expect that program participants (tracts) and non-participants are
different.

The LIHTC program is different because affordable housing units can be
built anywhere, they just need to cap rents for residents. IN PRACTICE
they tend to go in poor communities because the capped rent will not be
that different from the rent they could have received, and the lower
rents help keep buildings are high occupancy rates. The government

We can look at some descriptive statistics from 2000 to determine if we
have an apples to oranges type of comparison:

``` r
### POVERTY RATES
gridExtra::grid.arrange( PLOTS$pov_rate_2000$nmtc, 
                         PLOTS$pov_rate_2000$lihtc, 
                         nrow = 1 )
```

![](../assets/img/021-11-14-ch04-evaluate_programs_files/figure-gfm/unnamed-chunk-9-1.png)<!-- -->

New Market Tax Credit recipients appear to be quite distinct, located in
poorer tracts. We see the LIHTC projects tend to favor tracts with
higher poverty than non-recipient tracts, but a large proportion of the
projects are still located in tracts with low to moderate levels of
poverty.

``` r
### HOME VALUES
gridExtra::grid.arrange( PLOTS$mhv_2000$nmtc, 
                         PLOTS$mhv_2000$lihtc, 
                         nrow = 1 )
```

![](../assets/img/021-11-14-ch04-evaluate_programs_files/figure-gfm/unnamed-chunk-10-1.png)<!-- -->

#### Apples to Oranges:

When comparing recipient tracts to non-recipient tracts we can see very
clearly that they are different. The degree depends on the program, NMTC
seem to be very distinctive, and LIHTC still different but not as
pronounced.

Here are some more summary statistics comparing the two:

#### Household Income 2000:

``` r
### HOUSEHOLD INCOME COMPARISONIN 2000:
### PROGRAM RECIPIENTS VS NON-RECIPIENT TRACTS
# Tracts that received LIHTC
mean( d$hinc00[ d$num.lihtc > 0 ] )
```

\[1\] 47302.67

``` r
# Tracts that did not 
mean( d$hinc00[ d$num.lihtc == 0 ] )
```

\[1\] 63789.2

``` r
# Tracts that received NMTC
mean( d$hinc00[ d$num.nmtc > 0 ] )
```

\[1\] 35787.47

``` r
# Tracts that did not 
mean( d$hinc00[ d$num.nmtc == 0 ] )
```

\[1\] 62259.09

#### Home Value 2000:

``` r
### MEDIAN HOME VALUE COMPARISON IN 2000
# Tracts that received LIHTC
mean( d$mhv.00[ d$num.lihtc > 0 ], na.rm=T )
```

\[1\] 156532.2

``` r
# Tracts that did not 
mean( d$mhv.00[ d$num.lihtc == 0 ], na.rm=T )
```

\[1\] 192119.9

``` r
# Tracts that received NMTC
mean( d$mhv.00[ d$num.nmtc > 0 ], na.rm=T )
```

\[1\] 146669.4

``` r
# Tracts that did not 
mean( d$mhv.00[ d$num.nmtc == 0 ], na.rm=T )
```

\[1\] 188380.1

#### Poverty Rates 2000:

``` r
### POVERTY RATE COMPARISONS
# Tracts that received LIHTC
summary( d$pov.rate.00[ d$num.lihtc > 0 ] ) %>% pander()
```

| Min. | 1st Qu. | Median | Mean  | 3rd Qu. | Max.  |
| :--: | :-----: | :----: | :---: | :-----: | :---: |
|  0   |  7.977  | 15.87  | 19.34 |  28.55  | 88.21 |

``` r
# Tracts that did not 
summary( d$pov.rate.00[ d$num.lihtc == 0 ] ) %>% pander()
```

| Min. | 1st Qu. | Median | Mean | 3rd Qu. | Max. |
| :--: | :-----: | :----: | :--: | :-----: | :--: |
|  0   |  4.144  | 7.766  | 11.2 |  14.71  | 100  |

``` r
# Tracts that received NMTC
summary( d$pov.rate.00[ d$num.nmtc > 0 ] ) %>% pander()
```

| Min. | 1st Qu. | Median | Mean  | 3rd Qu. | Max.  |
| :--: | :-----: | :----: | :---: | :-----: | :---: |
|  0   |  17.74  | 26.11  | 27.29 |  34.9   | 93.17 |

``` r
# Tracts that did not 
summary( d$pov.rate.00[ d$num.nmtc == 0 ] ) %>% pander()
```

| Min. | 1st Qu. | Median | Mean  | 3rd Qu. | Max. |
| :--: | :-----: | :----: | :---: | :-----: | :--: |
|  0   |  4.335  | 8.217  | 11.89 |  15.77  | 100  |

And examining the DV of MHV growth rates to get a sense of the
distribution of the outcome prior to running regression models:

``` r
### MHV Growth Rates (DV in Model)
gridExtra::grid.arrange( PLOTS$mhv_growth$lihtc, 
                         PLOTS$mhv_growth$nmtc, 
                         nrow = 1 )
```

![](../assets/img/021-11-14-ch04-evaluate_programs_files/figure-gfm/unnamed-chunk-14-1.png)<!-- -->

LIHTC on the left is a little ambiguous because there is more density
for program participant tracts in the right tail (evidence of higher
growth for the treatment), but also some more density in the peak left
of the distribution for non-participant tracts. Visually it’s hard to
assess.

NMTC, on the other hand, look better off because of the large amount of
density in the right-hand tail.

We can confirm these with some descriptive statistics of home value
growth rates:

``` r
# Tracts that received LIHTC
summary( d$growth[ d$num.lihtc > 0 ] ) %>% pander()
```

|  Min.   | 1st Qu. | Median | Mean  | 3rd Qu. | Max.  | NA’s |
| :-----: | :-----: | :----: | :---: | :-----: | :---: | :--: |
| \-88.97 |  4.216  | 23.01  | 29.82 |  48.74  | 199.7 | 115  |

``` r
# Tracts that did not 
summary( d$growth[ d$num.lihtc == 0 ] ) %>% pander()
```

|  Min.   | 1st Qu. | Median | Mean  | 3rd Qu. | Max.  | NA’s |
| :-----: | :-----: | :----: | :---: | :-----: | :---: | :--: |
| \-96.89 |  5.96   | 25.15  | 29.31 |  48.68  | 199.6 | 386  |

``` r
# Tracts that received NMTC
summary( d$growth[ d$num.nmtc > 0 ] ) %>% pander()
```

|  Min.   | 1st Qu. | Median | Mean  | 3rd Qu. | Max.  | NA’s |
| :-----: | :-----: | :----: | :---: | :-----: | :---: | :--: |
| \-94.55 |  10.99  | 33.59  | 39.64 |  62.97  | 199.3 |  56  |

``` r
# Tracts that did not
summary( d$growth[ d$num.nmtc == 0 ] ) %>% pander()
```

|  Min.   | 1st Qu. | Median | Mean  | 3rd Qu. | Max.  | NA’s |
| :-----: | :-----: | :----: | :---: | :-----: | :---: | :--: |
| \-96.89 |  5.587  |  24.7  | 29.09 |  48.36  | 199.7 | 445  |

Home value growth rates for LIHTC program participant and
non-participant tracts are almost the same.

Home value growth rates for NMTC participants are significant higher
than non-participant tracts. These are **unconditional means** with no
real counterfactual, so we still need to create an evaluation framework.
But they offer some suggestive evidence.

# Report & Interpret

Report and interpret the main results from the models. Are the programs
effective at catalyzing neighborhood improvement? We are assuming median
home value captures the increased market demand that reflects the
desirability of improvements.

### NMTC

``` r
# create the difference in difference model
# note: treat = B1, post = B2, treat*post = B3
m <- lm( y ~ treat + post + p.vac + p.hs + p.unemp + treat*post, data=d3, na.rm = TRUE )
# display model results
stargazer::stargazer(m,
                     type = S_TYPE,
                     digits = 2)
```

<table style="text-align:center">

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

y

</td>

</tr>

<tr>

<td colspan="2" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

treat

</td>

<td>

0.03<sup>\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.01)

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

post

</td>

<td>

0.51<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.004)

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

p.vac

</td>

<td>

\-0.78<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.01)

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

p.hs

</td>

<td>

1.65<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.03)

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

p.unemp

</td>

<td>

\-0.76<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.01)

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

treat:post

</td>

<td>

\-0.003

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.02)

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

10.09<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.06)

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

118,120

</td>

</tr>

<tr>

<td style="text-align:left">

R<sup>2</sup>

</td>

<td>

0.28

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.28

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

0.55 (df = 118113)

</td>

</tr>

<tr>

<td style="text-align:left">

F Statistic

</td>

<td>

7,514.34<sup>\*\*\*</sup> (df = 6; 118113)

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

Houses, on average, had a 51% increase during the treatment period (2000 - 2010). Although the post-treatment coefficient is different than 1, it
is not statistically significant, indicating the NMTC program is not
effective.

### LIHTC

``` r
# create the difference in difference model
# note: treat = B1, post = B2, treat*post = B3
m <- lm( y ~ treat + post + p.vac + p.hs + p.unemp + treat*post, data=l3 )
# display model results
stargazer::stargazer(m,
                     type = S_TYPE,
                     digits = 2)
```

<table style="text-align:center">

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

y

</td>

</tr>

<tr>

<td colspan="2" style="border-bottom: 1px solid black">

</td>

</tr>

<tr>

<td style="text-align:left">

treat

</td>

<td>

\-0.05<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.01)

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

post

</td>

<td>

0.51<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.004)

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

p.vac

</td>

<td>

\-0.77<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.01)

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

p.hs

</td>

<td>

1.67<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.03)

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

p.unemp

</td>

<td>

\-0.74<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.01)

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

treat:post

</td>

<td>

\-0.03<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.01)

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

10.05<sup>\*\*\*</sup>

</td>

</tr>

<tr>

<td style="text-align:left">

</td>

<td>

(0.06)

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

118,120

</td>

</tr>

<tr>

<td style="text-align:left">

R<sup>2</sup>

</td>

<td>

0.28

</td>

</tr>

<tr>

<td style="text-align:left">

Adjusted R<sup>2</sup>

</td>

<td>

0.28

</td>

</tr>

<tr>

<td style="text-align:left">

Residual Std. Error

</td>

<td>

0.55 (df = 118113)

</td>

</tr>

<tr>

<td style="text-align:left">

F Statistic

</td>

<td>

7,562.27<sup>\*\*\*</sup> (df = 6; 118113)

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

With the LIHTC program, the post-treatment coefficient is statistically
significant, but housing values rose, on average, by .03% less than
houses in the control group.


## References

- Community Development Financial Institutions Fund, "New Markets Tax Credit (NMTC) Public Data Release", November 2019. Available from "https://github.com/DS4PS/cpp-528-spr-2020/blob/master/labs/data/raw/NMTC/2019%20NMTC%20Public%20Data%20Release_FY_17-comments%20incorporated_BL%20Edits%20incorporated_Final.pdf"

- Community Develoopment Financial Institutions Fund, "New Markets Tax Credit Program", 2021, available from https://www.cdfifund.gov/programs-training/programs/new-markets-tax-credit

- HUD User Datasets , "LOW-INCOME HOUSING TAX CREDIT (LIHTC)" , 2018 , Web. 15 November 2021. Available from "https://www.huduser.gov/portal/datasets/lihtc.html"

- National Housing Law Project, "How the LIGHTS program works", 7 September 2017. Available from "https://www.nhlp.org/resources/how-the-lihtc-program-works/"

- National Housing Law Project, "Low-income Housing Tax Credits", 2022. Available from "https://www.nhlp.org/resource-center/low-income-housing-tax-credits/" 

- Novocradac , "Affordable Housing Resource Center" , 1993 , Web. 16 November 2021, Available from "https://www.novoco.com/resource-centers/affordable-housing-tax-credits/lihtc-basics/about-lihtc"

- OFFICE OF POLICY DEVELOPMENT AND RESEARCH (PD&R), "Income limit information for LIHTC projects" , April 1, 2021  , Web. 15 November 2021. Available from "https://www.huduser.gov/portal/datasets/il.html#2021_faq"

- Watts-College , "Tutorial on Adding Federal Program Data" , October 29, 2021 , Web. 16 November 2021. Available from "https://watts-college.github.io/cpp-528-fall-2021/labs/lab-05-tutorial.html"
