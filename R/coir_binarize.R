#' @title Binarize cropped square fisheye images
#'
#' @description To analyze Canopy Opennes Index (COI), we need to difference what is interpreted in the image as canopy and what is interpred as sky. As our images are usely RGB (colored) images, a first step is to decompond our images into a black-and-white image, where we get a gradient from black (usely, value = 0) to white (usely, value = 1). Next, to binarize our image consists only to set a threshold (usely, >= 0.5, but check details), where values < threshold are interpreted as canopy and values >= threshold are interpreted as sky.
#'
#' @param data A canopy image, as a SpatRast class objecr, from \href{https://rspatial.github.io/terra/}{terra} package.
#' 
#' @param threshold Numeric. A value to definy what value from is considered sky.
#' 
#' @param plot default is TRUE. If TRUE, function plot circular cropped image.
#'
#' @details The threshold value is based on bridghtness index in pluvial forests, but that must be setted by image bridghtness index.

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
#' # binarize image
#' 
#' binarized_image <- image_single |> 
#'  coiR::coir_crop() |> 
#'  coiR::coir_binarize()
#' 
#' binarized_image
#' 
#' # Binarize multiple images
#' 
#' binarize_images <- function(images){
#' 
#'  binarized <- images |> 
#'    coiR::coir_crop() |> 
#'    coiR::coir_binarize()
#'    
#'  print(binarized)
#' 
#' }
#' 
#' purrr::walk(images, binarize_images)
#'
#' @export

coir_binarize <- function(data, threshold = 0.5, plot = TRUE) {
  
  imagem_bw <- 0.299 * data[[1]] + 
    0.587 * data[[2]] + 
    0.114 * data[[3]]
  
  ## Convertendo em escala de 0 a 1
  
  convert <- function(x){
    
    scl <- (x - min(x, na.rm = TRUE)) / (max(x, na.rm = TRUE) - min(x, na.rm = TRUE))
    
    return(scl)
    
  }
  
  names(imagem_bw) <- "variavel"
  
  imagem_bw_scale <- imagem_bw |> 
    tidyterra::mutate(variavel = variavel |> 
                        convert())
  
  imagem_bw_scale
  
  ## Binarizando ----
  
  imagem_bi <- imagem_bw_scale |> 
    dplyr::mutate(variavel = ifelse(variavel >= threshold,
                                    1,
                                    0))
  
  if(plot == TRUE){
    
    ggplt <- ggplot() +
      tidyterra::geom_spatraster(data = imagem_bi) +
      scale_fill_viridis_c(na.value = "transparent",
                           breaks = c(0, 1)) +
      theme_void()
    
    print(ggplt)
    
  }
  
  return(imagem_bi)
  
}