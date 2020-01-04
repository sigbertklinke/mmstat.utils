#' demoApp
#'
#' Runs a Shiny demo app or shows an overview of all Shiny demo apps related to \code{topic}. 
#' If more than one app relates to \code{topic} a list of apps is shown otherwise the app is run.
#'
#' @param topic character: example app to run
#'
#' @return nothing
#' @export
#'
#' @examples
#' demoApp() 
#' demoApp('gettext') 
#' \dontrun{
#'   demoApp('gettext::app2en') 
#'   demoApp('app2de') 
#' }
demoApp <- function(topic) {
  # collect all apps
  spkg  <- file.path(find.package(), "shiny")
  spkg  <- spkg[dir.exists(spkg)]
  files <- list.files(spkg, '*.R', full.names = TRUE)
  sfile <- strsplit(files, '/', fixed=TRUE)
  loa   <- data.frame(pkg  =sapply(sfile, function(e) { e[length(e)-2]}),  
                      topic=sapply(sfile, function(e) { strsplit(e[length(e)], '.R', fixed=TRUE)[[1]] }),
                      file =files, stringsAsFactors = FALSE)
  index <- 1:nrow(loa)
  if (!missing(topic)) {
    index <- numeric(0)
    ts <- strsplit(topic, '::', fixed=TRUE)        
    for (tsi in ts) {
      if (length(tsi)==1) index <- c(index, which((loa$pkg==tsi[1]) | (loa$topic==tsi[1])))
      if (length(tsi)==2) index <- c(index, which((loa$pkg==tsi[1]) & (loa$topic==tsi[2])))
    }
    index <- sort(unique(index))
  }
  if (length(index)!=1) {
    loa$topic <- paste(loa$pkg, loa$topic, sep="::")
    loa$pkg   <- NULL
    return(loa)
  }
  source(loa$file[index])
}