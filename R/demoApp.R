#' demoApp
#'
#' Runs one Shiny demo app of a package. With \code{demoApp(package="gettext")} 
#' you get a vector of topics back of the package \code{gettext}.
#'
#' @param topic character: example(s) to show or \code{NULL}
#' @param package character: package to use (default: \code{"gettext"})
#'
#' @return nothing
#' @export
#'
#' @examples
#' demoApp(package='gettext') 
#' \dontrun{
#'   demoApp('app2en', 'gettext') 
#'   demoApp('app2de', 'gettext') 
#' }
demoApp <- function(topic=NULL, package='gettext') {
  if (is.null(topic)) {
    files <- list.files(path=system.file('shiny', package=package), pattern="*.R")
    files <- strsplit(basename(files), '.R')
    return(sapply(files, '[[', 1))
  }
  if (length(topic)>1) stop("More than one topic given")
  file <- paste0(system.file('shiny', package=package), '/', topic[1], '.R')
  source(file)
}