<!-- README.md is generated from README.Rmd. Please edit that file -->

[![Travis build
status](https://travis-ci.org/ColinFay/attempt.svg?branch=master)](https://travis-ci.org/ColinFay/attempt)
[![Coverage
status](https://codecov.io/gh/ColinFay/attempt/branch/master/graph/badge.svg)](https://codecov.io/github/ColinFay/attempt?branch=master)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/ColinFay/attempt?branch=master&svg=true)](https://ci.appveyor.com/project/ColinFay/attempt)

# {attempt} 0.1.0

A Friendlier Condition Handler for R, inspired by {purrr} mappers and
based on {rlang}.

{attempt} is designed to handle the cases when something / someone
attempts to do something it shouldn’t.

For example :

  - an attempt to run a `log("a")` (error)
  - an attempt to connect to a web API without an internet connexion
    running (error)
  - an attempt to `paste()` `"good morning` and `iris` (message/warning)
  - …

{attempt} provides several condition handlers, from try catch to simple
message printing.

{attempt} only depends on {rlang}, making it easy to implement in other
package.

# Install

``` r
devtools::install_github("ColinFay/attempt")
```

# Reference

## attempt

`attempt` is a wrapper around base `try` that allows you to insert a
custom messsage on error.

``` r
library(attempt)
attempt(log("a"))
# Error: argument non numérique pour une fonction mathématique

attempt(log("a"), msg = "Nop !")
# Error: Nop !
```

You can make it verbose (i.e. returning the expression):

``` r
attempt(log("a"), msg = "Nop !", verbose = TRUE)
# Error in log("a"): Nop !
```

Of course the result is returned if there is one:

``` r
attempt(log(1), msg = "Nop !", verbose = TRUE)
# [1] 0
```

As with `try`, the result cant be saved as an error object :

``` r
a <- attempt(log("a"), msg = "Nop !", verbose = TRUE)
a
# [1] "Error in log(\"a\"): Nop !\n"
# attr(,"class")
# [1] "try-error"
# attr(,"condition")
# <simpleError in log("a"): Nop !>
```

## silent\_attempt

`silent_attempt` is a wrapper around `silently` (see further down for
more info) and `attempt`. It attempts to run the expr, stays silent if
the expression succeeds, and returns error or warnings if any.

``` r
silent_attempt(log("a"))
# Error: argument non numérique pour une fonction mathématique
silent_attempt(log(1))
```

## try catch

You can write a try catch with these params :

  - `expr` the expression to be evaluated
  - `.e` a one side formula or a function evaluated when an error occurs
  - `.w` a one side formula or a function evaluated when a warning
    occurs
  - `.f` a one side formula or an expression which is always evaluated
    before returning or exiting

### With mappers

``` r
try_catch(log("a"), 
          .e = ~ paste0("There is an error: ", .x), 
          .w = ~ paste0("This is a warning: ", .x))
#[1] "There is an error: Error in log(\"a\"): argument non numérique pour une fonction mathématique\n"

try_catch(log("a"), 
          .e = ~ stop(.x), 
          .w = ~ warning(.x))
# Error in log("a") : argument non numérique pour une fonction mathématique

try_catch(matrix(1:3, nrow= 2), 
          .e = ~ print(.x), 
          .w = ~ print(.x))
#<simpleWarning in matrix(1:3, nrow = 2): la longueur des données [3] n'est pas un diviseur ni un multiple du nombre de lignes [2]>

try_catch(2 + 2 , 
          .f = ~ print("Using R for addition... ok I'm out!"))
# [1] "Using R for addition... ok I'm out!"
# [1] 4
```

As usual, the handlers are set only if you call them :

``` r
try_catch(matrix(1:3, nrow = 2), .e = ~ print("error"))
#      [,1] [,2]
# [1,]    1    3
# [2,]    2    1
# Warning message:
# In matrix(1:3, nrow = 2) :
#   la longueur des données [3] n'est pas un diviseur ni un multiple du nombre de lignes [2]
```

``` r
try_catch(matrix(1:3, nrow = 2), .w = ~ print("warning"))
# [1] "warning"
```

### Traditionnal way

{attempt} is flexible in how you can specify your arguments.

You can, as you do with {base} `tryCatch`, use a plain old function:

``` r
try_catch(log("a"), 
          .e = function(e){
            print(paste0("There is an error: ", e))
            print("Ok, let's save this")
            time <- Sys.time()
            a <- paste("+ At",time, ", \nError:",e)
            # write(a, "log.txt", append = TRUE) # commented to prevent log.txt creation 
            print(paste("log saved on log.txt at", time))
            print("let's move on now")
          })

# [1] "There is an error: Error in log(\"a\"): argument non numérique pour une fonction mathématique\n"
# [1] "Ok, let's save this"
# [1] "log saved on log.txt at 2017-12-20 18:24:05"
# [1] "let's move on now"
```

You can even mix both:

``` r
try_catch(log("a"), 
          .e = function(e){
            paste0("There is an error: ", e)
          },
          .f = ~ print("I'm not sure you can do that pal !"))
# [1] "I'm not sure you can do that pal !"
# [1] "There is an error: Error in log(\"a\"): argument non numérique pour une fonction mathématique\n"
```

### try\_catch\_df

`try_catch_df` returns a tibble with the call, the error message if any,
the warning message if any, and the value of the evaluated expression or
“error”. The values will always be contained in a list-column.

``` r
res_log <- try_catch_df(log("a"))
#> Error in try_catch_df(log("a")): impossible de trouver la fonction "try_catch_df"
res_log
#> Error in eval(expr, envir, enclos): objet 'res_log' introuvable
res_log$value
#> Error in eval(expr, envir, enclos): objet 'res_log' introuvable

res_matrix <- try_catch_df(matrix(1:3, nrow = 2))
#> Error in try_catch_df(matrix(1:3, nrow = 2)): impossible de trouver la fonction "try_catch_df"
res_matrix
#> Error in eval(expr, envir, enclos): objet 'res_matrix' introuvable
res_matrix$value
#> Error in eval(expr, envir, enclos): objet 'res_matrix' introuvable

res_success <- try_catch_df(log(1))
#> Error in try_catch_df(log(1)): impossible de trouver la fonction "try_catch_df"
res_success
#> Error in eval(expr, envir, enclos): objet 'res_success' introuvable
res_success$value
#> Error in eval(expr, envir, enclos): objet 'res_success' introuvable
```

### map try\_catch

`map_try_catch` and `map_try_catch_df` allow you to map on a list of
arguments `l`, to be evaluated by the function in `fun`.

``` r
map_try_catch(l = list(1, 3, "a"), fun = log, .e = ~ .x)
#> Error in map_try_catch(l = list(1, 3, "a"), fun = log, .e = ~.x): impossible de trouver la fonction "map_try_catch"

map_try_catch_df(list(1,3,"a"), log)
#> Error in map_try_catch_df(list(1, 3, "a"), log): impossible de trouver la fonction "map_try_catch_df"
```

## silently

`silently` transforms a function so that when you call this new
function, it returns nothing unless there is an error or a warning
(contrary to `attempt` that returns the result). In a sense, the new
function stay silent unless error or warning.

``` r
silent_log <- silently(log)
#> Error in silently(log): impossible de trouver la fonction "silently"
silent_log(1)
#> Error in silent_log(1): impossible de trouver la fonction "silent_log"
silent_log("a")
#> Error in silent_log("a"): impossible de trouver la fonction "silent_log"
# Error: argument non numérique pour une fonction mathématique
```

With `silently`, the result is never returned.

``` r
silent_matrix <- silently(matrix)
silent_matrix(1:3, 2)
# simpleWarning: la longueur des données [3] n'est pas un diviseur ni un multiple du nombre de lignes [2]
```

## surely

`surely` transforms a function so that when you call this new function,
it calls `attempt()` - i.e. in the code below, calling `sure_log(1)` is
the same as calling `attempt(log(1))`. In a sense, you’re sure this new
function will always work.

``` r
sure_log <- surely(log)
sure_log(1)
# [1] 0
sure_log("a")
# Error: argument non numérique pour une fonction mathématique
```

## `if_` conditions

`if_none`, `if_any` and `if_all` test the elements of the list.

``` r
if_all(1:10, ~ .x < 11, ~ return(letters[1:10]))
#> Error in if_all(1:10, ~.x < 11, ~return(letters[1:10])): impossible de trouver la fonction "if_all"

if_any(1:10, is.numeric, ~ print("Yay!"))
#> Error in if_any(1:10, is.numeric, ~print("Yay!")): impossible de trouver la fonction "if_any"

if_none(1:10, is.character, ~ rnorm(10))
#> Error in if_none(1:10, is.character, ~rnorm(10)): impossible de trouver la fonction "if_none"
```

The defaut for all `.p` is `isTRUE`. So you can:

``` r
a <- c(FALSE, TRUE, TRUE, TRUE)

if_any(a, .f = ~ print("nop!"))
#> Error in if_any(a, .f = ~print("nop!")): impossible de trouver la fonction "if_any"
```

`if_then` performs a simple “if this then do that”:

``` r
if_then(1, is.numeric, ~ return("nop!"))
#> Error in if_then(1, is.numeric, ~return("nop!")): impossible de trouver la fonction "if_then"
```

And `if_else` is a wrapper around `base::ifelse()` :

``` r
a <- if_else(1, is.numeric, ~ return("Yay"), ~ return("Nay"))
#> Error in if_else(1, is.numeric, ~return("Yay"), ~return("Nay")): impossible de trouver la fonction "if_else"
a
#> [1] FALSE  TRUE  TRUE  TRUE
```

## warnings and messages

The `stop_if`, `warn_if` and `message_if` are easy to use functions that
send an error, a warning or a message if a condition is met. Each
function has its counterpart with `_not`. That returns a message if the
condition is not met.

`stop_if_not` is quite the same as `assert_that` from the {assertthat}
package, except that it can takes mappers. It is not the same as base
`stopifnot()`, as it doesn’t take a list of expression.

These functions are also flexible as you can pass base predicates
(is.numeric, is.character…), a custom one built with mappers, or even
your own testing function.

You can either choose a custom message or just let the built-in messages
be printed:

``` r
x <- 12
# Stop if .x is numeric
stop_if(.x = x, 
        .p = is.numeric)

y <- "20"
# stop if .x is not numeric
stop_if_not(.x = y, 
            .p = is.numeric, 
            msg = "y should be numeric")
a  <- "this is not numeric"
# Warn if .x is charcter
warn_if(.x = a, 
        .p = is.character)

b  <- 20
# Warn if .x is not equal to 10
warn_if_not(.x = b, 
        .p = ~ .x == 10 , 
        msg = "b should be 10")

c <- "a"
# Message if c is a character
message_if(.x = c, 
           .p = is.character, 
           msg = "You entered a character element")

# Build more complex predicates
d <- 100
message_if(.x = d, 
           .p = ~ sqrt(.x) < 42, 
           msg = "The square root of your element must be more than 42")

# Or, if you're kind of old school, you can still pass classic functions

e <- 30
message_if(.x = e, 
           .p = function(vec){
             return(sqrt(vec) < 42)
           }, 
           msg = "The square root of your element must be more than 42")
```

If you have a function with no arguments, you can pass a dot `.` as
first argument
:

``` r
stop_if(., curl::has_internet, msg = "You shouldn't have internet to do that")

warn_if(., curl::has_internet, 
            msg = "You shouldn't have internet to do that")

message_if(., curl::has_internet, 
            msg = "Huray, you have internet \\o/")
```

If you don’t specify a `.p`, the default test is `isTRUE`.

``` r
a <- is.na(airquality$Ozone)
message_if_any(a, msg = "NA found")
```

### In function

That can come really handy inside a function :

``` r
my_fun <- function(x){
  stop_if_not(., 
              curl::has_internet, 
              msg = "You should have internet to do that")
  warn_if(x, 
          ~ ! is.character(.x), 
          msg =  "x is not a character vector. The output may not be what you're expecting.")
  paste(x, "is the value.")
}

my_fun(head(iris))
```

### none, all, any

`stop_if`, `warn_if` and `message_if` all have complementary tests with
`_all`, `_any` and `_none`, which combine the `if_*` and the `warn_*`,
`stop_*` and `message_*` seen before. They take a list as first
argument, and a predicate. They test if any, all or none of the elements
validate the
predicate.

``` r
stop_if_any(iris, is.factor, msg = "Factors here. This might be due to stringsAsFactors.")

warn_if_none(1:10, ~ .x < 0, msg = "You need to have at least one number under zero.")

message_if_all(1:100, is.numeric, msg = "That makes a lot of numbers.")
```

# Misc

## Acknowledgments

Thanks to [Romain](http://romain.rbind.io/) for the name suggestion.

## Contact

Questions and feedbacks [welcome](mailto:contact@colinfay.me)\!

You want to contribute ? Open a
[PR](https://github.com/ColinFay/attempt/pulls) :) If you encounter a
bug or want to suggest an enhancement, please [open an
issue](https://github.com/ColinFay/attempt/issues).

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
