#' @importFrom rlang call2

try_catch_builder <- function(arg, fun, ...) {
  a <- call2(
    fun,
    !!!(list(arg))
  )
  call2(
    "try_catch",
    !!!(list(expr = a, ...))
  )
}

try_catch_df_builder <- function(arg, fun, ...) {
  a <- call2(
    fun,
    !!!(list(arg))
  )
  call2(
    "try_catch_df",
    !!!(list(expr = a, ...))
  )
}
