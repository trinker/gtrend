#' Title
#' 
#' Description
#' 
#' @param username
#' @param password
#' @param phrases
#' @param cores
#' @return
#' @references
#' @keywords
#' @export
#' @seealso
#' @examples
gtrend_scraper <- function(username, password, phrases, cores = parallel::detectCores()/2){

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
            out 
        }
    ), phrases)  
    output
}


