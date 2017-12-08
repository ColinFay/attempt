<!-- README.md is generated from README.Rmd. Please edit that file -->
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://img.shields.io/badge/lifecycle-experimental-orange.svg)

{trycatchthis}
==============

A friendlier error handler for R, based on {purrr} mappers and {rlang}.

try catch
---------

You can write a try catch with these params :

-   `...` the expression to be evaluated
-   `.e` a one side formula or a function evaluated when an error occurs
-   `.w` a one side formula or a function evaluated when a warning
    occurs
-   `.f` a one side formula or an expression which is always evaluated
    before returning or exiting

### With mappers

``` r
library(trycatchthis)
try_catch(log("a"), 
          .e = ~ paste0("There is an error: ", .x), 
          .w = ~ paste0("This is a warning: ", .x))
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"

try_catch(log("a"), 
          .e = ~ print(.x), 
          .w = ~ print(.x))
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"

try_catch(matrix(1:3, nrow= 2), 
          .e = ~ print(.x), 
          .w = ~ print(.x))
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"

try_catch(2 + 2 , 
          .f = ~ print("Using R for addition... ok I'm out!"))
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"
```

As usual, the handlers are set only if you call them :

``` r
try_catch(matrix(1:3, nrow = 2), .e = ~ print("error"))
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"
```

``` r
try_catch(matrix(1:3, nrow = 2), .w = ~ print("warning"))
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"
```

### Traditionnal way

{trycatchthis} is flexible in how you can specify your arguments.

You can, as you do with {base} `tryCatch`, use a plain old function:

``` r
try_catch(log("a"), 
          .e = function(e){
            print(paste0("There is an error: ", e))
            print("Ok, let's save this")
            time <- Sys.time()
            a <- paste("+ At",time, ", \nError:",e)
            # write(a, "log.txt", append = TRUE) # commented to prevent from log.txt creation on your machine
            print(paste("log saved on log.txt at", time))
            print("let's move on now")
          })
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"
```

You can even mix both:

``` r
try_catch(log("a"), 
          .e = function(e){
            paste0("There is an error: ", e)
          },
          .f = ~ print("I'm not sure you can do that pal !"))
#> Error in enexpr(expr): impossible de trouver la fonction "enexpr"
```

try\_that
---------

`try_that` is a wrapper around base `try` that allows you to insert a
custom messsage on error.

``` r
try_that(log("a"), msg = "Nop !")
#> Error : Nop !
```

You can make it verbose (i.e. returning the expression):

``` r
try_that(log("a"), msg = "Nop !", verbose = TRUE)
#> Error in log("a") : Nop !
```

warnings and messages
---------------------

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
#> Error: Test `is.numeric` on `x` returned an error.

y <- "20"
# stop if .x is not numeric
stop_if_not(.x = y, 
            .p = is.numeric, 
            msg = "y should be numeric")
#> Error in negate(as_mapper(.p)): impossible de trouver la fonction "negate"

a  <- "this is not numeric"
# Warn if .x is charcter
warn_if(.x = a, 
        .p = is.character)
#> Warning: Test `is.character` on `a` returned a warning.

b  <- 20
# Warn if .x is not equal to 10
warn_if_not(.x = b, 
        .p = ~ .x == 10 , 
        msg = "b should be 10")
#> Error in negate(as_mapper(.p)): impossible de trouver la fonction "negate"

c <- "a"
# Message if c is a character
message_if(.x = c, 
           .p = is.character, 
           msg = "You entered a character element")
#> You entered a character element

# Build more complex predicates
d <- 100
message_if(.x = d, 
           .p = ~ sqrt(.x) < 42, 
           msg = "The square root of your element must be more than 42")
#> The square root of your element must be more than 42

# Or, if you're kind of old school, you can still pass classic functions

e <- 30
message_if(.x = e, 
           .p = function(vec){
             return(sqrt(vec) < 42)
           }, 
           msg = "The square root of your element must be more than 42")
#> The square root of your element must be more than 42
```

That can come really handy inside a function :

``` r
my_fun <- function(x){
  warn_if(x, 
          ~ ! is.character(.x), 
          msg =  "x is not a character vector. \nThe output may not be what you're expecting.")
  paste(x, "is the value you choose")
}

my_fun(head(iris))
#> Warning: x is not a character vector. 
#> The output may not be what you're expecting.
#> [1] "c(5.1, 4.9, 4.7, 4.6, 5, 5.4) is the value you choose"  
#> [2] "c(3.5, 3, 3.2, 3.1, 3.6, 3.9) is the value you choose"  
#> [3] "c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7) is the value you choose"
#> [4] "c(0.2, 0.2, 0.2, 0.2, 0.2, 0.4) is the value you choose"
#> [5] "c(1, 1, 1, 1, 1, 1) is the value you choose"
```

### Contact

Questions and feedbacks [welcome](mailto:contact@colinfay.me)!

You want to contribute ? Open a
[PR](https://github.com/ColinFay/trycatchthis/pulls) :) If you encounter
a bug or want to suggest an enhancement, please [open an
issue](https://github.com/ColinFay/trycatchthis/issues).

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
