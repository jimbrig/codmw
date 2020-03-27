
#  ------------------------------------------------------------------------
#
# Title : CODME App R Package Development Script
#    By : Jimmy Briggs
#  Date : 2020-03-26
#
#  ------------------------------------------------------------------------


#  ------------------------------------------------------------------------
#
# Title : propAlloc Initiate Script
#    By : Jimmy Briggs
#  Date : 2020-02-27
#
#  ------------------------------------------------------------------------

# dependencies ------------------------------------------------------------

# packages
if (!require(pacman)) install.packages("pacman")
pacman::p_load(
  devtools,
  usethis,
  pkgbuild,
  roxygen2,
  roxygen2md,
  testthat,
  knitr,
  desc,
  golem,
  attachment,
  goodpractice,
  fs,
  purrr,
  rstudioapi
)

# shinytest,
# readr,
# yaml,
# config,
# sinew,
# snakecase,
# janitor,
# pkgdown,
# lifecycle,
# lazyData,
# tinytest,
# formatR,
# codetools,
# semver,
# badger

# remotes
pacman::p_load_current_gh(
  c(
    "r-lib/covr",
    "mdlincoln/docthis",
    "ThinkR-open/chameleon"
  )
)

# check build tools
pkgbuild::check_build_tools()
devtools::has_devel()

# initialize package ------------------------------------------------------
usethis::create_package("codmw")

# setup version control
usethis::use_git() # create BB remote after running this
usethis::git_sitrep()

# setup namespace and roxygen
usethis::use_namespace()
usethis::use_roxygen_md()
devtools::document()

# directories -------------------------------------------------------------
c("data",
  "dev",
  "inst/app/www",
  "inst/extdata",
  "inst/images",
  "inst/scripts/",
  "man",
  "R") %>%
  fs::dir_create(recurse = TRUE)

# ignore dev directory
usethis::use_build_ignore("dev")
# usethis::use_build_ignore("admin")
# usethis::use_build_ignore("outputs")

# package docs
# usethis::use_r("package.R")
usethis::use_package_doc()
usethis::use_tibble() # @return a [tibble][tibble::tibble-package]
usethis::use_pipe()
usethis::use_tidy_eval()
# merge these into package.R and delete files
devtools::document()

# package metadata --------------------------------------------------------
desc::desc_set(Title = "Call of Duty Modern Warfare Customized Shiny Application",
               Description = "CODMW is an R package and Shiny app that extracts,
               tracks, stores, and facilitates Call of Duty statistics in real
               time.")

usethis::use_github_links()

# authors
desc::desc_add_author(given = "Patrick",
                      family = "Howard",
                      role = "ctb",
                      email = "patrick.howard@tychobra.com")

desc::desc_add_author(given = "Mac",
                      family = "Kitchen",
                      role = "ctb",
                      email = "w.mac.kitchin@gmail.com")

desc::desc_add_author(given = "The Documentalarialists Foundation, Inc.",
                      role = "fnd")

# versions
desc::desc_set_version("0.0.1")
desc::desc_set("Depends", "R (>= 3.6.0)")

# normalize
desc::desc_normalize()

# README
usethis::use_readme_rmd()
usethis::use_logo("www/img/codmw-logo.jpg")
usethis::use_lifecycle_badge("Experimental")
usethis::use_badge(
  "Project Status: WIP",
  href = "http://www.repostatus.org/#wip",
  src = "https://www.repostatus.org/badges/latest/wip.svg"
)
knitr::knit("README.Rmd")

# other package components ------------------------------------------------
usethis::use_news_md()
usethis::use_code_of_conduct()
usethis::use_mit_license(name = "Oliver Wyman Actuarial Consulting, Inc.")
usethis::use_spell_check()
# usethis::use_coverage()

# golem shiny files
golem::add_ui_server_files(pkg = getwd())
golem::add_css_file("styles", getwd())
golem::add_js_file("custom", getwd())
golem::use_recommended_deps() # DT, glue, golem, shiny
golem::use_recommended_tests()
