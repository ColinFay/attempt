Tests and Coverage
================
03 April, 2019 18:31:40

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                             | Coverage (%) |
| :--------------------------------- | :----------: |
| attempt                            |    84.56     |
| [R/on\_error.R](../R/on_error.R)   |     0.00     |
| [R/adverbs.R](../R/adverbs.R)      |    80.77     |
| [R/if.R](../R/if.R)                |    100.00    |
| [R/is\_class.R](../R/is_class.R)   |    100.00    |
| [R/try\_catch.R](../R/try_catch.R) |    100.00    |
| [R/utils.R](../R/utils.R)          |    100.00    |
| [R/warn\_if.R](../R/warn_if.R)     |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                  |  n |  time | error | failed | skipped | warning |
| :---------------------------------------------------- | -: | ----: | ----: | -----: | ------: | ------: |
| [test-if.R](testthat/test-if.R)                       | 78 | 0.069 |     0 |      0 |       0 |       0 |
| [test-is\_try\_error.R](testthat/test-is_try_error.R) |  2 | 0.002 |     0 |      0 |       0 |       0 |
| [test-trycatch.R](testthat/test-trycatch.R)           | 70 | 0.116 |     0 |      0 |       0 |       0 |
| [test-utils.R](testthat/test-utils.R)                 |  7 | 0.005 |     0 |      0 |       0 |       0 |
| [test-warn.R](testthat/test-warn.R)                   | 40 | 0.048 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                                     | context             | test                                     | status |  n |  time |
| :------------------------------------------------------- | :------------------ | :--------------------------------------- | :----- | -: | ----: |
| [test-if.R](testthat/test-if.R#L5_L7)                    | if                  | any, all and none works                  | PASS   | 18 | 0.028 |
| [test-if.R](testthat/test-if.R#L70_L71)                  | if                  | if\_then work                            | PASS   | 26 | 0.017 |
| [test-if.R](testthat/test-if.R#L112)                     | if                  | if\_else work                            | PASS   |  7 | 0.004 |
| [test-if.R](testthat/test-if.R#L126)                     | if                  | scoped if works                          | PASS   | 27 | 0.020 |
| [test-is\_try\_error.R](testthat/test-is_try_error.R#L5) | test-is\_try\_error | is\_try\_error works                     | PASS   |  2 | 0.002 |
| [test-trycatch.R](testthat/test-trycatch.R#L5)           | trycatch            | errors catching                          | PASS   |  4 | 0.006 |
| [test-trycatch.R](testthat/test-trycatch.R#L20)          | trycatch            | warning catching                         | PASS   |  5 | 0.006 |
| [test-trycatch.R](testthat/test-trycatch.R#L33)          | trycatch            | finally works                            | PASS   |  2 | 0.014 |
| [test-trycatch.R](testthat/test-trycatch.R#L39)          | trycatch            | trycatch works with an external variabel | PASS   |  2 | 0.005 |
| [test-trycatch.R](testthat/test-trycatch.R#L47)          | try\_catch\_df      | try\_catch\_df works                     | PASS   | 14 | 0.026 |
| [test-trycatch.R](testthat/test-trycatch.R#L68)          | map\_try\_catch     | map\_try\_catch works                    | PASS   | 20 | 0.031 |
| [test-trycatch.R](testthat/test-trycatch.R#L97)          | attempt             | attempt works                            | PASS   |  8 | 0.007 |
| [test-trycatch.R](testthat/test-trycatch.R#L116)         | attempt             | attempt and try work the same way        | PASS   |  3 | 0.006 |
| [test-trycatch.R](testthat/test-trycatch.R#L127)         | adverbs             | silently works                           | PASS   |  1 | 0.001 |
| [test-trycatch.R](testthat/test-trycatch.R#L134)         | adverbs             | surely works                             | PASS   |  2 | 0.003 |
| [test-trycatch.R](testthat/test-trycatch.R#L139)         | adverbs             | silent\_attempt works                    | PASS   |  3 | 0.003 |
| [test-trycatch.R](testthat/test-trycatch.R#L151)         | adverbs             | with\_\* works                           | PASS   |  6 | 0.008 |
| [test-utils.R](testthat/test-utils.R#L5)                 | test-utils.R        | try\_catch\_builder works                | PASS   |  7 | 0.005 |
| [test-warn.R](testthat/test-warn.R#L5_L6)                | test-warn.R         | stop, warn and message works             | PASS   | 22 | 0.023 |
| [test-warn.R](testthat/test-warn.R#L77_L78)              | test-any-all-none.R | any, all and none works                  | PASS   | 18 | 0.025 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.4.4 (2018-03-15)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS 10.14.3                       |
| Language | en\_US                              |
| Timezone | Europe/Paris                        |

| Package  | Version    |
| :------- | :--------- |
| testthat | 2.0.0.9000 |
| covr     | 3.2.0      |
| covrpage | 0.0.65     |

</details>

<!--- Final Status : pass --->
