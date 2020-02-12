#   janitor::clean_names() %>%
#     select(gamertag,
#
#
#
#   jsonData <- fromJSON("data.json")
#
#   tibble(
#     gamertag = gamertags,
#     data = map(gamertags, get_data),
#     level = purrr::map_chr(data, )
#   )
#
#
#   hold <- tibble::tibble(gamertag = gamertags,
#                          data = purrr::map(gamertags, get_data),
#                          lifetime_data_all = purrr::map(data, pluck, "lifetime", "all", "properties"),
#                          lifetime_hc_dom_data = purrr::map(data, pluck, "lifetime", "mode", "hc_dom", "properties"),
#                          lifetime_hc_conf_data = purrr::map(data, pluck, "lifetime", "mode", "hc_conf", "properties"),
#                          lifetime_hc_hq_data = purrr::map(data, pluck, "lifetime", "mode", "hc_hq", "properties"),
#                          lifetime_item_data = purrr::map(data, pluck, "lifetime", "itemData")
#   )
#
#                                                 weekly_data = purrr::map(data, pluck, "weekly", "all", "properties"))
#  dat <-
#
#
#
#   lifetime_data <- hold %>%
#     hoist(data,
#           level = "level",
#           lifetime = c("lifetime", "all", "properties")) %>%
#     unnest_auto(lifetime) %>%
#     select(-data) %>%
#
#
#   weekly_data <- hold %>%
#     hoist(data,
#           level = "level",
#           weekly = c("weekly", "all", "properties")) %>%
#     unnest(weekly)
#
#
#     mutate(weekly = flatten(weekly))
#
#
#
#   map(weekly, flatten))
#
#     select(-data) %>%
#     janitor::clean_names() %>%
#     select(gamertag,
#            # level,
#            kd_ratio,
#            win_loss_ratio,
#            score_per_minute,
#            score_per_game,
#            total_games_played,
#            time_played_total,
#            score,
#
#            kills,
#            deaths,
#            suicides,
#
#            wins,
#            losses,
#            ties,
#            record_longest_win_streak,
#
#
#            accuracy,
#            total_shots,
#            headshots,
#            hits,
#            assists,
#
#            record_xp_in_a_match,
#            best_kills,
#            best_assists,
#            best_score,
#            best_kill_streak,
#            record_kill_streak,
#            record_deaths_in_a_match,
#            best_spm,
#            record_kills_in_a_match,
#            best_kd,
#
#            best_captures,
#            best_defends,
#
#            best_denied,
#            best_confirmed
#     ) %>%
#     pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
#     pivot_wider(names_from = gamertag, values_from = stat)
#
#
#
#   weekly = c("weekly", "all", "properties"))
#
#   lifetime_data <-  gamers %>%
#     hoist(data,
#           level = "level",
#           lifetime = c("lifetime", "all", "properties"),
#           weekly = c("weekly", "all", "properties")) %>%
#     unnest_auto(lifetime) %>%
#     unnest_auto(weekly)
#
#
#     hoist(lifetime,
#           all = "all")
#
#
#     tidyr::unnest_wider(lifetime)
#
#
#
#
#
#   hold <- gamertags %>%
#     get_data()
#
#
# }
#
#   all_data_list <- gamertag %>%
#     get_url() %>%
#     httr::GET() %>%
#     httr::content(as = "text") %>%
#     jsonlite::fromJSON() %>%
#     purrr::pluck("data")
#
#
#
#
#   level <- all_data_list$level
#
#   lifetime_data <- all_data_list %>%
#     purrr::pluck("lifetime", "all", "properties") %>%
#     purrr::map(as_tibble) %>%
#     reduce(bind_rows, .id = "stat") %>%
#     as_tibble() %>%
#     mutate()
#
#
#
#
#   rownames = NA) %>%
#     tibble::rownames_to_column("Stat") %>%
#     set_names(c("stat", gamertags)) %>%
#     as_tibble() %>%
#     mutate(stat = camel_to_title(stat))
#
#
#     purrr::pluck("all") %>%
#     purrr::pluck("properties")
#
#
#     purrr::flatten() %>%
#
#
#
#
#
#   %>%
#     purrr::map_if(is_list, as_tibble) %>%
#     purrr::map_if(tibble::is_tibble, list) %>%
#     bind_cols()
#
#   # url <- get_url(gamertag)
#   # resp <- httr::GET(url)
#   # # jsonlite::fromJSON(url, simplifyDataFrame = TRUE, flatten = TRUE)[[2]]
#   # all_data_list <- jsonlite::fromJSON(httr::content(resp, as = "text")) %>%
#   #   purrr::pluck("data")
#
#   # lifetime > all  > properties
#   hold <- all_data_list$lifetime$all$properties %>%
#     purrr::set_names(names(.)) %>%
#     tibble::as_tibble()
#
#
#
#   map_dfr(urls, get_data) %>%
#     # tibble::add_column("gamer" = gamertags) %>%
#     # select(gamer, everything()) %>%
#     t() %>%
#     as_tibble(rownames = NA) %>%
#     tibble::rownames_to_column("Stat") %>%
#     set_names(c("stat", gamertags)) %>%
#     as_tibble() %>%
#     mutate(stat = camel_to_title(stat))
#
#
# }
#
# get_data_single <- function(tag) {
#
#
#
# }
