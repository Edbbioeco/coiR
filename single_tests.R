library(coiR)

imagem <- coiR::data_coir()

ggplot() +
  geom_spatraster_rgb(data = imagem[[2]])

images <- coiR::data_coir()

image_single <- images[[1]]

image_single |> class()

coiR::coir_crop(image_single)

image_single

source("coiR.r")

imagem_bw2 <- imagem_bw

names(imagem_bw2) <- "variavel"

imagem_bw2

image_single |> 
  coiR::coir_crop() |> 
  coir_binarize()
