<!-- README.md is generated from README.Rmd. Please edit that file -->
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://img.shields.io/badge/lifecycle-experimental-orange.svg)

{trycatchthis}
==============

A friendlier trycatch for R, based on {purrr} mappers.

Example
-------

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
#> [1] "There is an error: Error in log(\"a\"): argument non numérique pour une fonction mathématique\n"
#> [1] "Ok, let's save this"
#> [1] "log saved on log.txt at 2017-12-08 09:20:31"
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

Please note that this project is released with a [Contributor Code of
Conduct](CONDUCT.md). By participating in this project you agree to
abide by its terms.
