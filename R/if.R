#' If this, then that
#'
#' @param .x the object to test. If \code{NULL} (the default), only .p is evaluated.
#' @param .p the predicate for testing. Defaut is \code{isTRUE}.
#' @param .f what to do if TRUE
#'
#' @importFrom rlang as_function
#'
#' @return the result in .f
#' @export
#'
#' @examples
#' a <- if_then(1, is.numeric, ~ return("Yay"))
#'
if_then <- function(.x, .p = isTRUE, .f) {
  if ( as_function(.p)(.x) ) as_function(.f)()
}

#' If this, then that, else that
#'
#' @param .x the object to test. If \code{NULL} (the default), only .p is evaluated.
#' @param .p the predicate for testing. Defaut is \code{isTRUE}.
#' @param .f what to do if TRUE
#' @param .else what to do if TRUE
#'
#' @return the evalution
#' @export
#'
#' @examples
#' \dontrun{
#' a <- if_else(.x = curl::has_internet(), .f = ~ "Yay", .else = ~ "Nay")
#' }
#'

if_else <- function(.x, .p = isTRUE, .f, .else) {
  if ( as_function(.p)(.x) ) {
    as_function(.f)()
  } else {
    as_function(.else)()
  }
}

#' Test for all, any or none
#'
#' @param .l the list to test
#' @param .p the predicate for testing
#' @param .f what to do if TRUE
#'
#' @return the result in .f
#' @export
#'
#' @rdname if
#' @examples
#' if_all(1:10, ~ .x < 11, ~ return(letters[1:10]))
#' if_any(1:10, is.numeric, ~ return(letters[1:10]))
#' if_none(1:10, is.numeric, ~ return(letters[1:10]))

if_all <- function(.l, .p = isTRUE, .f){
  res <- all( sapply(.l, as_function(.p) )  )
  if(res) as_function(.f)()
}

#' @export
#'
#' @rdname if

if_any <- function(.l, .p = isTRUE, .f){
  res <- any( sapply(.l, as_function(.p) )  )
  if(res) as_function(.f)()
}

#' @export
#'
#' @rdname if

if_none <- function(.l, .p = isTRUE, .f){
  res <- any( sapply(.l, Negate(as_function(.p)) )  )
  if(res) as_function(.f)()
}
