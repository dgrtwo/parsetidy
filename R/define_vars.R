#' This is a hack, still in progress
#'
#' @param varname Character vector of variable names to create definitions for
define_vars_ <- function(varnames) {
  dputs <- sapply(varnames, function(v) {
    txt <- eval(substitute(capture.output(dput(x)), list(x = parse(text = v)[[1]])))
    paste(txt, collapse = "\n")
  })

  paste(varnames, dputs, sep = " <- ")
}
