# Pacotes ----

library(coiR)

library(tidyverse)

library(flextable)

# Gerando valores ----

coir_valores <- function(threshold){
  
  index_img <- function(image, nome){
    
    index <- image |> 
      coiR::coir_crop(plot = FALSE) |> 
      coiR::coir_binarize(plot = FALSE,
                          threshold = threshold) |> 
      coiR::coir_index()
    
    Image <<- c(nome, Image)
    
    Threshold <<- c(threshold, Threshold)
    
    Index <<- c(index, Index)
    
  }
  
  purrr::map2(coiR::data_coir(), 
              paste0("image", 1:length(coiR::data_coir())),
              index_img)
  
}

Image <- c()

Threshold <- c()

Index <- c()

purrr::map(seq(0.5, 0.9, 0.2),
           coir_valores)

# Tabela ----

## Criando o data frame ----

data_coir_index <- tibble::tibble(Image,
                                  Threshold,
                                  Index) |> 
  dplyr::arrange(Image, Threshold)

data_coir_index

## Tabela flextable ----

tabela_flex <- data_coir_index |> 
  flextable::flextable() |> 
  flextable::align(align = "center", part = "all") |> 
  flextable::width(width = 1) |> 
  flextable::font(fontname = "Times New Roman", part = "all") |> 
  flextable::fontsize(size = 12, part = "all") |> 
  flextable::bg(bg = "white", part = "all")

tabela_flex

## Exportando tabela ----

tabela_flex |> 
  flextable::save_as_docx(path = "Table 1.docx")
