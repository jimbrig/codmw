#' Get URL
#'
#' Retrives URL specific to a certain gamertag
#'
#' @param gamertag gamertag (string)
#'
#' @return character vector of URLS
#' @export
get_url.mw <- function(gamertag) {

  paste0(
    "https://my.callofduty.com/api/papi-client/stats/cod/v1/title/mw/platform/xbl/gamer/",
    gamertag,
    "/profile/type/mp"
  )

}

get_url.bo <- function(gamertag) {

  paste0(
    "https://my.callofduty.com/api/papi-client/stats/cod/v1/title/cw/platform/xbl/gamer/",
    gamertag,
    "/profile/type/mp"
  )

}



#' get_data
#'
#' retrieve data from \url{https://my.callofduty.com} API by xbox gamertag
#'
#' @param gamertag xbox live gamertag
#'
#' @return tibble
#' @export
#'
#' @examples get_data(munchinxbox69)
#'
#' @importFrom httr GET content
#' @importFrom jsonlite fromJSON
#' @importFrom purrr pluck set_names
#' @importFrom tibble as_tibble
get_data <- function(gamertag, game = "bo") {

  if (game == "mw") {
    url <- get_url.mw(gamertag)
  } else {
    url <- get_url.bo(gamertag)
  }

  url %>%
    httr::GET(add_headers("Host" = "my.callofduty.com",
                          "Connection" = "keep-alive",
                          "Cookie" = '_gcl_au=1.1.371092191.1607839219; _ga=GA1.3.357333076.1607839223; CRM_BLOB=eyJ2ZXIiOjEsInBsYXQiOnsieCI6eyJ2IjowLCJ0Ijp7ImJvNCI6eyJtcCI6bnVsbCwieiI6bnVsbCwicHJlcyI6MTEuMCwic3AiOjAuMCwibGV2Ijo1Ni4wfX19fX0; tfa_enrollment_seen=true; ssoDevId=7f52267380f743139cd4ca938e701783; optimizelyEndUserId=oeu1607839470677r0.07867353186876391; _scid=6b68c5f0-6da6-47cf-a9c1-d1b76adf3289; _sctr=1|1607835600000; aamoptsegs=aam%3D16648913%2Caam%3D16187168; _ga=GA1.2.1621120958.1607847121; _fbp=fb.1.1607847124830.1194777766; _gid=GA1.3.1009447306.1608186381; ACT_SSO_COOKIE=MTQwODcyMzg6MTYwOTM5NjAwMjUwNDpjNzJiNmJkYjczN2RmOTRkNzQ2OGNlODk1ODhkZmQ4MQ; ACT_SSO_COOKIE_EXPIRY=1609396002504; ACT_SSO_REMEMBER_ME=MTQwODcyMzg6JDJhJDEwJC5pR2xRSE1nQkhWRk5TRmxpZ1FGTWU5MTVUUTJjblV6bEdRTTlyQk4zcS8zMmJ6aExEb09t; _abck=8F01B975AF1407A54E3FCD2B3F25BCA3~0~YAAQOMDOF6rT80t2AQAA1xhhbwW4xwLakyG6NAGaxybXF9RcxI4c79cx1iXb4HcmT2t3p4j2UUiAb7OLINDnsxHv4Y9E21aUEgzzz3RDmXX/bUIa17Jto5wq4WWA+wKBVQiHhpgSkw5Vs6fjTYR7cbO3969jxzOZ+4gZL3d3SUb9W8fRFC9CpKrDGDK1ayOVWTsTUjAjlkPlUI7VZPRBSeQZdjFwc2Sk/g28ozlqgSiLNeJsBG1N85GApzWGqxr+ek1+1ITAUe2SkKgUYs1v8ZQfb3qQPQFXmgi08cnYuYclyoq4IOSP5By0RVXR3FWR+7N2aj7bTAObZnwUG1HoZO9WzkMGSEcgp9Y=~-1~-1~-1; AMCV_0FB367C2524450B90A490D4C%40AdobeOrg=-637568504%7CMCIDTS%7C18614%7CMCMID%7C86476226826632331832083577158936441323%7CMCAAMLH-1608791198%7C6%7CMCAAMB-1608791198%7C6G1ynYcLPuiQxYZrsz_pkqfLG9yMXBpb2zX5dvJdYQJzPXImdj0y%7CMCOPTOUT-1608193599s%7CNONE%7CMCAID%7CNONE%7CMCSYNCSOP%7C411-18618%7CvVersion%7C5.1.1%7CMCCIDH%7C1956761501; OptanonConsent=isIABGlobal=false&datestamp=Thu+Dec+17+2020+01%3A26%3A42+GMT-0500+(Eastern+Standard+Time)&version=6.8.0&hosts=&consentId=725daed6-f572-4bb7-9858-72ecb8d8052a&interactionCount=1&landingPath=NotLandingPage&groups=1%3A1%2C2%3A1%2C3%3A1%2C4%3A1&AwaitingReconsent=false; s_nr=1608186483335-Repeat; API_CSRF_TOKEN=da3bdf26-0e12-414c-b5c4-db1c055777f9; ak_bmsc=CE1938E638B6ED97126FA8F7A48C4C231730FE35E1790000AA1EDC5FF416FD01~plR+O+spqoIZlI74C9vz8rwdSwyUgkVV/BLdXK11/Tbu2vlCR9rOEZRv81iyNxvApS1KuF6gsD/OV3q9eI6ivqIFTP7XkoFt/K5LGSjIqGr+mXW3naGndARA8Fpv6agr/bDbdbdmXMkrlp6jyHIE1W+qdbHol/g/K14fAqT/Zy2uP+DJxPOiObfZgKyZIQuL2uvevrB1kwtnWK1t2OzeDDHfOxLBcsLbk2wauGdvLVXlMjjw714D1KeQUyBOpigCQ9; bm_sv=C4B5098C294BC2F405DC0B9402C3007F~PIBt1udoaybsJgCSe7A3/PW1gncNyMAIf7w8RM+t1oD8H7D9yRwUeZhS4/UFeIxkgUhobmYNLL662CwxQfbuDYJstEfHPGxVesWnu+V32GPUKcaApht/eaZlvaKLlWRlZW79civPlG3VpaA2tM6+qA==; API_CSRF_TOKEN=e093cb03-ef8a-4a05-b43f-613ebfff2327; bm_sv=CB82AA85D043EE17137253A019E6A193~hAa43sBbbTL8IxtTfC/lohrV+ro2/+TqQYBjNrYYPNkEkK308yt/yLM/vgCjtssPzlYSri7eMJ9ljJkJPDLO2i9E2z/eUJ58rKF0w3ilBYy5HAr1mn8De/BkVqynaDC6Pku1wxxG3WzIVc8WFwC0r4gaSR4x7aRvPz26BPGUTw0=',
                          'Authorization' = 'Basic amltYnJpZzIwMTFAZ21haWwuY29tOm0xc3N5c3VzeQ==')) %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON() %>%
    purrr::pluck("data")

}

