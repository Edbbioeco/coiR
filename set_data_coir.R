# Caminho das imagens dentro do pacote
imgs <- list.files(path = "cropped-images/")

# Criando o objeto
data_coiR <- list(files = imgs)

# Salvar no pacote
usethis::use_data(data_coiR, overwrite = TRUE)
