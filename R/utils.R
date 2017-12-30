try_catch_builder <- function(arg, fun, ...){
  a <- lang(fun, splice(list(arg)))
  lang("try_catch", splice(list(expr = a, ...)))
}

try_catch_df_builder <- function(arg, fun, ...){
  a <- lang(fun, splice(list(arg)))
  lang("try_catch_df", splice(list(expr = a, ...)))
}


