
##**## A tidy place to keep functions and reduce clutter in programmes

#### Global Fishing Watch Data Extraction ####

#' Import Fishing Effort Within Specified Areas
#'
#'
#'
#' @param file The full name to a .csv file containing Global Fishing Watch data.
#' @param area A Simple Feature object representing the areas to return fishing activity in.
#' @param box A 4 number vector of min and max longitude, min and max latitude in that order.
#' @return A dataframe of cells from a 0.01 degree grid which contains fishing activity,
#' @export
get_cropped_fishing <- function (file, area, box) {

  Fish <- utils::read.csv(file, header = TRUE) %>%                           # Take first csv file as a test
    dplyr::mutate(Longitude = lon_bin/100, Latitude = lat_bin/100) %>%       # Move Coordinate columns, and divide by 100 because raw data misses decimal point
    filter(between(Longitude, box[1], box[2]), 
           between(Latitude, box[3], box[4])) %>%                            # Perform a rough crop before sf clipping 
    sf::st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326, remove = TRUE) %>%
    sf::st_join(area) %>%
    tidyr::drop_na()
}
