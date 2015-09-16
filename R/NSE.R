#' For the code that created this, see the examples
#'
#' Character vector of functions in dplyr
#'
#' @examples
#'
#' library("dplyr")
#' funcs <- ls("package:dplyr")
#' ret <- funcs[grepl(".*_$", funcs)]
#' dput(gsub("_$", "", ret))
dplyr_NSE <- c("arrange", "count", "data_frame", "distinct", "do", "filter",
               "funs", "group_by", "group_indices", "mutate", "mutate_each",
               "rename", "rename_vars", "select", "select_vars", "slice", "summarise",
               "summarise_each", "summarize", "transmute")

built_in_envs <- c("base", "package:stats", "package:datasets",
              "package:graphics", "package:grDevices",
              "package:utils")


