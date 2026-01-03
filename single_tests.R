library(coiR)

imagem <- coiR::data_coir()

ggplot() +
  geom_spatraster_rgb(data = imagem[[2]])

images <- coiR::data_coir()

image_single <- images[[1]]

image_single |> class()

coiR::coir_crop(image_single)
