# PAcotyes ----

library(tidyverse)

library(magick)

# Reduzir imagens ----

purrr::map(
  list.files(path = "inst/extdata/",
             full.names = TRUE),
  \(foto){

    magick::image_read(foto) |>
      magick::image_resize("800x800") |>
      magick::image_write(foto, quality = 70)

    },
  .progress = TRUE)
