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


#' Attempt
#'
#' Wrappers around base try that allows you to set a custom message when an error/warning occurs.
#' \code{attempt} returns the value if there is no error nor message. \code{silent_attempt} stays
#' silent unless error or warning.
#'
#' @param expr the expression to be evaluated
#' @param msg the message to return if an error occurs
#' @param verbose wether or not to return to expression producing the error
#'
#' @importFrom rlang is_null
#'
#' @rdname attempt
#'
#' @examples
#'\dontrun{
#' attempt(log("a"), msg = "Nop !")
#'}
#' @export

attempt <- function(expr, msg = NULL, verbose = FALSE){
  res <- try_catch(expr,
                   .e = ~ return(.x),
                   .w = ~ return(.x))
  if (! rlang::is_null(msg)) {
    if(any(class(res) %in% c("error", "warning"))) res$message <- msg
  }
  if (! verbose) {
    if(any(class(res) %in% c("error", "warning"))) res$call <- NULL
  }
  cond <- map_lgl(class(res), ~ .x %in% c("error", "warning")) %>% any()
  if (cond) {
    cat(paste(res), file = getOption("try.outFile", default = stderr()))
    return(invisible(structure(res, class = "try-error")))
  } else {
    res
  }

}

#' Silently
#'
#' silently returns an error or a warning if any,
#' else returns nothing.
#'
#' @param .f the function to silence
#'
#' @return an error if any, a warning if any.
#' @export
#'
#' @examples
#' \dontrun{
#' silent_log <- silently(log)
#' silent_log(1)
#' silent_log("a")
#' }

silently <- function (.f) {
  .f <- as_mapper(.f)
  function(...) {
    res <- try_catch(!! .f(...),
              ~ return(.x),
              ~ return(.x))
    if_any(class(res),
           ~ .x %in% c("error", "warning"),
           ~ return(res))
    }
}

surely <- function (.f) {
  .f <- as_mapper(.f)
  function(...) {
    attempt(.f(...))
    }
}

#' Silently attempt
#'
#' A wrapper around silently and attempt
#'
#' @param ... the expression to evaluate
#'
#' @return an error if any, a warning if any.
#' @export
#'
#' @examples
#' \dontrun{
#' silent_attempt(warn("nop!"))
#' }

silent_attempt <- silently(attempt)
