
##**## A tidy place to keep functions and reduce clutter in programmes

#### Global Fishing Watch Data Extraction ####

#' Import Fishing Effort Within Specified Areas
#'
#'
#'
#' @param file The full name to a .csv file containing Global Fishing Watch data.
#' @param area A Simple Feature object representing the areas to return fishing activity in.
#' @return A dataframe of cells from a 0.01 degree grid which contain fishing activity,
#' labelled by the FAO region they fall in.
#' @family Global Fishing Watch functions
#' @export
get_cropped_fishing <- function (file, area) {

  Fish <- utils::read.csv(file, header = TRUE) %>%                           # Take first csv file as a test
    dplyr::mutate(Longitude = lon_bin/100, Latitude = lat_bin/100) %>%       # Move Coordinate columns, and divide by 100 because raw data misses decimal point
    sf::st_as_sf(coords = c("Longitude", "Latitude"), crs = 4326) %>%
    sf::st_join(area) %>%
    tidyr::drop_na()
}
