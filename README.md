<!-- README.md is generated from README.Rmd. Please edit that file -->
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://img.shields.io/badge/lifecycle-experimental-orange.svg)

[![Travis build
status](https://travis-ci.org/ColinFay/attempt.svg?branch=master)](https://travis-ci.org/ColinFay/attempt)
[![Coverage
status](https://codecov.io/gh/ColinFay/attempt/branch/master/graph/badge.svg)](https://codecov.io/github/ColinFay/attempt?branch=master)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/ColinFay/attempt?branch=master&svg=true)](https://ci.appveyor.com/project/ColinFay/attempt)

{attempt}
=========

A Friendlier Condition Handler for R, based on {purrr} mappers and
{rlang}.

{attempt} is designed to handle the cases when something / someone
attempts to do something it shouldn’t. For example :

-   attempt to run a `log("a")` (error)
-   attempt to connect to a web API without an internet connexion
    running (error)
-   attempt to `paste()` `"good morning` and `iris` (message/warning)
-   …

{attempt} provides several condition handlers, from try catch to simple
message printing.

try catch
---------

You can write a try catch with these params :

-   `expr` the expression to be evaluated
-   `.e` a one side formula or a function evaluated when an error occurs
-   `.w` a one side formula or a function evaluated when a warning
    occurs
-   `.f` a one side formula or an expression which is always evaluated
    before returning or exiting

### With mappers

``` r
library(attempt)
try_catch(log("a"), 
          .e = ~ paste0("There is an error: ", .x), 
          .w = ~ paste0("This is a warning: ", .x))
#> [1] "There is an error: Error in log(\"a\"): argument non numérique pour une fonction mathématique\n"

try_catch(log("a"), 
          .e = ~ print(.x), 
          .w = ~ print(.x))
#> <simpleError in log("a"): argument non numérique pour une fonction mathématique>

try_catch(matrix(1:3, nrow= 2), 
          .e = ~ print(.x), 
          .w = ~ print(.x))
#> <simpleWarning in matrix(1:3, nrow = 2): la longueur des données [3] n'est pas un diviseur ni un multiple du nombre de lignes [2]>

try_catch(2 + 2 , 
          .f = ~ print("Using R for addition... ok I'm out!"))
#> [1] "Using R for addition... ok I'm out!"
#> [1] 4
```

As usual, the handlers are set only if you call them :

``` r
try_catch(matrix(1:3, nrow = 2), .e = ~ print("error"))
#> Warning in matrix(1:3, nrow = 2): la longueur des données [3] n'est pas un
#> diviseur ni un multiple du nombre de lignes [2]
#>      [,1] [,2]
#> [1,]    1    3
#> [2,]    2    1
```

``` r
try_catch(matrix(1:3, nrow = 2), .w = ~ print("warning"))
#> [1] "warning"
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
            # write(a, "log.txt", append = TRUE) # commented to prevent from log.txt creation on your machine
            print(paste("log saved on log.txt at", time))
            print("let's move on now")
          })
#> [1] "There is an error: Error in log(\"a\"): argument non numérique pour une fonction mathématique\n"
#> [1] "Ok, let's save this"
#> [1] "log saved on log.txt at 2017-12-15 23:04:38"
#> [1] "let's move on now"
```

You can even mix both:

``` r
try_catch(log("a"), 
          .e = function(e){
            paste0("There is an error: ", e)
          },
          .f = ~ print("I'm not sure you can do that pal !"))
#> [1] "I'm not sure you can do that pal !"
#> [1] "There is an error: Error in log(\"a\"): argument non numérique pour une fonction mathématique\n"
```

### try\_catch\_df

`try_catch_df` returns a tibble with the call, the error message if any,
the warning message if any, and the value of the evaluated expression or
“error”.

``` r
res_log <- try_catch_df(log("a"))
res_log
#> # A tibble: 1 x 4
#>           call                                                 error
#>          <chr>                                                 <chr>
#> 1 "log(\"a\")" argument non numérique pour une fonction mathématique
#> # ... with 2 more variables: warning <chr>, value <list>
res_log$value
#> [[1]]
#> [1] "error"

res_matrix <- try_catch_df(matrix(1:3, nrow = 2))
res_matrix
#> # A tibble: 1 x 4
#>                    call error
#>                   <chr> <chr>
#> 1 matrix(1:3, nrow = 2)  <NA>
#> # ... with 2 more variables: warning <chr>, value <list>
res_matrix$value
#> [[1]]
#>      [,1] [,2]
#> [1,]    1    3
#> [2,]    2    1

res_success <- try_catch_df(log(1))
res_success
#> # A tibble: 1 x 4
#>     call error warning     value
#>    <chr> <chr>   <chr>    <list>
#> 1 log(1)  <NA>    <NA> <dbl [1]>
res_success$value
#> [[1]]
#> [1] 0
```

### map try\_catch

`map_try_catch` and `map_try_catch_df` allow you to map on a list of
arguments `l`, to be evaluated by the function in `fun`.

``` r
map_try_catch(l = list(1, 3, "a"), fun = log, .e = ~ .x)
#> [[1]]
#> [1] 0
#> 
#> [[2]]
#> [1] 1.098612
#> 
#> [[3]]
#> <simpleError in .Primitive("log")("a"): argument non numérique pour une fonction mathématique>

map_try_catch_df(list(1,3,"a"), log)
#> # A tibble: 3 x 4
#>                           call
#>                          <chr>
#> 1     ".Primitive(\"log\")(1)"
#> 2     ".Primitive(\"log\")(3)"
#> 3 ".Primitive(\"log\")(\"a\")"
#> # ... with 3 more variables: error <chr>, warning <chr>, value <list>
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

try\_that
---------

`silently` does the same job as `try`, except it doesn’t return the
value if the condition is verified.

``` r
silently(log("a"))
#> <simpleError in log("a"): argument non numérique pour une fonction mathématique>
silently(log(1))
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
#> Error: Can't convert a logical vector to function
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
#> Error: Can't convert a logical vector to function

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

If you have a function with no arguments, you can pass a dot `.` as
first argument :

``` r
stop_if(., curl::has_internet, msg = "You shouldn't have internet to do that")
#> Error: You shouldn't have internet to do that

warn_if(., curl::has_internet, 
            msg = "You shouldn't have internet to do that")
#> Warning: You shouldn't have internet to do that

warn_if(., curl::has_internet, 
            msg = "Huray, you have internet \\o/")
#> Warning: Huray, you have internet \o/
```

That can come really handy inside a function :

``` r
my_fun <- function(x){
  warn_if(x, 
          ~ ! is.character(.x), 
          msg =  "x is not a character vector. \nThe output may not be what you're expecting.")
  paste(x, "is the value.")
}

my_fun(head(iris))
#> Warning: x is not a character vector. 
#> The output may not be what you're expecting.
#> [1] "c(5.1, 4.9, 4.7, 4.6, 5, 5.4) is the value."  
#> [2] "c(3.5, 3, 3.2, 3.1, 3.6, 3.9) is the value."  
#> [3] "c(1.4, 1.4, 1.3, 1.5, 1.4, 1.7) is the value."
#> [4] "c(0.2, 0.2, 0.2, 0.2, 0.2, 0.4) is the value."
#> [5] "c(1, 1, 1, 1, 1, 1) is the value."
```

### none, all, any

`stop_if`, `warn_if` and `message_if` all have complementary tests with
`_all`, `_any` and `_none`. They take a list as first argument, and a
predicate. They test if any, all or none of the elements validate the
predicate.

``` r
stop_if_any(iris, is.factor, msg = "Factors here. This might be due to stringsAsFactors")
#> Error: Factors here. This might be due to stringsAsFactors

warn_if_none(1:10, ~ .x < 0, msg = "You need to have at least one number under zero")
#> Warning: You need to have at least one number under zero

message_if_all(1e3:1e4, ~ .x > 1e2, msg = "All your number are above 1e2. This may take some time to compute.")
#> All your number are above 1e2. This may take some time to compute.
```

Acknowledgment
--------------

Thank to [Romain](http://romain.rbind.io/) for the name suggestion.

Contact
-------

Questions and feedbacks [welcome](mailto:contact@colinfay.me)!

You want to contribute ? Open a
[PR](https://github.com/ColinFay/attempt/pulls) :) If you encounter a
bug or want to suggest an enhancement, please [open an
issue](https://github.com/ColinFay/attempt/issues).

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
