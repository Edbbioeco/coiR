# Pacote ----

library(gert)

# Selecionar o arquivo ----

gert::git_add(list.files(pattern = "set")) |> as.data.frame() 

# Commitar ----

gert::git_commit("Script to set github repository")

# Pushar ----

gert::git_push(remote = "origin", force = TRUE)

## Pullar ----

gert::git_pull()
