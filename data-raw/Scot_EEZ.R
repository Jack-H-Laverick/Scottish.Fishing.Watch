
library(sf)
library(tidyverse)

#### Get UK EEZ shape file ####

# Downloaded World EEZs from: http://www.marineregions.org/downloads.php

eezs <- read_sf('./data-raw/World_EEZ_v11_20191118', layer = 'eez_v11') %>%  # Read in global EEZs 
  filter(POL_TYPE %in% c('200NM', '200 NM'),                                 # Limit to 200 nautical mile polygons
         TERRITORY1 == "United Kingdom")                                     # Limit to UK

plot(eezs[,"TERRITORY1"])                                                    # Visual check

#### Scottish marine zones ####

# Downloaded from the following links
#https://spatialdata.gov.scot/geonetwork/srv/eng/catalog.search#/metadata/Marine_Scotland_FishDAC_12185
#http://marine.gov.scot/information/scottish-assessment-areas-scottish-marine-regions-and-offshore-marine-regions-scottish

scot <- read_sf('./data-raw/scotland')

plot(scot[,"name"])                                                          # Visual check

#### Crop marine zones ####

# The scottish marine zones extend to the continental shelf, so we need to cut these back to the UK EEZ

Scot_EEZ <- st_intersection(st_transform(scot, crs = 4326),                  # Cut Scotland
                            st_transform(eezs, crs = 4326)) %>%              # To EEZ wjile ensuring the same crs
  mutate(Name = name, Shore = if_else(is.na(instancecd), "Offshore", "Inshore")) %>% # Recode instancecd to an inshore and offshore zone
  select(Region, Shore)                                                      # Keep only interesting columns
  
plot(Scot_EEZ[,"Shore"])                                                     # Visual check

usethis::use_data(Scot_EEZ)                                                  # Add data object to the package
