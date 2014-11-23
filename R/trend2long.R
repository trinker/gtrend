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
#' @rdname trend2long
#' @examples
trend2long <- function(x, ...) {
    dat <- list_df2df(lapply(x, extract_trend), "term")
    class(dat) <- c("trend2long", class(dat))
    dat
}


#' Plots a trend2long Object
#' 
#' Plots a trend2long object.
#' 
#' @param x The trend2long object.
#' @param \ldots ignored
#' @method plot trend2long
#' @export
plot.trend2long <- function(x, ...){
    ggplot::ggplot(x, aes(x=start, y=trend, color=term, group=term)) +
        ggplot::geom_line(size=1) 
}

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
#' @rdname trend2long
#' @examples
as.trend2long <- function(x, ...){
    class(x) <- c("trend2long", class(x))
    x
}

