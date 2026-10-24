# Packages ----

library(tidyverse)

library(coiR)

library(terra)

library(tidyterra)

library(patchwork)

# Imagens de dossel ----

purrr::map2(coiR::data_coir(),
            paste0("image", 1:length(coiR::data_coir())),
            \(image, nome){

              imagem <- terra::rast(image) |>
                coiR::coir_crop(plot = FALSE)

              ggplt <- ggplot() +
                tidyterra::geom_spatraster_rgb(data = imagem) +
                labs(title = nome) +
                theme_void() +
                theme(plot.title = element_text(color = "black", size = 25))

              },
            .progress = TRUE) |>
  patchwork::wrap_plots(ncol = 2, nrow = 2)

ggsave(filename = "./dev/prancha_images_recortadas.png",
       height = 12, width = 12)

# Binarizando images ----

purrr::map(coiR::data_coir(),
           \(image){

             img <- terra::rast(image) |>
               coiR::coir_crop(plot = FALSE)

             rgb_plot <- ggplot2::ggplot() +
               tidyterra::geom_spatraster_rgb(data = img) +
               ggplot2::theme_void()

             bin_plots <- purrr::map(
               c(0.5, 0.75, 0.9),
               \(threshold){

                 ggplot() +
                   tidyterra::geom_spatraster(

                     data = img |>
                       coiR::coir_binarize(threshold = threshold)

                     ) +
                   scale_fill_viridis_c(na.value = "transparent") +
                   labs(title = paste("Threshold =", threshold)) +
                   theme_void() +
                   theme(legend.position = "none")

                 })

             c(list(rgb_plot), bin_plots)

             },
           .progress = TRUE) |>
  purrr::list_flatten() |>
  patchwork::wrap_plots(ncol = 4)

ggsave(filename = "./dev/prancha_images_binarizadas.png",
       height = 12, width = 12)
