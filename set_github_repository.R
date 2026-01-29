# Pacotes ----

library(usethis)

# Iniciando ----

usethis::use_git()

# Configure o usuario e email ----

usethis::use_git_config(user.name = "Edbbioeco",
                        user.email = "edsonbbiologia@gmail.com")

# Checando o repositório ----

usethis::proj_get()

# Settando o repositório ----

usethis::use_git_remote(name = "coiR",
                        url = "https://github.com/Edbbioeco/coiR.git",
                        overwrite = TRUE)

# Criando o branch main ----

usethis::git_default_branch_configure()
