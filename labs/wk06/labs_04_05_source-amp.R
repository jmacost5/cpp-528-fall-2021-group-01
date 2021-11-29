#
# Author:   April Peck
# Date:     November 18, 2021
# Purpose:  Store relevant lab 05 objects in this source file
#

# load necessary packages ----
`%>%` <- magrittr::`%>%`


# load necessary constants ----
# inflation rate
INFLATION_RATE <- 1.28855 


# set randomization seed ----
set.seed( 1234 )

# set stargazer type
s.type = "html"

# Load the necessary data

# load necessary data ----

# remember to use here::here() when importing data
d1 <- readRDS( here::here( "data/rodeo/LTDB-2000.rds" ) )
d2 <- readRDS( here::here( "data/rodeo/LTDB-2010.rds" ) )
md <- readRDS( here::here( "data/rodeo/LTDB-META-DATA.rds" ) )

# obtain NMTC data
NMTC_URL <- "https://raw.githubusercontent.com/DS4PS/cpp-528-spr-2020/master/labs/data/raw/NMTC/nmtc-sheet-01.csv"
nmtc <- read.csv( NMTC_URL, stringsAsFactors=F )

# obtain LIHTC data
LIHTC_URL <- "https://raw.githubusercontent.com/DS4PS/cpp-528-spr-2020/master/labs/data/raw/LIHTC/LIHTCPUB.csv"
lihtc <- read.csv( LIHTC_URL, stringsAsFactors=F )


# create dataset for Lab 4

d1 <- dplyr::select( d1, - year )
d2 <- dplyr::select( d2, - year )

d <- merge( d1, d2, by="tractid" )
d <- merge( d, md, by="tractid" )

# keep only the urban tracts
d <- dplyr::filter( d, urban == "urban" )



### Lab 4 data

# adjust 2000 home values for inflation 
mhv.00 <- d$mhmval00 * INFLATION_RATE  
mhv.10 <- d$mhmval12

# change in MHV in dollars
mhv.change <- mhv.10 - mhv.00


# change in MHV in percent
mhv.growth <- 100 * ( mhv.change / mhv.00 )

# drop low year 2000 median home values
# to avoid unrealistic growth rates.
#
# tracts with homes that cost less than
# $10,000 are outliers
# approximately 200 out of 59,000 cases 
mhv.00[ mhv.00 < 10000 ] <- NA


# Omit cases with growth rates above 200%.
mhv.growth[ mhv.growth > 2 ] <- NA

# add variables to the main data frame ----
d$mhv.00 <- mhv.00
d$mhv.10 <- mhv.10
d$mhv.change <- mhv.change
d$mhv.growth <- mhv.growth 




#save copy of full df
d.full <- d

# select a few variables ----
d <- dplyr::select( d.full, 
                    
                    tractid, cbsa, cbsaname,            # ids / units of analysis
                    
                    mhv.00, mhv.10, mhv.change, mhv.growth,    # home value 
                    
                    hs00, hs12,  col00, col12, ag25up00, ag25up12, h30old00,                # education
                    
                    unemp00, unemp12, clf00, clf12,  prof00, empclf00,          # employment
                    
                    vac00, vac10, hu00, hu10, own00,  rent00,                  # housing
                    
                    mhmval12, mhmval00,                   #median home values (for mutate)
                    
                    npov00, npov12, dpov00, dpov12, hinc00, hinc12,        # income/poverty
                    
                    pop00.x, pop10,  nhwht00, nhwht10  # population/race
                    
) # end select

# add control variables
d <- 
  d %>%
  dplyr::mutate( p.hs.00 = 100 * (hs00+col00) / ag25up00,
                 p.hs.12 = 100 * (hs12 + col12) / ag25up12,
                 p.unemp.00 = 100 * unemp00 / clf00,
                 p.unemp.12 = 100 * unemp12 / clf12,
                 p.vacant.00 = 100 * vac00 / hu00,
                 p.vacant.10 = 100 * vac10 / hu10,
                 p.white.00 = 100 * nhwht00 / pop00.x,
                 p.white.10 = 100 * nhwht10 / pop10,
                 mhv.change.00.to.10 = mhmval12 - mhmval00,
                 p.mhv.change = 100 * (mhmval12 - mhmval00) / mhmval00,
                 pov.rate.00 = 100 * npov00 / dpov00,
                 pov.rate.12 = 100 * npov12 / dpov12)


# store mini data frame to be used for descriptive statistics ----
df <- data.frame( MedianHomeValue2000=mhv.00, 
                  MedianHomeValue2010=mhv.10, 
                  MHV.Change.00.to.10=mhv.change,
                  MHV.Growth.00.to.12=mhv.growth )


