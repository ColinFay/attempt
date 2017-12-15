# library(rlang)
# library(purrr)
# if_then <- function(.x, .p, .f) {
#   if (is_formula(.f)){
#     .f <- as_mapper(.f)
#   } else {
#     .f <- enexpr(.f)
#   }
#   if ( as_mapper(.p)(.x) ){
#       .f()
#   }
# }
#
# if_then(1, is.numeric, ~ print("lol"))
# if_then(10, ~ .x > 2, ~ print("lol"))
# if_then(10, ~ .x > 2, print("lol"))
#
#
# if_all <- function(.x, .p, .f){
#   if (all(map_lgl(.x, .p))) {
#   }
# }
# (a <- if_all(1:10, is.numeric, curl::has_internet))
# (b <- if_all(1:10, is.numeric, ~ 2))
# (c <- if_all(1:10, is.numeric, function() print("x")))
# class(a)
# class(b)
# class(c)
#
# if_any <- function(.x, .p, .f){
#
# }
#
# if_none <- function(.x, .p, .f){
#
# }
