# if (!require(pacman)) install.packages("pacman")

# pacman::p_load(
#   shiny,
#   shinydashboard,
#   httr,
#   jsonlite,
#   rlist,
#   dplyr,
#   purrr,
#   tidyr,
#   stringr,
#   tibble,
#   formattable
# )

library(dplyr)
library(shiny)
library(jsonlite)
library(purrr)
library(tidyr)
library(tibble)
library(DT)
# library(formattable)
library(curl)
library(httr)
library(stringr)
library(shinyWidgets)

gamertags <- c("wherethenoobsat", "munchinxbox69", "BIJO44")

urls <- paste0(
  "https://my.callofduty.com/api/papi-client/stats/cod/v1/title/mw/platform/xbl/gamer/",
  gamertags,
  "/profile/type/mp"
)

get_data <- function(url) {

  resp <- httr::GET(url)
  # jsonlite::fromJSON(url, simplifyDataFrame = TRUE, flatten = TRUE)[[2]]
  all_data_list <- jsonlite::fromJSON(content(resp, as = "text")) %>% pluck("data")
  all_data_list$lifetime$all$properties %>% set_names(names(.)) %>% as_tibble()

}

# New shiny (1.4.0.9001) isn't sourcing in R directory (unsure why)
source('R/camel_2_title.R', local = TRUE)

stat_choices <- names(get_data(urls[1]))
stat_choices <- map_chr(stat_choices, function(string) {
  camel_2_title(string)
})

stat_choices <- sort(stat_choices)

#
#
#
#
# resp <- GET(urls[2])
# http_type(resp)
# http_error(resp)
#
# x <- jsonlite::fromJSON(urls[2], simplifyDataFrame = TRUE, flatten = TRUE)[[2]]
# y <- jsonlite::fromJSON(urls[1], simplifyDataFrame = TRUE, flatten = TRUE)[[2]]
#
# all_data_list <- jsonlite::fromJSON(content(resp, as = "text")) %>% pluck("data")
# lifetime <- all_data_list$lifetime$all$properties %>% set_names(names(.)) %>% as_tibble()
#
# kpi_list <- list(
#   "total_score" = lifetime$all$properties$score,
#   "total_kills" = lifetime$all$properties$kills,
#   "total_deaths" = lifetime$all$properties$deaths,
#   "total_games_played" = lifetime$all$properties$totalGamesPlayed,
#   "record_win_streak" = lifetime$all$properties$recordLongestWinStreak,
#   "record_xp_in_match" = lifetime$all$properties$recordXpInMatch,
#   "current_win_streak" = lifetime$all$properties$currentWinStreak,
#   "avg_score_per_game" = lifetime$all$properties$scorePerGame,
#   "win_loss_ratio" = lifetime$all$properties$winLossRatio,
#   "wins" = lifetime$all$properties$wins,
#   "losses" = lifetime$all$properties$losses,
#   "ties" = lifetime$all$properties$ties,
#   "time_played_hrs" = lifetime$all$properties$timePlayedTotal,
#   "headshots" = lifetime$all$properties$headshots,
#   "assists" = lifetime$all$properties$assists,
#   "accuracy" = lifetime$all$properties$accurracy,
#   "total_shots" = lifetime$all$properties$totalShots,
#   "hits" = lifetime$all$properties$hits,
#   "score_per_minute" = lifetime$all$properties$scorePerMinute,
#   "best_score" = lifetime$all$properties$bestScore,
#   "most_deaths_in_match" = lifetime$all$properties$recordDeathsInAMatch,
#   "best_spm" = lifetime$all$properties$bestSPM,
#   "best_kills" = lifetime$all$properties$recordKillsInAMatch,
#   "best_confirmed" = lifetime$all$properties$bestConfirmed,
#   "best_captured" = lifetime$all$properties$bestCaptures,
#   "best_defends" = lifetime$all$properties$bestDefends,
#   "best_assists" = lifetime$all$properties$bestAssists
# )
# #level <- all_data_list$maxLevel
# #total_xp <- all_data_list$totalXp
#
#
# #kpis <- c(
#
# #)
# flatten(kpi_list)
#
# dat <- kpi_list %>% purrr::compact() %>% tibble::as_tibble()
# df %>%
#   mutate(x = map(, flatten_dfc)) %>%
#   unnest()
