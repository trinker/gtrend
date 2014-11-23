#' Grab Google Trend Data
#' 
#' A function to grab \href{http://www.google.com/trends/}{Google Trend} data 
#' using the \pkg{GTrendsR} package \url{https://github.com/dvanclev/GTrendsR}.
#' 
#' @param username Your Gmail/Google name (e.g., \code{tyler.rinker@@gmail.com}).
#' @param password Your Gmail/Google password.
#' @param phrases A character vector of phrases to look up.
#' @param geo A locations to search within.
#' @return Returns a list of lists (one list for each search term):
#' \item{query}{A character... }
#' \item{meta}{A character... }
#' \item{trend}{A data.frame... }
#' \item{regions}{A list... }
#' \item{topmetros}{A list... }
#' \item{cities}{A list... }
#' \item{searches}{A list... }
#' \item{rising}{A list... }
#' \item{headers}{A character... }
#' @references \url{https://github.com/dvanclev/GTrendsR} 
#' \url{http://www.google.com/trends}
#' @export
#' @examples
#' \dontrun{
#' gtrend_scraper("tyler.rinker@@gmail.com", "password", "dog bite")
#' }
gtrend_scraper <- function(username, password, phrases, geo = "US"){

    reqcheck <- require("GTrendsR")

    if (!reqcheck) {

        message("GTrendsR package not found.\nShould I attemt to get from GitHub?")
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            devtools::install_bitbucket("persican/gtrendsr")
        }
        reqcheck <- require("GTrendsR")
        if (!reqcheck) stop("Could not load or install GTrendsR package")
    }

    ch <- GTrendsR::gconnect(username, password)
    phrases <- gsub("\\s+", "\\+", gsub("[-,]", " ", phrases))

    output <- setNames(lapply(phrases, function(x) {
            out <- try(gtrends(ch, query = x , geo = geo))
            if (inherits(out, "try-error")) return(NULL)
            class(out ) <- "gtrend_scraper_element"
            out
        }
    ), phrases)  
    class(output) <- "gtrend_scraper"
    output
}


