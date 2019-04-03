#' Is the element of class "try-error"?
#'
#' @param .x the object to test
#'
#' @return A logical
#' @export
#'
#' @examples
#' x <- attempt(log("a"), silent = TRUE)
#' is_try_error(x)
#'
is_try_error <- function(.x){
  any(
    vapply(class(.x), function(x) x == "try-error", logical(1))
  )
}
