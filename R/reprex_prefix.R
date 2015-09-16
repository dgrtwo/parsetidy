#' Create a reproducible prefix for some code that loads the necessary
#' packages and defines variables
#'
#' @param code Code as a character vector
#'
#' @export
reprex_prefix <- function(code) {
  used <- vars_used(parse(text = code))

  if (length(used$undefined) > 0) {
    message("The following variables were not found and not included ",
            "in the prefix: ",
            paste(used$undefined, collapse = ", "))
  }

  if (length(used$packages) > 0) {
    ret1 <- paste0("library(", used$packages, ")")
  } else {
    ret1 <- c()
  }

  ret2 <- define_vars_(used$vars)

  c(ret1, ret2)
}
