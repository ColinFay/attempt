#' Try Catch
#'
#' A friendlier try catch function
#'
#' @export
#'
#' @param expr the expression to be evaluated
#' @param .e a one side formula or a function evaluated when an error occurs
#' @param .w a one side formula or a function evaluated when a warning occurs
#' @param .f a one side formula or an expression evaluated before returning or exiting
#'
#' @importFrom purrr as_mapper
#' @importFrom rlang eval_tidy quo f_rhs enexpr lang is_formula splice
#'
#' @examples
#'
#' try_catch(log("a"), .e = ~ paste0("There was an error: ", .x))

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
#'
#' try_that(log("a"), msg = "Nop !")
#'
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
