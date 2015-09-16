#' @export
parsetidy <- function(x, ...) UseMethod("parsetidy")


#' @export
parsetidy.default <- function(x, ...) {
  # if it's not a call or name (e.g. it's numeric),
  # don't need it
  data.frame()
}


#' @export
parsetidy.expression <- function(x, ...) {
  names(x) <- seq_along(x)
  plyr::ldply(x, parsetidy, .id = "statement", ...)
}


#' @export
parsetidy.call <- function(x, blacklist = c(), ...) {
  if (as.character(x[[1]]) %in% blacklist) {
    return(data.frame())
  }

  ret <- plyr::ldply(x, parsetidy, blacklist = blacklist, ...)
  ret$is_function[1] <- TRUE
  ret
}


#' @export
parsetidy.name <- function(x, env = parent.frame(), ...) {
  ch <- as.character(x)
  envname <- tryCatch(environmentName(pryr::where(ch, env)),
                      error = function(e) NA)

  data.frame(name = as.character(x),
             is_function = FALSE,
             environment = envname,
             assignment = FALSE,
             stringsAsFactors = FALSE)
}


#' @export
`parsetidy.<-` <- function(x, ...) {
  ret <- parsetidy.call(x)[-1, ]
  if (inherits(x[[2]], "name")) {
    ret$assignment[1] <- TRUE
  }
  ret
}


#' @export
`parsetidy.{` <- function(x, ...) {
  ret <- parsetidy.expression(x[-1])
  ret$statement <- NULL
  ret
}
