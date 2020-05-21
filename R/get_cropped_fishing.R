#' Import Fishing Effort Within Scottish Waters
#'
#'This function reads a csv file, when given a full path, and discards pixels which are outside Scottish waters.
#'
#'For speed a rough crop is performed first, specified by `box`. Then a Simple Feature object containing polygons of Scottish Marine
#'Zones is used to perform a more expensive final crop. The SF object is hard coded into the function, but can be viewed by typing
#'`Scot_EEZ`. 
#'
#' @param file The full name to a .csv file containing Global Fishing Watch data.
#' @param box A 4 number vector of min and max longitude, min and max latitude in that order. Defaults are set to slightly larger than the bounding box of `Scot_EEZ`.
#' @return A dataframe of cells from a 0.01 degree grid which contains fishing activity.
#' @export
get_cropped_fishing <- function (file, box = c(-15, 3, 54, 64)) {

  Fish <- utils::read.csv(file, header = TRUE) %>%                           # Take first csv file as a test
    dplyr::mutate(Longitude = lon_bin/100, Latitude = lat_bin/100) %>%       # Move Coordinate columns, and divide by 100 because raw data misses decimal point
    dplyr::filter(dplyr::between(Longitude, box[1], box[2]), 
                  dplyr::between(Latitude, box[3], box[4])) %>%              # Perform a rough crop before sf clipping 
    sf::st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326, remove = TRUE) %>%
    sf::st_join(Scot_EEZ) %>%
    tidyr::drop_na()
}
