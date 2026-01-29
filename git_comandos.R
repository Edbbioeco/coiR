# Pacote ----

library(gert)

# Selecionar o arquivo ----

gert::git_status() |> 
  as.data.frame()

# Adicionando os arquivos ----

gert::git_add(list.files(pattern = "git_")) |> 
  as.data.frame() 

# Commitar ----

gert::git_commit("Script para comandos de Git")

# Pushar ----

gert::git_push(remote = "coiR", force = TRUE)

# Pullar ----

gert::git_pull(remote = "coiR")

# Resetar ----

gert::git_reset_mixed()

gert::git_reset_soft("HEAD^")