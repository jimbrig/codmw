

pacman::p_load(
  usethis,
  devtools,
  fs,
  purrr,
  magrittr,
  golem
)

usethis::create_project(path = "Personal/codmw-app")

c(
  "www",
  "ui",
  "server",
  "data",
  "data-raw"
) %>%
  purrr::walk(., fs::dir_create)

c(
  "ui.R",
  "server.R",
  "global.R",
  "config.yaml",
  "www/mystyles.css",
  "www/custom-js.js"
) %>%
  purrr::walk(fs::file_create)