# average growth in median home value for the city
cbsa_stats_df <- 
  d %>%
  dplyr::group_by( cbsaname ) %>%
  dplyr::summarize( metro.mhv.change = median( mhv.change, na.rm=T ),
                    metro.mhv.growth = 100 * median( mhv.growth, na.rm=T ) ) %>%
  dplyr::ungroup() 


#### End of lab 4 steps


### Lab 5 data

d.lab05 <- d.full

# Create the Difference In Difference dataset


# create a key that will allow us to obtain federal data for each tract ----
# remove anything not a number from the string
d.lab05$id2 <- gsub( "[^0-9]", "", d.lab05$tractid )

# fix IDs so they are match
d.lab05$id2 <- as.numeric( d.lab05$id2 )

# aggregate federal programs such that there is one record per tract ----
lihtc.dollars <-
  lihtc %>% 
  dplyr::filter( yr_alloc >= 2000 & yr_alloc <= 2010 ) %>%
  dplyr::group_by( fips2010 ) %>%
  dplyr::summarize( num.lihtc = dplyr::n(), lihtc.total = sum( allocamt, na.rm=T ) )

# remove dollar sign and commas
nmtc$amount <- gsub( "[,$]", "", nmtc$QLICI.Amount ) %>%
  as.numeric( nmtc$amount ) %>% round(0)

nmtc.dollars <- 
  nmtc %>% 
  dplyr::filter( Origination.Year >= 2000 & Origination.Year <= 2010 ) %>%
  dplyr::group_by( X2010.Census.Tract ) %>% 
  dplyr::summarize( num.nmtc = dplyr::n(), nmtc.total = sum( amount, na.rm=T ) )

# merge federal data onto census tracts ----
d.lab05 <- merge( d.lab05, nmtc.dollars, by.x="id2", by.y="X2010.Census.Tract", all.x=T )
d.lab05 <- merge( d.lab05, lihtc.dollars, by.x="id2", by.y="fips2010", all.x=T )


# recode tracts that had no grants from NA to 0 ---
d.lab05$num.nmtc[ is.na(d.lab05$num.nmtc) ] <- 0
d.lab05$nmtc.total[ is.na(d.lab05$nmtc.total) ] <- 0

d.lab05$num.lihtc[ is.na(d.lab05$num.lihtc) ] <- 0 
d.lab05$lihtc.total[ is.na(d.lab05$lihtc.total) ] <- 0

# adjust 2000 home values for inflation 
mhv.00 <- d.lab05$mhmval00 * INFLATION_RATE  
mhv.10 <- d.lab05$mhmval12

# change in MHV in dollars
mhv.change <- mhv.10 - mhv.00

# drop low year 2000 median home values
# to avoid unrealistic growth rates.
#
# tracts with homes that cost less than
# $10,000 are outliers
# approximately 200 out of 59,000 cases 
mhv.00[ mhv.00 < 10000 ] <- NA

# change in MHV in percent
mhv.growth <- 100 * ( mhv.change / mhv.00 )

# store mini data frame to be used for descriptive statistics ----
df <- data.frame( MedianHomeValue2000=mhv.00, 
                  MedianHomeValue2010=mhv.10, 
                  MHV.Change.00.to.10=mhv.change,
                  MHV.Growth.00.to.12=mhv.growth )

# add variables to the main data frame ----
d.lab05$mhv.00 <- mhv.00
d.lab05$mhv.10 <- mhv.10
d.lab05$mhv.change <- mhv.change
d.lab05$mhv.growth <- mhv.growth 

# save copy of full d.lab05
d.lab05.full <- d.lab05

# select a few variables ----
d.lab05 <- dplyr::select( d.lab05.full, 
                    
                    tractid, cbsa, cbsaname,            # ids / units of analysis
                    
                    mhv.00, mhv.10, mhv.change, mhv.growth,    # home value 
                    
                    hs00, hs12,  col00, col12, ag25up00, ag25up12,                # education
                    
                    unemp00, unemp12, clf00, clf12,            # employment
                    
                    vac00, vac10, hu00, hu10,                     # housing vacancies
                    
                    mhmval12, mhmval00,                   #median home values (for mutate)
                    
                    npov00, npov12, dpov00, dpov12, hinc00, hinc12,        # income/poverty
                    
                    pop00.x, pop10,  nhwht00, nhwht10,  # population/race
                    
                    num.nmtc, nmtc.total,              # tax policy data
                    num.lihtc, lihtc.total             # aggregated by census tract
                    
) # end select

