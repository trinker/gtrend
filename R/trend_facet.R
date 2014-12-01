#' Faceted Trend Plot
#' 
#' This function creates a \code{data.frame} of the class \code{trend_facet}, 
#' which has its own plot method which is a faceted plot.
#' 
#' @param x A \code{trend2long} or \code{gtrend_scraper} object.
#' @param \ldots ignored.
#' @export
#' @examples
#' \dontrun{
#' library(dplyr)
#' (out <- gtrend_scraper("tyler.rinker@@gmail.com", "password", "dog bite"))
#' 
#' trend_facet(out) %>% 
#'    plot 
#' 
#' plotflow::unbalanced_facet_axis(trend_facet(out) %>% 
#'     plot(ncol=3))
#' 
#' plotflow::unbalanced_facet_axis(trend_facet(out) %>% 
#'     plot(rect.alpha=.4))
#' 
#' 
#' library(dplyr)
#' out <- gtrend_scraper("tyler.rinker@@gmail.com", "password", 
#'     c("ebola", "sars", "hiv", "aids", "influenza", "flu", "the cold"))
#' 
#' trend2long(out) %>%
#'    plot() 
#' 
#' trend2long(out) %>%
#'    trend_facet %>%
#'    plot
#' 
#' out %>%
#'    trend_facet %>%
#'    plot
#' }
trend_facet <- function(x, ...){

    `%>%` <- dplyr::`%>%`

    if (!inherits(x, "trend2long")) {
    output <- x %>%
        trend2long()    
    } else {
       output <- x
    }
    class(output) <- c("trend_facet", class(output))
    
    start <- end <- year <- NULL
    
    attributes(output)[["rects"]] <- output %>%
        dplyr::mutate(year=format(as.Date(start), "%y")) %>%
        dplyr::group_by(year) %>%
        dplyr::summarize(xstart = as.Date(min(start)), xend = as.Date(max(end)))

    output
}
 

#' Plots a trend_facet Object
#' 
#' Plots a trend_facet object.
#' 
#' @param x The trend_facet object.
#' @param rect.alpha The alpha level of the rectangles in the year plot 
#' background.
#' @param ncol The number of facet columns.
#' @param \ldots Other arguments passed to 
#' \code{\link[plotflow]{unbalanced_facet_axis}}.
#' @method plot trend_facet
#' @export
plot.trend_facet <- function(x, rect.alpha = .025, ncol = 2, ...){

    `%>%` <- dplyr::`%>%`

    reqcheck <- require("plotflow")

    if (!reqcheck) {

        message("plotflow package not found.\nShould I attemt to get from GitHub?")
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            devtools::install_bitbucket("trinker/plotflow")
        }
        reqcheck <- require("plotflow")
        if (!reqcheck) stop("Could not load or install plotflow package")
    }    
    
    xstart <- xend <- year <- trend <- term <- year <- NULL
    ggplot_obj <- x %>%
        ggplot2::ggplot() + ggplot2::theme_bw() +
            ggplot2::geom_rect(data = attributes(x)[["rects"]], 
                ggplot2::aes(xmin = xstart, 
                xmax = xend, ymin = -Inf, ymax = Inf, fill = factor(year)), 
                alpha = rect.alpha) +
            ggplot2::geom_vline(data = attributes(x)[["rects"]], 
                alpha=.1, ggplot2::aes(xintercept=as.numeric(xend))) +
            ggplot2::geom_line(ggplot2::aes(x=start, y=trend, color=term)) +
            ggplot2::facet_wrap(~term, ncol=ncol) +
            ggplot2::guides(color=FALSE, fill=FALSE) +
            ggplot2::stat_smooth(ggplot2::aes(x=start, y=trend, color=term)) +
            ggplot2::scale_x_date(breaks = "1 year", 
                labels = scales::date_format("%y"), expand = c(0,0)) +
            ggplot2::xlab("Year") +
            ggplot2::ylab("Relative Trend")

    print(plotflow::unbalanced_facet_axis(ggplot_obj, ...))

    invisible(ggplot_obj)
}


