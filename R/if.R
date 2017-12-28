#' If this, then that
#'
#' @param .x the object to test
#' @param .p the predicate for testing. Defaut is \code{isTRUE}
#' @param .f what to do if TRUE
#'
#' @return the result in .f
#' @export
#'
#' @examples
#' a <- if_then(1, is.numeric, ~ return("Yay"))

if_then <- function(.x, .p = isTRUE, .f) {
  if ( as_function(.p)(.x) ){
    if (is_formula(.f)){
      .f <- as_function(.f)
    } else {
      .f <- enexpr(.f)
    }
    .f()
  }
}

#' If this, then that, else that
#'
#' @param .x the object to test
#' @param .p the predicate for testing. Defaut is \code{isTRUE}
#' @param .f what to do if TRUE
#' @param .else what to do if TRUE
#'
#' @return the evalution
#' @export
#'
#' @examples
#' a <- if_else(1, is.numeric, ~ return("Yay"), ~ return("Nay"))

if_else <- function(.x, .p = isTRUE, .f, .else) {
  if ( as_function(.p)(.x) ){
    if (is_formula(.f)){
      .f <- as_function(.f)
    } else {
      .f <- enexpr(.f)
    }
    .f()
  } else {
    if (is_formula(.else)){
      .else <- as_function(.else)
    } else {
      .else <- enexpr(.else)
    }
    .else()
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
  res <- all( flatten_lgl(lapply(.l, as_function(~ build_and_eval(.p, .x)))) )
  if(res) as_function(.f)()
}

#' @export
#'
#' @rdname if

if_any <- function(.l, .p = isTRUE, .f){
  res <- any( flatten_lgl(lapply(.l, as_function(~ build_and_eval(.p, .x)))) )
  if(res) as_function(.f)()
}

#' @export
#'
#' @rdname if

if_none <- function(.l, .p = isTRUE, .f){
  res <- any( flatten_lgl(lapply(.l,
                                 as_function(~ build_and_eval(Negate(as_function(.p)), .x)))) )
  if(res) as_function(.f)()
}
