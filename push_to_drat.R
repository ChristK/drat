drat::insertPackage(c('../CKteachR_0.0.3.9000.tar.gz'), getwd(), commit = TRUE)
repo = git2r::repository(".")
git2r::checkout(repo, "gh-pages")
git2r::pull(repo)
git2r::push(repo)


# to install
# drat::addRepo("ChristK")
# install.packages("CKteachR", repos = c("https://ChristK.github.io/drat/",
#                                        "https://cloud.r-project.org/"),
#                  dependencies = TRUE)
install.packages("remotes")
remotes::install_github(
  "christk/CKteachR",
  dependencies = TRUE,
  upgrade = "always",
  force = TRUE
)

# https://www.r-bloggers.com/2020/10/submitting-r-package-to-cran/
library(miniCRAN)
tags <- "CKteachR"
repos <- c(CRAN = "https://ChristK.github.io/drat/", "https://cloud.r-project.org/")
deps <- pkgDep(tags, repos = repos, type = "source", suggests = FALSE)

# Create temporary folder for miniCRAN
# dir.create(pth <- file.path(getwd(), "miniCRAN"))
pth <- "."
# Make repo for source and win.binary
makeRepo(deps, path = pth, repos = repos, type = c("source", "win.binary", "mac.binary"))
# Investigate the repository file structure:

# List all files in miniCRAN
list.files(file.path(pth, "src", "contrib"), recursive = TRUE, full.names = FALSE)
# Check for available packages
pkgAvail(repos = pth, type = "win.binary")[, c(1:3, 5)]




# tt <- remotes::dev_package_deps(system.file(package = "CKteachR"), dependencies = TRUE)


## Assume we're in the drat directory
## Switch to gh-pages
repo = git2r::repository(".")
git2r::checkout(repo, "gh-pages")
git2r::pull(repo)


git2r::add(repo, file.path("src", "contrib", "*.tar.gz"))
git2r::add(repo, file.path("src", "contrib", "PACKAGES"))
git2r::add(repo, file.path("src", "contrib", "PACKAGES.gz"))
git2r::add(repo, file.path("src", "contrib", "PACKAGES.gz"))

git2r::commit(repo, "First version using miniCRAN")
