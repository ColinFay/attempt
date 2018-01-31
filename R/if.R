#' If this, then that
#'
#' @param .x the object to test. If \code{NULL} (the default), only .p is evaluated.
#' @param .p the predicate for testing. Defaut is \code{isTRUE}.
#' @param .f a mapper or a function run if .p(.x) is TRUE
#' @param .else a mapper or a function run if .p(.x) is not TRUE
#'
#' @note If you want these function to return a value,
#'   you need to wrap these values into a mapper / a function. E.g, to return
#'   a vector, you'll need to write \code{if_then(1, is.numeric, ~ "Yay")}.
#'
#' @importFrom rlang as_function
#'
#' @return Depending on wether or not .p(.x) is TRUE, .f() or .else() is run.
#' @export
#'
#' @rdname ifthenelse
#'
#' @examples
#' a <- if_then(1, is.numeric, ~ "Yay")
#' a <- if_not(1, is.character, ~ "Yay")
#' a <- if_else(.x = TRUE, .f = ~ "Yay", .else = ~ "Nay")

if_then <- function(.x, .p = isTRUE, .f) {
  if ( as_function(.p)(.x) ) as_function(.f)()
}

#' @export
#' @rdname ifthenelse

if_not <- function(.x, .p = isTRUE, .f) {
  if ( ! as_function(.p)(.x) ) as_function(.f)()
}

#' @export
#' @rdname ifthenelse

if_else <- function(.x, .p = isTRUE, .f, .else) {
  if ( as_function(.p)(.x) ) {
    as_function(.f)()
  } else {
    as_function(.else)()
  }
}

#' Test for all, any or none
#'
#' @param .l the list to test.
#' @param .p the predicate for testing. Defaut is \code{isTRUE}.
#' @param .f a mapper or a function run if .p(.x) is TRUE.
#'
#' @return If .p(.x) is TRUE, .f() is run.
#' @export
#'
#' @rdname scopedif
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
#' @rdname scopedif

if_any <- function(.l, .p = isTRUE, .f){
  res <- any( sapply(.l, as_function(.p) )  )
  if(res) as_function(.f)()
}

#' @export
#'
#' @rdname scopedif

if_none <- function(.l, .p = isTRUE, .f){
  res <- any( sapply(.l, Negate(as_function(.p)) )  )
  if(res) as_function(.f)()
}
