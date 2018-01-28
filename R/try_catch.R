#' @title Try Catch
#'
#' @description Friendlier try catch functions
#'
#' @details try_catch handles errors and warnings the way you specify. try_catch_df
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
#' @importFrom rlang lang splice as_function
#' @rdname try_catch
#'
#' @examples
#' \dontrun{
#' try_catch(log("a"), .e = ~ paste0("There was an error: ", .x))
#' try_catch(log(1), .f = ~ print("finally"))
#' try_catch(log(1), .f = function() print("finally"))
#' }

try_catch <- function(expr, .e = NULL, .w = NULL, .f = NULL) {
  args <- list(substitute(expr))
  if ( !is.null(.e) ) {
    args <- c(args, error = as_function(.e))
  }
  if ( !is.null(.w) ) {
    args <- c(args, warning = as_function(.w))
  }
  if ( !is.null(.f) ) {
    as_function(.f)()
  }
  eval(lang("tryCatch", splice(args)))
}

#' @rdname try_catch
#' @export

try_catch_df <- function(expr){
  default <- list(call = deparse(substitute(expr)),
                  error = NA,
                  warning = NA,
                  value = NA)
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
  structure(default, .Names = c("call", "error", "warning", "value"),
            class = c("tbl_df", "tbl", "data.frame"), row.names = c(NA, -1L))
}

#' @rdname try_catch
#' @export

map_try_catch <- function(l, fun, .e = NULL, .w = NULL, .f = NULL) {

  lapply(l, as_function(~ eval(try_catch_builder(.x, fun, .e = .e, .w = .e, .f = .f))))

}

#' @rdname try_catch
#' @export

map_try_catch_df <- function(l, fun) {
  do.call(rbind, lapply(l, function(x) eval(try_catch_df_builder(x, fun))))
}


