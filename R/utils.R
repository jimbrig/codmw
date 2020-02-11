#' Get URL
#'
#' Retrives URL specific to a certain gamertag
#'
#' @param gamertag gamertag (string)
#'
#' @return character vector of URLS
#' @export
get_url <- function(gamertag) {

  paste0(
    "https://my.callofduty.com/api/papi-client/stats/cod/v1/title/mw/platform/xbl/gamer/",
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
get_data <- function(gamertag) {

 get_url(gamertag) %>%
    httr::GET() %>%
    httr::content(as = "text") %>%
    jsonlite::fromJSON() %>% #flatten = TRUE) %>%
    purrr::pluck("data")

}


get_lifetime_data <- function(gamertags) {


  hold <- tibble::tibble(
    gamertag = gamertags,
    json_data = purrr::map(gamertags, get_data)) %>%
    # level = json_data %>% map_dbl(pluck, "level"),
    # lifetime_data = purrr::map(json_data, pluck, "lifetime", "all", "properties")) %>%
    hoist(.data$json_data,
          level = "level",
          lifetime_all = c("lifetime", "all", "properties"),
          lifetime_hc_dom = c("lifetime", "mode", "hc_dom", "properties"),
          lifetime_hc_conf = c("lifetime", "mode", "hc_conf", "properties"),
          lifetime_hc_hq = c("lifetime", "mode", "hc_hq", "properties"),
          lifetime_item_data_hq = c("lifetime", "itemData"))

  hold_lifetime_all <- hold %>% select(gamertag, level, lifetime_all) %>%
    unnest_auto(lifetime_all) %>%
    janitor::clean_names() %>%
    select(gamertag,
           # level,
           kd_ratio,
           win_loss_ratio,
           score_per_minute,
           score_per_game,
           total_games_played,
           time_played_total,
           score,
           kills,
           deaths,
           suicides,
           wins,
           losses,
           ties,
           record_longest_win_streak,
           accuracy,
           total_shots,
           headshots,
           hits,
           assists,
           record_xp_in_a_match,
           best_kills,
           best_assists,
           best_score,
           best_kill_streak,
           record_kill_streak,
           record_deaths_in_a_match,
           best_spm,
           record_kills_in_a_match,
           best_kd,
           best_captures,
           best_defends,
           best_denied,
           best_confirmed
    ) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat)

  hold_lifetime_hc_dom <- hold %>% select(gamertag, level, lifetime_hc_dom) %>%
    unnest_auto(lifetime_hc_dom) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "hc_dom")

  hold_lifetime_hc_conf <- hold %>%
    select(gamertag, level, lifetime_hc_conf) %>%
    unnest_auto(lifetime_hc_conf) %>%
    janitor::clean_names() %>%
    select(gamertag,
           kills:deaths) %>%
    pivot_longer(cols = -gamertag, names_to = "stat_name", values_to = "stat") %>%
    pivot_wider(names_from = gamertag, values_from = stat) %>%
    mutate(mode = "hc_conf")

  mode_data <- bind_rows(
    hold_lifetime_hc_dom,
    hold_lifetime_hc_conf
  )

  return(list("all" = hold_lifetime_all, "mode" = mode_data))

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
