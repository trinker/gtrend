#' Extract Trend Data
#' 
#' Extract the \code{"trend"} from a \code{gtrend_scraper} object and renames 
#' last column "trend".
#' 
#' @param x A \code{gtrend_scraper} object.
#' @param \ldots Currently ignored.
#' @return Returns a \code{data.frame} (for individual \code{gtrend_scraper} elements) 
#' or a list of \code{data.frame} for a \code{gtrend_scraper} object.
#' @details The trend is not an absolute trend but a relative index.  See:
#' \url{https://support.google.com/trends/answer/4355164?hl=en} for more.
#' @export
#' @examples
#' \dontrun{
#' out <- gtrend_scraper("tyler.rinker@@gmail.com", "password", c("cat", "dog bite"))
#' extract_trend(out)
#' extract_trend(out[[1]])
#' }
extract_trend <- function(x, ...) {
    
        UseMethod("extract_trend")

}

#' @export
#' @method extract_trend gtrend_scraper_element
#' @rdname extract_trend 
extract_trend.gtrend_scraper_element <- function(x, ...) {
    setNames(x[["trend"]], c("start", "end", "trend"))
}

#' @export
#' @method extract_trend gtrend_scraper
#' @rdname extract_trend 
extract_trend.gtrend_scraper <- function(x, ...) {
    lapply(x, extract_trend)
}








