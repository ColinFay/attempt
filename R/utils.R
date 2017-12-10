#' @title Pipe operator
#'
#' @description See \code{magrittr::\link[magrittr]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

build_and_eval <- function(f, args) {
  as_mapper(f)(args)
}

try_catch_builder <- function(arg, fun, ...){
  a <- lang(fun, splice(list(arg)))
  lang("try_catch", splice(list(expr = a, ...)))
}

try_catch_df_builder <- function(arg, fun, ...){
  a <- lang(fun, splice(list(arg)))
  lang("try_catch_df", splice(list(expr = a, ...)))
}
