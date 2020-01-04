#' readme.md
#'
#' Creates a README.md for Github based on roxygen2 comments and uses \code{\link[roxygen2]{parse_package}}.
#'
#' @inheritParams roxygen2::parse_package
#' @importFrom roxygen2 env_package parse_package
#' @importFrom roxygen2md markdownify
#'
#' @return strings with markdown code
#' @export
#'
#' @examples
readme.md <- function(path = ".", env = env_package(path)) {
  objs   <- parse_package(path, env)
  readme <- NULL
  for (obj in objs) {
    tags <- sapply(obj[[1]], function(elem) {elem$tag})
    #
    pos <- which(tags=='title')
    if (length(pos)) readme <- c(readme, sprintf('# %s #', markdownify(obj[[1]][[pos]]$val)), "") 
    pos <- which(tags=='description')
    if (length(pos)) readme <- c(readme, markdownify(obj[[1]][[pos]]$val), "")
    pos <- which(tags=='examples')
    if (length(pos))  {
      readme <- c(readme, "```r", markdownify(obj[[1]][[pos]]$val), "```", "")
    }
  }
  readme
}