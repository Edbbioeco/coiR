#' @title Crop square fisheye images into circle images
#'
#' @description To analyze Canopy Opennes Index (COI), we shot images using a fisheye lens. Nevertheless that usability, fisheye images have null spaces, due image distorction. To avoid to overestimaye canopy closure, we need to previously crop the images.
#'
#' @param data A canopy image, as a SpatRast class objecr, from \href{https://rspatial.github.io/terra/}{terra} package.
#' 
#' @param plot Default is TRUE. If TRUE, function plot circular cropped image.
#'
#' @details That function must to be used only for images were not cropped. Wheter your data are images previously circular cropped, that function are not required to calculate COI.

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
#' # Crop images
#' 
#' cropped_image <- coiR::coir_crop(image_single)
#' 
#' cropped_image
#' 
#' # Crop multiple images
#' 
#' crop_images <- function(images){
#' 
#'  croppeds <- images |> 
#'    coiR::coir_crop()
#'    
#'  print(croppeds)
#' 
#' }
#' 
#' purrr::walk(images, crop_images)
#'
#' @export

coir_crop <- function(data, plot = TRUE) {
  
  img_ext <- data |> terra::ext()
  
  centroide <- data |> 
    terra::ext() |> 
    terra::as.polygons() |> 
    terra::centroids()
  
  raio <- min((terra::xmax(img_ext) - terra::xmin(img_ext)),
              (terra::ymax(img_ext) - terra::ymin(img_ext))) / 2
  
  buffer <- terra::buffer(centroide, width = raio)
  
  imagem_crop <- data |> 
    terra::crop(buffer) |> 
    terra::mask(buffer)
  
  if(plot == TRUE){
    
    ggimagem_crop <- ggplot() +
      tidyterra::geom_spatraster_rgb(data = imagem_crop) +
      theme_void()
    
    print(ggimagem_crop)
    
  }
  
  return(imagem_crop)
  
}
