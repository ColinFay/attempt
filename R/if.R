#' If this, then do that
#'
#' @param .x the object to test
#' @param .p the predicate for testing
#' @param .f what to do if TRUE
#'
#' @return the result in .f
#' @export
#'
#' @examples
#' a <- if_then(1, is.numeric, ~ return("Yay"))

if_then <- function(.x, .p, .f) {
  if (is_formula(.f)){
    .f <- as_mapper(.f)
  } else {
    .f <- enexpr(.f)
  }
  if ( as_mapper(.p)(.x) ){
      .f()
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

if_all <- function(.l, .p, .f){
  res <- map_lgl(.l, ~ build_and_eval(.p, .x)) %>% all()
  if(res) as_mapper(.f)()
}

#' @export
#'
#' @rdname if

if_any <- function(.l, .p, .f){
  res <- map_lgl(.l, ~ build_and_eval(.p, .x)) %>% any()
  if(res) as_mapper(.f)()
}

#' @export
#'
#' @rdname if

if_none <- function(.l, .p, .f){
  res <- map_lgl(.l, ~ build_and_eval(negate(.p), .x)) %>% all()
  if(res) as_mapper(.f)()
}

