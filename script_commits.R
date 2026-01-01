library(gert)

gert::git_add("script_commits.R") 

# 2. Fazer o commit
gert::git_commit("Script to commit")

# 3. Dar o push para o GitHub (opcional)
gert::git_push()