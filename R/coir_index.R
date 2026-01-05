#' @title Get canopy openness index from binarized images
#'
#' @description Canopy Opennes Index (COI) is a value to define how much open is a canopy. This values ranges from 0 (full cole canopy) to 1 (full open canopy). to that function, we use a cropped binarized canopy image (see details).
#'
#' @param data A cropped binarized canopy image, as a SpatRast class objecr, from \href{https://rspatial.github.io/terra/}{terra} package.
#' 
#' @param round Numeric. Default is 2. Round output decimal place count.
#'
#' @details It is possible to use previous image, but raw canopy images can be used through using coiR::coir_crop() and coiR::coir_binarize() functions.

#' @examples
#'
#' # Load packages
#'
#' library(coiR)
#'
#' library(purrr)
#'
#' # Importing data
#'
#' images <- coiR::data_coir()
#' 
#' # Isolating a one single image
#' 
#' image_single <- images[[1]]
#'
#' # Get image index
#' 
#' image_index <- image_single |> 
#'  coiR::coir_crop() |> 
#'  coiR::coir_binarize() |> 
#'  coiR::coir_index()
#' 
#' image_index
#' 
#' # Binarize multiple images
#' 
#' indeces_images <- function(images){
#' 
#'  index <- images |>
#'   coiR::coir_crop() |> 
#'   coiR::coir_binarize() |> 
#'   coiR::coir_index()
#'    
#'  print(index)
#' 
#' }
#' 
#' purrr::walk(images, indeces_images)
#'
#' @export

coir_index <- function(data, round = 2) {
  
  ncell_sky <- data[data > 0] |> 
    terra::ncell()
  
  ncell_total <- data |> 
    terra::ncell()
  
  indice <- (ncell_sky / ncell_total) |> round(round)
  
  return(indice)
  
}