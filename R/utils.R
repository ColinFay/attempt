#' @importFrom rlang eval_tidy quo_text

build_and_eval <- function(f, args) {
  args <- enquo(args)
  if (quo_text(args) == ".") {
    as_function(f)()
  } else {
    as_function(f)(eval_tidy(args))
  }
}

try_catch_builder <- function(arg, fun, ...){
  a <- lang(fun, splice(list(arg)))
  lang("try_catch", splice(list(expr = a, ...)))
}

try_catch_df_builder <- function(arg, fun, ...){
  a <- lang(fun, splice(list(arg)))
  lang("try_catch_df", splice(list(expr = a, ...)))
}


