#' @title Try Catch
#'
#' @description Friendlier try catch functions
#'
#' @details try_catch handles errors and warning the way you specify. try_catch_df
#' returns a tibble with the call, the error message if any, the warning message if
#' any, and the value of the evaluated expression.
#'
#' @export
#'
#' @param expr for simple try catch, the expression to be evaluated
#' @param l for map_* function, a list of arguments
#' @param fun for map_* function, a function to try with the list \code{l}
#' @param .e a one side formula or a function evaluated when an error occurs
#' @param .w a one side formula or a function evaluated when a warning occurs
#' @param .f a one side formula or an expression evaluated before returning or exiting
#'
#' @importFrom purrr as_mapper map
#' @importFrom rlang eval_tidy quo f_rhs enexpr lang is_formula splice chr_along
#' @importFrom tibble tibble

#' @rdname try_catch
#'
#' @examples
#' \dontrun{
#' try_catch(log("a"), .e = ~ paste0("There was an error: ", .x))
#' }

try_catch <- function(expr, .e = NULL, .w = NULL, .f = NULL) {
  args <- list(enexpr(expr))
  if ( !is.null(.e) ) {
    if ( ! is_formula(.e) )
      args <- c(args, error = .e)
    else
      args <- c(args, error = as_mapper(eval(.e)))
  }
  if ( !is.null(.w) ) {
    if ( ! is_formula(.w) )
      args <- c(args, warning = .w)
    else
      args <- c(args, warning = as_mapper(eval(.w)))
  }
  if ( !is.null(.f) ) {
    if ( ! is_formula(.f) )
      eval(.f)
    else
      eval_tidy(quo(!!f_rhs(.f)))
  }
  eval(lang("tryCatch", splice(args)))
}

#' @rdname try_catch
#' @export

try_catch_df <- function(expr){
  call <- enexpr(expr)
  default <- tibble::tibble(call = quo_text(call),
                            error = chr_along(call),
                            warning = chr_along(call),
                            value = chr_along(call))
  a <- tryCatch(eval(expr),
                error = function(err){
                  default$error <<- err$message
                  return("error")
                },
                warning = function(war){
                  default$warning <<- war$message
                  return(suppressWarnings(eval(expr)))
                }
  )
  default$value <- list(a)
  return(default)
}

#' @rdname try_catch
#' @export

map_try_catch <- function(l, fun, .e = NULL, .w = NULL, .f = NULL) {

  map(l, ~ eval(try_catch_builder(.x, fun, .e = .e, .w = .e, .f = .f)))

}

#' @rdname try_catch
#' @export

map_try_catch_df <- function(l, fun) {
  # map_df requires dplyr, which is not imported
  # that creates an error on travis
  do.call(rbind, lapply(l, function(x) eval(try_catch_df_builder(x, fun))))

}


#' Try that
#'
#' A wrapper around base try that allows you to set a custom message when an error occurs
#'
#' @param expr the expression to be evaluated
#' @param msg the message to return if an error occurs
#' @param verbose wether or not to return to expression producing the error
#'
#' @importFrom rlang is_null
#'
#' @examples
#'\dontrun{
#' try_that(log("a"), msg = "Nop !")
#'}
#' @export

try_that <- function(expr, msg = NULL, verbose = FALSE){
  call <- quo_text(enquo(expr))
  tryCatch(expr,
            error = function(e) {
              if(is_null(msg)) {
                if (verbose) {
                  msg <- paste("Error in", call, ":", conditionMessage(e))
                } else {
                  msg <- paste("Error :", conditionMessage(e))
                }
              } else {
                if (verbose) {
                  msg <- paste("Error in", call, ":", msg)
                } else {
                  msg <- paste("Error :", msg)
                }
              }
              cat(msg, file = getOption("try.outFile", default = stderr()))
            })
}
