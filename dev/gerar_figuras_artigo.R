# Packages ----

library(coiR)

library(patchwork)

library(ggview)

# Imagens de dossel ----

## Gerando as múltiplas imagens ----

imagem_dossel <- function(image, nome){
  
  imagem <- image |> coiR::coir_crop(plot = FALSE)
  
  ggplt <- ggplot() +
    tidyterra::geom_spatraster_rgb(data = imagem) +
    labs(title = nome) +
    theme_void() +
    theme(plot.title = element_text(color = "black", size = 25))
  
  assign(paste0("dossel_", nome),
         ggplt,
         envir = globalenv())
  
}

purrr::map2(coiR::data_coir(), 
            paste0("image", 1:length(coiR::data_coir())),
            imagem_dossel)

## Criando a prancha ----

ls(pattern = "^dossel_image") |> 
  mget(envir = globalenv()) |> 
  patchwork::wrap_plots(ncol = 2, nrow = 2) +
  ggview::canvas(height = 12, width = 12)

ggsave(filename = "prancha_images_recortadas.png",
       height = 10, width = 12)

# Binarizando images ----

## Gerando as múltiplas imagens ----

imagen_bin <- function(threshold){
  
  bin_img <- function(image, nome){
    
    imagem <- image |> 
      coiR::coir_crop(plot = FALSE) |> 
      coiR::coir_binarize(plot = FALSE,
                          threshold = threshold)
    
    ggplt <- ggplot() +
      tidyterra::geom_spatraster(data = imagem) +
      scale_fill_viridis_c(na.value = "transparent") +
      labs(title = paste0(nome, ": threshold = ", threshold)) +
      theme_void() +
      theme(plot.title = element_text(color = "black", size = 25),
            legend.position = "none")
    
    assign(paste0("bin_", nome, "_", threshold),
           ggplt,
           envir = globalenv())
    
    }
  
  purrr::map2(coiR::data_coir(), 
              paste0("image", 1:length(coiR::data_coir())),
              bin_img)
  
}

purrr::map(seq(0.5, 0.9, 0.2),
           imagen_bin)


## Criando a prancha ----

ls(pattern = "^bin_image") |> 
  mget(envir = globalenv()) |> 
  patchwork::wrap_plots(ncol = 3, nrow = 4) +
  ggview::canvas(height = 12, width = 12)

ggsave(filename = "prancha_images_binarizadas.png",
       height = 12, width = 12)