# add control variables
d.lab05 <- 
  d.lab05 %>%
  dplyr::mutate( p.hs.00 = 100 * (hs00+col00) / ag25up00,
                 p.hs.12 = 100 * (hs12 + col12) / ag25up12,
                 p.unemp.00 = 100 * unemp00 / clf00,
                 p.unemp.12 = 100 * unemp12 / clf12,
                 p.vacant.00 = 100 * vac00 / hu00,
                 p.vacant.10 = 100 * vac10 / hu10,
                 p.white.00 = 100 * nhwht00 / pop00.x,
                 p.white.10 = 100 * nhwht10 / pop10,
                 mhv.change.00.to.10 = mhmval12 - mhmval00,
                 p.mhv.change = 100 * (mhmval12 - mhmval00) / mhmval00,
                 pov.rate.00 = 100 * npov00 / dpov00,
                 pov.rate.12 = 100 * npov12 / dpov12) %>%
  # remove any NA or Inf values
  na.omit(use = "everything")

# create new variables by cbsa ----
d.lab05 <-
  d.lab05 %>%
  dplyr::group_by( cbsaname ) %>%
  dplyr::mutate( # metro rank of home value in 2000
    metro.mhv.pct.00 = dplyr::ntile( mhv.00, 100 ),
    # metro rank of home value in 2010
    metro.mhv.pct.10 = dplyr::ntile( mhv.10, 100 ),
    # median pay for metro area 2000
    metro.median.pay.00 = median( hinc00, na.rm=T ),
    # median pay for metro area 2010
    metro.median.pay.10 = median( hinc12, na.rm=T ),
    # tract rank in metro area for diversity (% non-white) 2000
    metro.diversity.rank.00 = dplyr::ntile( (100-p.white.00), 100 ),
    # tract rank in metro area for diversity (% non-white) 2010
    metro.diversity.rank.10 = dplyr::ntile( (100-p.white.10), 100 ),
    # metro total population 2000
    metro.pop.total.00 = sum( pop00.x, na.rm=T ),
    # metro total population 2010
    metro.pop.total.10 = sum( pop10, na.rm=T ) ) %>%
  dplyr::ungroup() %>%
  dplyr::mutate( # change in relative rank of mhv in metro area 2000-2010
    metro.mhv.pctile.change = metro.mhv.pct.10 - metro.mhv.pct.00,
    # growth in ave pay in metro
    metro.pay.change = metro.median.pay.10 - metro.median.pay.00,
    # metro population growth 2000-2010
    metro.pop.growth = ( metro.pop.total.10 - metro.pop.total.00 ) / metro.pop.total.00,
    # increase in the proportion of whites in tract 
    increase.p.white = p.white.10 - p.white.00  )


# inflation adjust income  ----
d.lab05$hinc00 <- INFLATION_RATE * d.lab05$hinc00

# Create a true/false code for recipient tracts ----
d.lab05$LIHTC <- ifelse( d.lab05$num.lihtc > 0, "YES", "NO" )
d.lab05$NMTC <- ifelse( d.lab05$num.nmtc > 0, "YES", "NO" )

# create a growth column within the data frame ----
# omit cases with growth rates above 200%
d.lab05$growth <- d.lab05$mhv.growth
d.lab05$growth[ d.lab05$growth > 200 ] <- NA

# store plots in a list for easy access ----
PLOTS <-
  list(
    "pov_rate_2000" = list(
      "nmtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=pov.rate.00, fill=NMTC )) +
        ggplot2::geom_density(alpha=0.4) + 
        ggplot2::ggtitle("2000 Poverty Rate Comparison of \nRecipient and Non-Recipient Communities"),
      "lihtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=pov.rate.00, fill=LIHTC)) +
        ggplot2::geom_density(alpha=0.4) +
        ggplot2::ggtitle("2000 Poverty Rate Comparison of \nRecipient and Non-Recipient Communities")
    ),
    "mhv_2000" = list(
      "nmtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=log10(mhv.00), fill=NMTC )) +
        ggplot2::geom_density( alpha=0.4 ) +
        ggplot2::ggtitle("2000 Median Home Value Comparison of \nRecipient and Non-Recipient Communities"),
      "lihtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=log10(mhv.00), fill=LIHTC )) +
        ggplot2::geom_density( alpha=0.4 )  +
        ggplot2::ggtitle("2000 Median Home Value Comparison of \nRecipient and Non-Recipient Communities")
    ),
    "mhv_growth" = list(
      "nmtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=growth, fill=NMTC )) +
        ggplot2::geom_density( alpha=0.4 )  +
        ggplot2::ggtitle("Comparision of MHV Growth 2000 to 2010: \nRecipients vs Non-Recipients"),
      "lihtc" = ggplot2::ggplot( d.lab05, ggplot2::aes(x=growth, fill=LIHTC )) +
        ggplot2::geom_density( alpha=0.4 )  +
        ggplot2::ggtitle("Comparision of MHV Growth 2000 to 2010: \nRecipients vs Non-Recipients")
    )
  )

