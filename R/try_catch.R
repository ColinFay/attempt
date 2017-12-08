#' Try Catch 
#' 
#' A friendlier try catch function 
#' 
#' @export
#' 
#' @param ... the expression to be evaluated 
#' @param .e a one side formula or a function evaluated when an error occurs
#' @param .w a one side formula or a function evaluated when a warning occurs
#' @param .f a one side formula or an expression evaluated before returning or exiting
#' 
#' @importFrom purrr as_mapper is_formula
#' @importFrom rlang eval_tidy quo f_rhs
#' 
#' @examples
#' 
#' try_catch(log("a"), .e = ~ paste0("There was an error: ", .x))

try_catch <- function(..., .e = ~ NULL, .w = ~ NULL, .f = ~ NULL) {
  tryCatch( ...,
    error = as_mapper(.e),
    warning = as_mapper(.w),
    finally = if (is_formula(.f)) {
      eval_tidy(quo(!!f_rhs(.f)))
    } else {
      eval(.f)
    }
  )
}

