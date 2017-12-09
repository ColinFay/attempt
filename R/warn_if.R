#' Warn if
#'
#' Friendlier messaging functions
#'
#' @export
#'
#' @param .x the element to evaluate
#' @param .p the predicate with the condition to test on \code{.x}.
#' @param msg the message to return. If NULL (default), the built-in message is printed.
#'
#' @importFrom rlang quo_text enquo is_null
#' @importFrom purrr as_mapper negate
#'
#' @rdname messagehandler
#'
#' @examples
#' \dontrun{
#' x <- 12
#' stop_if(x, is.numeric)
#' stop_if_not(x, is.character)
#'
#' a  <- "this is not numeric"
#' warn_if(a,  is.character )
#' warn_if_not(a, is.numeric )
#' b  <- 20
#' warn_if(b ,  ~ . > 10 ,
#'          msg = "Wow, that's a lot of b")
#'c <- "a"
#' message_if(c, is.character,
#'          msg = "You entered a character element")
#' }


stop_if <- function(.x, .p, msg = NULL){
  test <- quo_text(enquo(.p))
  x <- enquo(.x)
  if ( (as_mapper(.p)(.x)) )
    if (is_null(msg)) {
      stop(paste0( "Test `", test, "` on `", quo_text(x), "` returned an error."), call. = FALSE)
    } else {
      stop(msg, call. = FALSE, immediate. = TRUE)
    }
}

#'@export
#'@rdname messagehandler

stop_if_not <- function(.x, .p, msg = NULL){
  test <- quo_text(enquo(.p))
  x <- enquo(.x)
  if ( negate(as_mapper(.p))(.x)  )
    if (is_null(msg)) {
      stop(paste0( "Test `", test, "` on `", quo_text(x), "` returned an error."), call. = FALSE)
    } else {
      stop(msg, call. = FALSE)
    }
}


#'@export
#'@rdname messagehandler

warn_if <- function(.x, .p, msg = NULL){
  test <- quo_text(enquo(.p))
  x <- enquo(.x)

  if ( (as_mapper(.p)(.x)) )
    if (is_null(msg)) {
      warning(paste0( "Test `", test, "` on `", quo_text(x), "` returned a warning."), call. = FALSE, immediate. = TRUE)
    } else {
      warning(msg, call. = FALSE, immediate. = TRUE)
    }
}

#'@export
#'@rdname messagehandler

warn_if_not <- function(.x, .p, msg = NULL){
  test <- quo_text(enquo(.p))
  x <- enquo(.x)

  if ( negate(as_mapper(.p))(.x) )
    if (is_null(msg)) {
      warning(paste0( "Test `", test, "` on `", quo_text(x), "` returned a warning."), call. = FALSE, immediate. = TRUE)
    } else {
      warning(msg, call. = FALSE, immediate. = TRUE)
    }
}
#'@export
#'@rdname messagehandler

message_if <- function(.x, .p, msg = NULL){
  test <- quo_text(enquo(.p))
  x <- quo_text(enquo(.x))
  if ( (as_mapper(.p)(.x)) )
    if (is_null(msg)) {
      message(paste("Test `", test, "` on `", x, "` returned an alert."))
    } else {
      message(msg)
    }
}

#'@export
#'@rdname messagehandler

message_if_not <- function(.x, .p, msg = NULL){
  test <- quo_text(enquo(.p))
  x <- quo_text(enquo(.x))
  if ( negate(as_mapper(.p))(.x) )
    if (is_null(msg)) {
      message(paste("Test `", test, "` on `", x, "` returned an alert."))
    } else {
      message(msg)
    }
}

