# Pacote ----

library(gert)

# Selecionar o arquivo ----

gert::git_status() |> 
  as.data.frame()

# Adicionando os arquivos ----

gert::git_add(list.files(pattern = "commits")) |> as.data.frame() 

# Commitar ----

gert::git_commit("remover")

# Pushar ----

gert::git_push(remote = "coiR", force = TRUE)

## Pullar ----

gert::git_pull(remote = "coiR")