# prepare NMTC data
# log the variables
y1 <- log( d.lab05$mhv.00 )
y2 <- log( d.lab05$mhv.10 )
lp.vac.00 <- log10( d.lab05$p.vacant.00 + 1)
lp.vac.10 <- log10( d.lab05$p.vacant.10 + 1)
lp.hs.00 <- log10( d.lab05$p.hs.00 + 1)
lp.hs.12 <- log10( d.lab05$p.hs.12 + 1)
lp.unemp.00 <- log10( d.lab05$p.unemp.00 + 1)
lp.unemp.12 <- log10( d.lab05$p.unemp.12 + 1)

# create a variable that identifies if a tract received NMTC funding
nmtc.treat <- as.numeric( d.lab05$num.nmtc > 0 )

# store the year 2000 data
d1 <- data.frame( y=y1, treat=nmtc.treat, post=0 )
# store the year 2010 data
d2 <- data.frame( y=y2, treat=nmtc.treat, post=1 )

# stack the two time periods together
d3 <- rbind( d1, d2 )

# controls ---

#p.vac
d0 <- data.frame( lp.vac.00 = lp.vac.00, lp.vac.10 = lp.vac.10)

d0 <- d0 %>% tidyr::gather(key = "variable_name",
                           value = "p.vac")

# diff-in-diff data
d3$p.vac <- d0$p.vac


#p.hs
d0 <- data.frame( lp.hs.00 = lp.hs.00, lp.hs.12 = lp.hs.12)
d0 <- d0 %>% tidyr::gather(key = "variable-name", value = "p.hs")

# diff-in-diff data
d3$p.hs <- d0$p.hs


#p.unemp
d0 <- data.frame( lp.unemp.00 = lp.unemp.00, lp.unemp.12 = lp.unemp.12)
d0 <- d0 %>% tidyr::gather(key = "variable-name", value = "p.unemp")

# diff-in-diff data
d3$p.unemp <- d0$p.unemp

# prepare LIHTC data
# create a variable that identifies if a tract received LIHTC funding
lihtc.treat <- as.numeric( d.lab05$num.lihtc > 0 )

# store the year 2000 data
l1 <- data.frame( y=y1, treat=lihtc.treat, post=0 )
# store the year 2010 data
l2 <- data.frame( y=y2, treat=lihtc.treat, post=1 )

# stack the two time periods together
l3 <- rbind( l1, l2 )

# controls ---

#p.vac
l0 <- data.frame( lp.vac.00 = lp.vac.00, lp.vac.10 = lp.vac.10)

l0 <- l0 %>% tidyr::gather(key = "variable_name",
                           value = "p.vac")

# diff-in-diff data
l3$p.vac <- l0$p.vac


#p.hs
l0 <- data.frame( lp.hs.00 = lp.hs.00, lp.hs.12 = lp.hs.12)

l0 <- l0 %>% tidyr::gather(key = "variable_name",
                           value = "p.hs")

# diff-in-diff data
l3$p.hs <- l0$p.hs


#p.unemp
l0 <- data.frame( lp.unemp.00 = lp.unemp.00, lp.unemp.12 = lp.unemp.12)

l0 <- l0 %>% tidyr::gather(key = "variable_name",
                           value = "p.unemp")

# diff-in-diff data
l3$p.unemp <- l0$p.unemp

#### End of Lab 5 steps


#### Custom Functions
panel.cor <- function(x, y, digits=2, prefix="", cex.cor)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- abs(cor(x, y))
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste(prefix, txt, sep="")
  if(missing(cex.cor)) cex <- 0.8/strwidth(txt)
  
  test <- cor.test(x,y)
  # borrowed from printCoefmat
  Signif <- symnum(test$p.value, corr = FALSE, na = FALSE,
                   cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                   symbols = c("***", "**", "*", ".", " "))
  
  text(0.5, 0.5, txt, cex = 1.5 )
  text(.7, .8, Signif, cex=cex, col=2)
}


panel.smooth <- function (x, y, col = par("col"), bg = NA, pch = par("pch"), 
                          cex = 0.5, col.smooth = "red", span = 2/3, iter = 3, ...) 
{
  points(x, y, pch = 19, col = gray(0.7,0.2), bg = bg, cex = cex)
  ok <- is.finite(x) & is.finite(y)
  if (any(ok)) 
    lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), 
          col = col.smooth, lwd=2, ...)
}


# custom plot
jplot <- function( x1, x2, lab1="", lab2="", draw.line=T, ... )
{
  
  plot( x1, x2,
        pch=19, 
        col=gray(0.6, alpha = 0.2), 
        cex=0.5,  
        bty = "n",
        xlab=lab1, 
        ylab=lab2, cex.lab=1.5,
        ... )
  
  if( draw.line==T ){ 
    ok <- is.finite(x1) & is.finite(x2)
    lines( lowess(x2[ok]~x1[ok]), col="red", lwd=3 ) }
  
}





