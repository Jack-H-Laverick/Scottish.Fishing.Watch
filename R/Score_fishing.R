#' Detect fishing effort by image analysis
#'
#'This function takes a collection of pixels and an image, and returns the proportion of area being fished.
#'
#'The vectors of pixels are used to create a mask which blanks out fishing in Non-Scottish waters.
#'The image is converted to black and white, and a threshold of 0.4 applied to remove land features while
#'retaining fishing activity. The proportion of bright pixels out of the pixels of interest indicates the
#'amount of fishing happening in the image.
#'
#' @param X A vector of X indices for pixels OUTISDE the target area.
#' @param Y A vector of Y indices for pixels OUTSIDE the target area.
#' @param map An image of class cimg.
#' @return The proportion of pixels within a region of interest which have fishing activity.
#' @export
Score_fishing <- function(x, y, map) {
  
  out_matrix <- data.frame(X = round(x),    # Create a mask from the X Y positions in the zone of interest
                           Y = round(y),
                           mask = TRUE) %>% # These are the points we want to keep, so label as TRUE 
    tidyr::pivot_wider(names_from = Y, values_from = mask) %>%  # Switch from long to wide format
    dplyr::select(-X) %>%                     # Drop redundant row column (to match indexing)
    as.matrix()                               # Convert to matrix
  
  blanked_image <- map[,,1,1]                 # Select only the first level from a colour image (Make black and white)
  
  if(identical(dim(blanked_image), dim(out_matrix)) == FALSE) { # If the picture doesn't match the mask in size
    
    out_matrix <- out_matrix[1:nrow(blanked_image), 1:ncol(blanked_image)] # Shrink the mask

  usethis::ui_warn("Shrinking mask to match image dimensions")   # Tell the user      
  }
  blanked_image[out_matrix] <- 0              # Colour black points outside our area
  Inside_area <- mean(blanked_image)          # Store the proportion of image area we didn't blank 
  
  blanked_image[blanked_image<0.4] <- 0       # Limit by brightness to only fishing points (light greys pick up coastline)
  Fishing_area <- mean(blanked_image)         # What proprotion of the image is highlighted as fishing?
  
  Answer <-Fishing_area/ Inside_area          # Scale to area of interest
  
  return(Answer)
}