# d <- get_data("munchinxbox69")

# maps <- list(hold$json_data$lifetime)

get_lifetime_data <- function(gamertags, game = "bo") {

  # game <- match.arg(game)

  hold <- tibble::tibble(
    gamertag = gamertags,
    json_data = purrr::map(gamertags, get_data, game = game)) %>%
    # level = json_data %>% map_dbl(pluck, "level"),
    # lifetime_data = purrr::map(json_data, pluck, "lifetime", "all", "properties")) %>%
    hoist(.data$json_data,
          level = "level",
          totalxp = "totalXp",
          lifetime_all_bo = c("lifetime", "all", "properties"),
          lifetime_hc_tdm_bo = c("lifetime", "mode", "tdm_hc", "properties"),
          lifetime_hc_dom_bo = c("lifetime", "mode", "dom_hc", "properties"),
          lifetime_hc_conf_bo = c("lifetime", "mode", "conf_hc", "properties"),
          lifetime_tdm_bo = c("lifetime", "mode", "tdm", "properties"),
          lifetime_dom_bo = c("lifetime", "mode", "dom", "properties"),
          lifetime_conf_bo = c("lifetime", "mode", "conf", "properties"),

          lifetime_all_mw = c("lifetime", "all", "properties"),
          lifetime_hc_dom_mw = c("lifetime", "mode", "hc_dom", "properties"),
          lifetime_hc_conf_mw = c("lifetime", "mode", "hc_conf", "properties"),
          lifetime_hc_hq_mw = c("lifetime", "mode", "hc_hq", "properties"),

          lifetime_map_data = c("lifetime", "map"),
          lifetime_item_data_hq = c("lifetime", "itemData"),
          lifetime_attachment_data = c("lifetime", "attachmentData"),

          # weekly
          weekly_all_bo = c("weekly", "all", "properties"),
          weekly_hc_tdm_bo = c("weekly", "mode", "tdm_hc", "properties"),
          weekly_hc_dom_bo = c("weekly", "mode", "dom_hc", "properties"),
          weekly_hc_conf_bo = c("weekly", "mode", "conf_hc", "properties"),
          weekly_tdm_bo = c("weekly", "mode", "tdm", "properties"),
          weekly_dom_bo = c("weekly", "mode", "dom", "properties"),
          weekly_conf_bo = c("weekly", "mode", "conf", "properties"),

          weekly_all_mw = c("weekly", "all", "properties"),
          weekly_hc_dom_mw = c("weekly", "mode", "hc_dom", "properties"),
          weekly_hc_conf_mw = c("weekly", "mode", "hc_conf", "properties"),
          weekly_hc_hq_mw = c("weekly", "mode", "hc_hq", "properties")

    )

  if (game == "mw") {
    hold$lifetime_all <- hold$lifetime_all_mw
  } else {
    hold$lifetime_all <- hold$lifetime_all_bo
  }

  hold_lifetime_all <- hold %>%
    select(gamertag, level, totalxp, lifetime_all_bo) %>%
    filter(!is.na(level)) %>%
    unnest_wider(lifetime_all_bo) %>%
    janitor::clean_names() %>%
    select(gamertag,
           # current_win_streak,
           level,
           totalxp,
           score,
           score_per_minute,
           score_per_game,
           most_kills_in_a_game,
           rankxp,
           shots,
           kdratio,
           ekia,
           wlratio,
           score_per_minute,
           score_per_game,
           games_played,
           time_played_total,
           score,
           kills,
           assists,
           deaths,
           suicides,
           wins,
           losses,
           # ties,
           # record_longest_win_streak,
           accuracy,
           shots,
           headshots,
           hits,
           assists,
           # record_xp_in_a_match,
           # best_kills,
           # best_assists,
           # best_score,
           longest_killstreak,
           # record_kill_streak,
           # record_deaths_in_a_match,
           # best_spm,
           # record_kills_in_a_match,
           # best_kd,
           # best_captures,
           # best_defends,
           # best_denied,
           # best_confirmed
    ) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(stat_name = str_replace_all(stat_name, "_", " ") %>% str_to_title())

  hold_lifetime_tdm <- hold %>% select(gamertag, level, lifetime_tdm_bo) %>%
    unnest_wider(lifetime_tdm_bo) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "tdm")

  hold_lifetime_dom <- hold %>% select(gamertag, level, lifetime_dom_bo) %>%
    unnest_wider(lifetime_dom_bo) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "dom")

  hold_lifetime_conf <- hold %>%
    select(gamertag, level, lifetime_conf_bo) %>%
    unnest_wider(lifetime_conf_bo) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "conf")

  hold_lifetime_hc_tdm <- hold %>% select(gamertag, level, lifetime_hc_tdm_bo) %>%
    unnest_wider(lifetime_hc_tdm_bo) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "hc_tdm")

  hold_lifetime_hc_dom <- hold %>% select(gamertag, level, lifetime_hc_dom_bo) %>%
    unnest_wider(lifetime_hc_dom_bo) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "hc_dom")

  hold_lifetime_hc_conf <- hold %>%
    select(gamertag, level, lifetime_hc_conf_bo) %>%
    unnest_wider(lifetime_hc_conf_bo) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "hc_conf")

  mode_data <- bind_rows(
    hold_lifetime_tdm,
    hold_lifetime_dom,
    hold_lifetime_conf,
    hold_lifetime_hc_tdm,
    hold_lifetime_hc_dom,
    hold_lifetime_hc_conf
  )

  return(list("all" = hold_lifetime_all, "mode" = mode_data))

}

