library(usethis)

# Configure seu nome e email (use o mesmo do GitHub)
usethis::use_git_config(user.name = "Edbbioeco",
                        user.email = "edsonbbiologia@gmail.com")

# Crie um token de acesso (isso abrirá o navegador)
# Guarde esse token! Você precisará dele se o RStudio pedir senha.
usethis::create_github_token()

# Salve o token no seu R
gitcreds::gitcreds_set()

usethis::proj_get()

usethis::use_git()

usethis::use_git_remote(name = "origin",
                        url = "https://github.com/Edbbioeco/coiR.git",
                        overwrite = TRUE)

usethis::git_default_branch_rename(from = "master", to = "main")
# Adiciona todos os arquivos
gert::git_add(".")

# Cria o registro das alterações
gert::git_commit("Primeiro envio do pacote")

# Envia para o GitHub
gert::git_push(remote = "origin")

usethis::edit_git_config()
