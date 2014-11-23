#' extract_trend List Output to Long Format
#' 
#' Reshape a extract_trend list output to long format with a term colun added.
#' 
#' @param x An extract_trend list output.
#' @param \ldots Currently ignored.
#' @return returns a \code{data.frame} of trend data by lookup terms.
#' @export
#' @rdname trend2long
#' @examples
#' \dontrun{
#' library(dplyr)
#' out <- gtrend_scraper("tyler.rinker@@gmail.com", "password", 
#'     c("ebola", "sars", "hiv", "aids", "influenza", "flu", "the cold"))
#' 
#' as.zoo.gtrends(out[[1]])
#' 
#' trend2long(out) %>%
#'    plot
#' 
#' library(dplyr)
#' trend2long(out) %>%
#'    filter(term %in% c("hiv", "ebola", "sars")) %>%
#'    as.trend2long %>%
#'    plot 
#'    
#' library(ggplot2)
#' trend2long(out) %>%
#'     ggplot(aes(x=start, y=term, fill=trend)) +
#'     geom_tile() +
#'     scale_fill_gradient(low="black", high="white") +
#'     scale_x_date(expand = c(0, 0)) +
#'     theme_bw() + xlab("time")
#' }
trend2long <- function(x, ...) {
    dat <- qdapTools::list_df2df(lapply(x, extract_trend), "term")
    class(dat) <- c("trend2long", class(dat))
    dat
}


#' Plots a trend2long Object
#' 
#' Plots a trend2long object.
#' 
#' @param x The trend2long object.
#' @param size The line size of the trend line.
#' @param \ldots ignored
#' @method plot trend2long
#' @export
plot.trend2long <- function(x, size = 1, ...){
    start <- trend <- term <- NULL
    ggplot2::ggplot(x, ggplot2::aes(x=start, y=trend, color=term, group=term)) +
        ggplot2::geom_line(size=size) + 
        ggplot2::xlab("Time") + 
        ggplot2::ylab("Relative Trend") +
        ggplot2::scale_color_discrete(name="Term")
}

#' Coerce a data.frame to a \code{trend2long} object.
#' 
#' Coerce a data.frame to a \code{trend2long} object.
#' 
#' @return Returns a a \code{trend2long} object.
#' @note There is no object checking.  It is the user's responsibility to make 
#' sure the object being coerced correspondes to a \code{trend2long} object.
#' @export
#' @rdname trend2long
as.trend2long <- function(x, ...){
    class(x) <- c("trend2long", class(x))
    x
}

