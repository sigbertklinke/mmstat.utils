#' readme.md
#'
#' Creates lines for a README.md for Github based on roxygen2 comments using \code{\link[roxygen2]{parse_package}}.
#'
#' @inheritParams roxygen2::parse_package
#' @importFrom roxygen2 env_package parse_package
#' @importFrom stringr fixed regex str_replace_all str_split
#'
#' @return strings with markdown code
#' @export
#'
#' @examples
readme.md <- function(path = ".", env = env_package(path)) {
  markdownify <- function(txt) {
    txt <- paste0(txt, collapse="\n")
    # 
    txt <- str_replace_all(unlist(txt), regex("\\\\dontrun\\s*\\{.*?\\}", dotall=TRUE), "")
    txt <- str_replace_all(unlist(txt), "\\\\code\\{\\\\link\\s*\\[(.*?)\\]\\s*\\{(.*?)\\}\\}", "[`\\1::\\2`](https://cran.r-project.org/web/packages/\\1/\\1.pdf)")
    txt <- str_replace_all(unlist(txt), "\\\\link\\s*\\[(.*?)\\]\\s*\\{(.*?)\\}", "[\\1::\\2](https://cran.r-project.org/web/packages/\\1/\\1.pdf)")
    txt <- str_replace_all(unlist(txt), "\\\\code\\s*\\{(.*?)\\}", "`\\1`")
    unlist(str_split(unlist(txt), fixed("\n")))
  }
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