
#  ------------------------------------------------------------------------
#
# Title : Global
#    By : Jimmy Briggs
#  Date : 2020-02-08
#
#  ------------------------------------------------------------------------

options(scipen = 999)

# library packages
library(dplyr)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(shinyjs)
library(jsonlite)
library(purrr)
library(tidyr)
library(tibble)
library(DT)
library(curl)
library(httr)
library(stringr)
library(shinyWidgets)
library(readr)
library(magrittr)
library(stringr)
library(markdown)
library(rmarkdown)
library(knitr)
# library(formattable)

# functions & modules
source("R/utils.R")

# meta
gamertags <- c(
  "wherethenoobsat",
  "munchinxbox69",
  "BIJO44",
  "an%20angry%20hobo8",
  "KiimJongAl"
)

gamertag_choices <- gamertags
names(gamertag_choices) <- stringr::str_replace_all(gamertags, "%20", " ")

stat_choices <- get_lifetime_data(gamertags[4])[["all"]] %>%
  pull(stat_name)