#' Insert Logo
#'
#' @param file
#' @param style
#' @param width
#' @param ref
#'
#' @return
#' @export
#'
#' @examples
insert_logo <- function(file,
                        style = "background-color: #FFF; width: 100%; height: 100%;",
                        width = NULL,
                        ref = "#"){

  tags$div(
    style = style,
    tags$a(
      img(
        src = file,
        width = width
      ),
      href = ref
    )
  )

}

#' camel_to_title
#'
#' Convert character string from camel case to title/proper case
#'
#' @param camel_case input character string
#'
#' @return string
#' @export
#'
#' @importFrom stringr str_to_title
camel_to_title <- function(camel_case) {

  sep <- gsub("([[:upper:]])", " \\1", camel_case)

  stringr::str_to_title(sep)

}

#' Insert Logo
#'
#' @param file file
#' @param style style
#' @param width width
#' @param ref ref
#'
#' @return tag
#' @export
#' @importFrom shiny tags img
insert_logo <- function(file,
                        style = "background-color: #FFF; width: 100%; height: 100%;",
                        width = NULL,
                        ref = "#"){

  shiny::tags$div(
    style = style,
    shiny::tags$a(
      shiny::img(
        src = file,
        width = width
      ),
      href = ref
    )
  )

}

#' Icon Text
#'
#' Creates an HTML div containing the icon and text.
#'
#' @param icon fontawesome icon
#' @param text text
#'
#' @return HTML div
#' @export
#'
#' @examples
#' icon_text("table", "Table")
#'
#' @importFrom shiny icon tagList
icon_text <- function(icon, text) {

  i <- shiny::icon(icon)
  t <- paste0(" ", text)

  shiny::tagList(div(i, t))

}

