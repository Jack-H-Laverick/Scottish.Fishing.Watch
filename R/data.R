#' Polygons of Scottish Marine Regions
#'
#' A Simple Feature object containg polygons of Scottish Marine Zones clipped to the UK Exclsive Economic Zone. The code to 
#' generate this object can be found in the data-raw folder of the github repository.
#'
#'This object is used within `get_cropped_fishing` to crop Global Fishing Watch data to Scottish waters. GFW pixels are labelled
#'with the names of Scottish Marine Zones as a by-product.
#'
#' @format A Simple Feature object including name and shore zone of regions:
#' \describe{
#'   \item{Name}{The name of the Scottish Marine Zone within the UK Exclusive Economic Zone}
#'   \item{Shore}{Whether the region is in the inshore or offshore zone of the EEZ}
#'   ...
#' }
#' @source \url{http://www.marineregions.org/downloads.php}
#' \url{#http://marine.gov.scot/information/scottish-assessment-areas-scottish-marine-regions-and-offshore-marine-regions-scottish}
"Scot_EEZ"