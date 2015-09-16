#' Retrieve variables and packages used in an expression
#'
#' @param expr An expression object
#'
#' @import dplyr
#'
#' @export
vars_used <- function(expr) {
  td <- parsetidy(expr, blacklist = c("aes", "~", dplyr_NSE))

  # remove cases where a variable is assigned within code
  processed <- td %>%
    filter(!(environment %in% built_in_envs)) %>%
    group_by(name) %>%
    filter(!assignment[1]) %>%
    ungroup()

  packages <- processed %>%
    filter(stringr::str_detect(environment, "^package:")) %>%
    .$environment %>%
    unique() %>%
    stringr::str_replace("package:", "")

  undefined <- processed %>%
    filter(is.na(environment)) %>%
    .$name %>%
    unique()

  vars <- processed %>%
    filter(!stringr::str_detect(environment, "^package:"),
           !is.na(environment)) %>%
    .$name %>%
    unique()

  list(vars = vars, undefined = undefined, packages = packages)
}
