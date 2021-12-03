# Lab 04 - Predicting MHV Change

## File Purpose

This lab was performed to create a baseline model of neighborhood change in median home value (MHV) growth. After some data cleaning, three census variables were chosen as controls to predict change in MHV between 2000 and 2010.

## Hedonic Housing Models
The dependent variable in our model is the median home value. The choice draws on a large body of work on “hedonic pricing models” which assert that home values are a good price mechanism to capture the state of a neighborhood because they “price in” all of the characteristics of the house as well as the features of the neighborhood and surrounding city.

Anyone who has ever paid $2,500 to rent a 400-square foot apartment in New York City know that when you acquire a dwelling you are paying for location as much as for the space to store your things and sleep at night. And location really means proximity to amenities, assurance of safety, and access to things like low taxes or high-performing schools.

Hedonic pricing models use home value as the dependent variable, typically include features of the house (lot size, square footage, year built, number of bedrooms and bathrooms, etc.) to establish a baseline prediction of the value of the home based upon the house itself. They then incorporate many additional attributes of the neighborhood to determine how people value things. Using this approach you can answer questions like, what is the value of having a park withing walking distance, i.e. what is the premium people will pay for homes that are near a park? What is the value of being in a good school district? What is the real-estate cost of proximity to a factory that produces toxic smoke? Does crime reduce the value of a home? Do new nearby bike lanes increase the value of homes?

We don’t have data on individual houses for this project, thus we can’t run formal hedonic models that account for the features of a home. Rather, we have a census estimate of the median home value in a census tract.

We also don’t have recent sales data that would tell us exactly how much people are paying for homes. Rather, the Census estimates the Median Home Value by asking people how much their homes are worth. There are definite limitations to this methodology (people who are attached to their homes might over-value them, people who don’t follow real estate might under-value them). But there is good work on “the wisdom of crowds” that shows that many independent guesses on topics like these, once aggregated, are pretty accurate.

This fact was established partly by watching people try to guess the weight of a pig at the state fair to win a prize. The typical person was not very good at the task and thus their estimate was off by several dozen pounds. But people that do not have experience guessing the weight of pigs will get close enough, and they are also equally as likely to guess too high as they are to guess to low. So if you take all of the guesses from the crowd and average them you typically come within a pound or two of the actual weight! See: Surowiecki, J. (2005). The wisdom of crowds.

## Census Documentation on Methodology
Value is the respondent’s estimate of how much the property (house and lot) would sell for if it were for sale.

This tabulation includes only specified owner-occupied housing units–one-family houses on less than 10 acres without a business or medical office on the property. These data exclude mobile homes, houses with a business or medical office, houses on 10 or more acres, and housing units in multi-unit structures. Certain tabulations elsewhere include the value of all owner-occupied housing units and vacant-for-sale housing units. Also available are data on mortgage status and selected monthly owner costs.

The median divides the value distribution into two equal parts: one-half of the cases falling below the median value of the property (house and lot) and one-half above the median. Median value calculations are rounded to the nearest hundred dollars.

Owner-Occupied - A housing unit is owner-occupied if the owner or co-owner lives in the unit, even if it is mortgaged or not fully paid for. The owner or co-owner must live in the unit and usually is Person 1 on the questionnaire. The unit is “Owned by you or someone in this household with a mortgage or loan” if it is being purchased with a mortgage or some other debt arrangement such as a deed of trust, trust deed, contract to purchase, land contract, or purchase agreement.

Note that a census tract could feasibly contain a large number of businesses or rental units and a small number of houses or condos owned by citizens. These cases are conceptually challenging because the tract-level MHV is determined by a handful of homes. You will see below that we drop cases from the data with MHV less than $10,000 in 2000 and high home values in 2010. These are likely cases where the tract was a dirt lot that turned into a new development, or they were lofts or apartments in dense business districts converted to condos. In a few instances there were large public housing projects that were torn down and replaced with mixed use developments. As a result, many of the large percentage changes we see like a one thousand percent increase in home value are likely caused by small-sample problems and are not necessarily meaningful measures of change. The percent change variable is especially sensitive to small-sample problems because as the denominator approaches zero the value blows up to infinity. If you see a growth rate of 150,000 percent, it likely means that the median home value measure in 2000 was close to zero, not that the tract has actually changed in any meaningful way suggested by that magnitude.

There are many ways to deal with outliers like these, but for now we will simply filter out values above and below thresholds that we feel are unrealistic and focus on the 95 percent of the data within these bounds. If there was time we would do an in-depth analysis of those data points to ensure we are not omitting meaningful cases.

## Interpretation of Change in MHV
Similar to the hedonic housing models, the major assumption that our analysis relies upon is increases in the median home value in a neighborhood (Census tract) suggest the community is improving. We want to be careful here, because even the worst neighborhood in superstar cities will see home values increase, but at a much slower rate than all other neighborhoods in the city. So “increase” needs to be contextualized.

When home values increase in a community, after controlling for metro-level “secular” market trends, the change suggests that the neighborhood is more desirable for citizens of the city. That can be driven by improvements in homes. Or it can be driven by improvements in amenities near the community such as new restaurants or light rail, quality of life through lower crime or better parks, or through gentrification processes that might displace disadvantaged populations that have lower income and savings and thus real estate markets were less competitive.

Median home value is going to capture all of these things, so at the very least it helps us measure change. Whether or not that change is a good thing depends on your perspective. People value good public transit, so they are willing to pay for proximity to light rail stations and metro stops. Even when a city can’t charge high rates for fares, property values increase as a result of new public infrastructure, and thus the city can recover some of the construction costs over time. These are largely synergistic changes that can incentivize cities to invest in transit.

Change diven by real estate speculation or by driving middle class families out of a neighborhood are still positive increases, but can be perceived as “bad” progress.

In short, we will pay attention to the nuances of gentrification, but generally speaking we will interpret an increase in home value being a signal that both the housing stock and the quality of the neighborhood have improved.

## File Organization

**Lab-04-McIntyre.Rmd**: an R Markdown file containing code to accomplish the File Purpose. Functions and datasets used in the code are located in an R file ("analysis/utilities_master.R") which is loaded using the import::here() function.

**Lab-04-McIntyre.html**: a knitted html file of the Rmd file. 

### References

- Monson, Matt, Cornell MBA and PRE . "Valuation Using Hedonic Pricing Models" , 2009,.Web. 7 November 2021. [PDF file]. Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/home-value-change/valuation-using-hedonic-pricing.pdf"

- "Hedonic Pricing Method" , 1/1/2015  , Web. 7 November 2021. [PDF file]. Available from "https://watts-college.github.io/cpp-528-fall-2021/articles/home-value-change/hedonic-pricing-method.pdf"


