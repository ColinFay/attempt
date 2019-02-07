#' Add a function to be run on error
#'
#' This function behaves as `on.exit()`, but is run on error, and supports mappers.
#'
#' @param f a function to call on error
#'
#' @return A local error handler.
#' @export
#'
#' @examples
#'
#' y <- function(num){
#'   on_error(~ write( Sys.time(), "error_log.txt", append = TRUE) )
#'   log(num)
#'}
#'
on_error <- function(f){

  f <- rlang::as_function(f)

  old <- do.call(options, as.list( c("error" = f) ))

  do.call(
    options,
    list("error" = f),
    envir = parent.frame()
  )

  do.call(
    on.exit,
    list(substitute(options(old)),
         add = TRUE),
    envir = parent.frame()
  )

}
