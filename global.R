
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
# library(formattable)

# functions & modules
source("R/utils.R")

# meta
gamertags <- c(
  "wherethenoobsat",
  "munchinxbox69",
  "BIJO44"
)

stat_choices <- get_lifetime_data(gamertags[1])[["all"]] %>%
  pull(stat_name)

