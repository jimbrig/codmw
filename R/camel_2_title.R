library(stringr)

camel_2_title <- function(camelCase) {

  sep <- gsub("([[:upper:]])", " \\1", camelCase)
  titleCase <- stringr::str_to_title(sep)

  return(titleCase)
}
