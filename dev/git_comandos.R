# Pacote ----

library(gert)

# Selecionar o arquivo ----

gert::git_status() |> 
  as.data.frame()

# Adicionando os arquivos ----

gert::git_add(list.files(pattern = "renderizar_quarto.R")) |> 
  as.data.frame() 

# Commitar ----

gert::git_commit("Script para rendizar o Quarto README.qmd")

# Pushar ----

gert::git_push(remote = "coiR", force = TRUE)

# Pullar ----

gert::git_pull(remote = "coiR")

# Resetar ----

gert::git_reset_mixed()

gert::git_reset_soft("HEAD^1")
