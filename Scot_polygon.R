
library(sf)
library(tidyverse)

eezs <- read_sf('C:/Users/jackl/Desktop/World_EEZ_v11_20191118', layer = 'eez_v11') %>% 
  filter(POL_TYPE %in% c('200NM', '200 NM'),
         TERRITORY1 == "United Kingdom") # select the 200 nautical mile polygon layer

head(eezs)

plot(eezs)




#### Scot zones

#https://spatialdata.gov.scot/geonetwork/srv/eng/catalog.search#/metadata/Marine_Scotland_FishDAC_12185
#http://marine.gov.scot/information/scottish-assessment-areas-scottish-marine-regions-and-offshore-marine-regions-scottish

scot <- read_sf('C:/Users/jackl/Desktop/scotland')# %>% 
  filter(POL_TYPE %in% c('200NM', '200 NM'),
         TERRITORY1 == "United Kingdom") # select the 200 nautical mile polygon layer

head(scot)

plot(scot)
