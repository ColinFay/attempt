#' If this, then do that
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
  if (is_formula(.f)){
    .f <- as_mapper(.f)
  } else {
    .f <- enexpr(.f)
  }
  if ( as_mapper(.p)(.x) ){
      .f()
  }
}

#' If this, then do that
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
  if (is_formula(.f)){
    .f <- as_mapper(.f)
  } else {
    .f <- enexpr(.f)
  }
  if (is_formula(.else)){
    .else <- as_mapper(.else)
  } else {
    .else <- enexpr(.else)
  }
  if ( as_mapper(.p)(.x) ){
      .f()
  } else {
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
  res <- map_lgl(.l, ~ build_and_eval(.p, .x)) %>% all()
  if(res) as_mapper(.f)()
}

#' @export
#'
#' @rdname if

if_any <- function(.l, .p = isTRUE, .f){
  res <- map_lgl(.l, ~ build_and_eval(.p, .x)) %>% any()
  if(res) as_mapper(.f)()
}

#' @export
#'
#' @rdname if

if_none <- function(.l, .p = isTRUE, .f){
  res <- map_lgl(.l, ~ build_and_eval(negate(.p), .x)) %>% all()
  if(res) as_mapper(.f)()
}

