#' Header UI
#'
#' @return HTML output from \code{\link[shinydashboard::dashboardHeader]}
#' @export
#'
#' @importFrom shinydashboard dashboardHeaderr
#'
#' @examples
header_ui <- function(text, icon) {
  shinydashboard::dashboardHeader(
    title = icon_text(text, icon) #, # insert_logo("img/codmw-logo-alt.jpg", width = 200)
  )
}
