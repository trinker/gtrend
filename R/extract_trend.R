#' Title
#' 
#' Description
#' 
#' @param x
#' @param \ldots
#' @return
#' @references
#' @keywords
#' @export
#' @seealso
#' @examples
extract_trend <- function(x, ...) setNames(x[["trend"]], c("start", "end", "trend"))

