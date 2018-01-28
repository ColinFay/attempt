#' Attempt
#'
#' Wrappers around base try that allows you to set a custom message when an error/warning occurs.
#' \code{attempt} returns the value if there is no error nor message. \code{silent_attempt} stays
#' silent unless error or warning.
#'
#' @param expr the expression to be evaluated
#' @param msg the message to return if an error occurs
#' @param verbose wether or not to return to expression producing the error
#' @param silent wether or not the error should be kept under silence
#'
#' @importFrom rlang as_function
#'
#' @rdname attempt
#'
#' @examples
#'\dontrun{
#' attempt(log("a"), msg = "Nop !")
#'}
#' @export

attempt <- function(expr, msg = NULL, verbose = FALSE, silent = FALSE){
  res <- try_catch(expr,
                   .e = function(.x) return(.x),
                   .w = function(.x) return(.x))
  if (any( class(res) %in% c("error", "warning"))) {
    if (! is.null(msg)) {
      if(any(class(res) %in% c("error", "warning"))) res$message <- msg
    }
    if (! verbose) {
      if(any(class(res) %in% c("error", "warning"))) res$call <- NULL
    }
    if (! silent) {
      cat(paste(res), file = getOption("try.outFile", default = stderr()))
    }
    invisible(structure(paste(res), class = "try-error", condition = res))
  } else {
    res
  }
}

#' Silently
#'
#' silently returns a new function that will returns an error or a warning if any,
#' or else returns nothing.
#'
#' @param .f the function to silence
#'
#' @return an error if any, a warning if any. The result is never returned.
#' @export
#'
#' @examples
#' \dontrun{
#' silent_log <- silently(log)
#' silent_log(1)
#' silent_log("a")
#' }


silently <- function (.f) {
  .f <- as_function(.f)
  function(...) {
    res <- try(.f(...), silent = TRUE)
    if (class(res) == "try-error") {
      cat(paste(res), file = getOption("try.outFile", default = stderr()))
      return(invisible(structure(paste(res), class = "try-error", condition = res)))
    }
  }
}

#' surely
#'
#' Wrap a function in a try
#'
#' @param .f the function to wrap
#'
#' @return an error if any, a warning if any, the result if any
#' @export
#'
#' @examples
#' \dontrun{
#' sure_log <- surely(log)
#' sure_log(1)
#' sure_log("a")
#' }

surely <- function (.f) {
  .f <- as_function(.f)
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

silent_attempt <- silently(~ attempt(expr = .x, silent = TRUE))

#' Add a message or warning to a function
#'
#' @param .f the function to wrap
#' @param msg the message to print
#'
#' @return a function
#' @export
#'
#' @rdname messagefunctions
#'
#' @examples
#' msg_as_num <- with_message(as.numeric, msg = "Numeric conversion")
#' warn_as_num <- with_warning(as.numeric, msg = "Numeric conversion")

with_message <- function (.f, msg) {
  .f <- as_function(.f)
  function(...) {
    message(msg)
    attempt(.f(...))
  }
}

#' @export
#'
#' @rdname messagefunctions
#'
with_warning <- function (.f, msg) {
  .f <- as_function(.f)
  function(...) {
    warning(msg)
    attempt(.f(...))
  }
}