#' Fluid Column - Shiny fluidRow + Column
#'
#' @param ... elements to include within the flucol
#' @param width width
#' @param offset offset
#'
#' @return A column wrapped in fluidRow
#' @export
#'
#' @examples
#' propertyAllocation::flucol(12, 0, shiny::h5("HEY"))
#' @importFrom shiny fluidRow column
flucol <- function(..., width = 12, offset = 0) {

  if (!is.numeric(width) || (width < 1) || (width > 12))
    stop("column width must be between 1 and 12")

  shiny::fluidRow(
    shiny::column(
      width = width,
      offset = offset,
      ...
    )
  )
}

# Turn an R list into an HTML list
#
# @param list An R list
# @param class a class for the list
# @return an HTML list
# @examples
# list_to_li(c("a","b"))
#
#' @importFrom htmltools tags tagAppendAttributes tagList
list_to_li <- function(list, class = NULL){
  if (is.null(class)) {
    tagList(lapply(list, tags$li))
  } else {
    res <- lapply(list, tags$li)
    res <- lapply(res, function(x) tagAppendAttributes(x, class = class))
    tagList(res)
  }

}


#' @importFrom htmltools tags tagAppendAttributes tagList
list_to_p <- function(list, class = NULL){
  if (is.null(class)) {
    tagList(lapply(list, tags$p))
  } else {
    res <- lapply(list, tags$p)
    res <- lapply(res, function(x) tagAppendAttributes(x, class = class))
    tagList(res)
  }

}

#' @importFrom glue glue
#' @importFrom htmltools tags tagAppendAttributes tagList
named_to_li <- function(list, class = NULL){
  if (is.null(class)) {
    res <- mapply(
      function(x, y){
        tags$li(HTML(glue("<b>{y}:</b> {x}")))
      },
      list, names(list), SIMPLIFY = FALSE)
    #res <- lapply(res, HTML)
    tagList(res)
  } else {
    res <- mapply(
      function(x, y){
        tags$li(HTML(glue("<b>{y}:</b> {x}")))
      },
      list, names(list), SIMPLIFY = FALSE)
    res <- lapply(res, function(x) tagAppendAttributes(x, class = class))
    tagList(res)
  }
}
