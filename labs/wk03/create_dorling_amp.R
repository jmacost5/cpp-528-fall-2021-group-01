library(here)
library( sp )
library ( sf )
library ( dplyr )
library ( tidycensus )

# load data
crosswalk <- read.csv( "https://raw.githubusercontent.com/DS4PS/cpp-529-master/master/data/cbsatocountycrosswalk.csv",  stringsAsFactors=F, colClasses="character" )

# search for cities names by strings, use the ^ anchor for "begins with" 

grep( "^SAN FRAN", crosswalk$msaname, value=TRUE ) 
these.sf <- crosswalk$msaname == "SAN FRANCISCO, CA"   # Find San Francisco (T/F)
these.fips <- crosswalk$fipscounty[ these.sf ]         # Find SF counties
these.fips <- na.omit( these.fips )

state.fips <- substr( these.fips, 1, 2 )                    # Substring state code
county.fips <- substr( these.fips, 3, 5 )                   # substring county codes

sf.pop <-
  get_acs( geography = "tract", variables = "B01003_001",
           state = "06", county = county.fips[state.fips=="06"], geometry = TRUE ) %>% 
  select( GEOID, estimate ) %>%
  rename( POP=estimate )
#sanfran.pop$GEOID<-substr(sanfran.pop$GEOID,2,length(sf.pop$GEOID)) # remove leading 0's

census.dat <- readRDS(here("data/rodeo/ltdb-2010.rds"))

# convert tractid to geoid
census.dat$geoid <- gsub( "-", "", census.dat$tractid)    # remove dashes
census.dat$geoid <- substr( census.dat$geoid, 5, 16 )


# merge with census data
sf <- merge(sf.pop, census.dat, by.x = "GEOID", by.y = "geoid")
sf <- sf[ ! st_is_empty( sf ) , ]

# convert sf map object to an sp version
sf.sp <- as_Spatial( sf )

plot(sf.sp)

# project map and remove empty tracts
sf.sp <- spTransform( sf.sp, CRS("+init=epsg:3395"))
sf.sp <- sf.sp[ sf.sp$POP != 0 & (! is.na( sf.sp$POP )) , ]

# convert census tract polygons to dorling cartogram
# no idea why k=0.03 works, but it does - default is k=5
sf.sp$pop.w <- sf.sp$POP / 9000 # max(sf.sp$POP)   # standardizes it to max of 1.5
sf_dorling <- cartogram_dorling( x=sf.sp, weight="pop.w", k=0.05 )
plot( sf_dorling )

sf_dorling <- spTransform( sf_dorling, CRS("+proj=longlat +datum=WGS84") )
geojson_write( sf_dorling, file="sf_dorling.geojson", geometry="polygon" )
