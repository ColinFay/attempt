Tests and Coverage
================
27 août, 2018 14:43:13

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                             | Coverage (%) |
| :--------------------------------- | :----------: |
| attempt                            |     100      |
| [R/adverbs.R](../R/adverbs.R)      |     100      |
| [R/if.R](../R/if.R)                |     100      |
| [R/try\_catch.R](../R/try_catch.R) |     100      |
| [R/utils.R](../R/utils.R)          |     100      |
| [R/warn\_if.R](../R/warn_if.R)     |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

|                 | file                                        |  n |  time | error | failed | skipped | warning |
| --------------- | :------------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| test-if.R       | [test-if.R](testthat/test-if.R)             | 78 | 0.090 |     0 |      1 |       0 |       0 |
| test-trycatch.R | [test-trycatch.R](testthat/test-trycatch.R) | 70 | 0.088 |     0 |      0 |       0 |       0 |
| test-utils.R    | [test-utils.R](testthat/test-utils.R)       |  0 | 0.001 |     1 |      0 |       0 |       0 |
| test-warn.R     | [test-warn.R](testthat/test-warn.R)         | 40 | 0.058 |     0 |      0 |       0 |       0 |

<details open>

<summary> Show Detailed Test Results
</summary>

| file                                             | context             | test                                     | status |  n |  time |
| :----------------------------------------------- | :------------------ | :--------------------------------------- | :----- | -: | ----: |
| [test-if.R](testthat/test-if.R#L5_L7)            | if                  | any, all and none works                  | FAILED | 18 | 0.035 |
| [test-if.R](testthat/test-if.R#L70_L71)          | if                  | if\_then work                            | PASS   | 26 | 0.023 |
| [test-if.R](testthat/test-if.R#L112)             | if                  | if\_else work                            | PASS   |  7 | 0.006 |
| [test-if.R](testthat/test-if.R#L126)             | if                  | scoped if works                          | PASS   | 27 | 0.026 |
| [test-trycatch.R](testthat/test-trycatch.R#L5)   | trycatch            | errors catching                          | PASS   |  4 | 0.005 |
| [test-trycatch.R](testthat/test-trycatch.R#L20)  | trycatch            | warning catching                         | PASS   |  5 | 0.007 |
| [test-trycatch.R](testthat/test-trycatch.R#L33)  | trycatch            | finally works                            | PASS   |  2 | 0.006 |
| [test-trycatch.R](testthat/test-trycatch.R#L39)  | trycatch            | trycatch works with an external variabel | PASS   |  2 | 0.003 |
| [test-trycatch.R](testthat/test-trycatch.R#L47)  | try\_catch\_df      | try\_catch\_df works                     | PASS   | 14 | 0.012 |
| [test-trycatch.R](testthat/test-trycatch.R#L68)  | map\_try\_catch     | map\_try\_catch works                    | PASS   | 20 | 0.022 |
| [test-trycatch.R](testthat/test-trycatch.R#L97)  | attempt             | attempt works                            | PASS   |  8 | 0.008 |
| [test-trycatch.R](testthat/test-trycatch.R#L116) | attempt             | attempt and try work the same way        | PASS   |  3 | 0.004 |
| [test-trycatch.R](testthat/test-trycatch.R#L127) | adverbs             | silently works                           | PASS   |  1 | 0.002 |
| [test-trycatch.R](testthat/test-trycatch.R#L134) | adverbs             | surely works                             | PASS   |  2 | 0.003 |
| [test-trycatch.R](testthat/test-trycatch.R#L139) | adverbs             | silent\_attempt works                    | PASS   |  3 | 0.004 |
| [test-trycatch.R](testthat/test-trycatch.R#L151) | adverbs             | with\_\* works                           | PASS   |  6 | 0.012 |
| [test-utils.R](testthat/test-utils.R#L4)         | test-utils.R        | try\_catch\_builder works                | ERROR  |  0 | 0.001 |
| [test-warn.R](testthat/test-warn.R#L5_L6)        | test-warn.R         | stop, warn and message works             | PASS   | 22 | 0.032 |
| [test-warn.R](testthat/test-warn.R#L77_L78)      | test-any-all-none.R | any, all and none works                  | PASS   | 18 | 0.026 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.4.4 (2018-03-15)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS Sierra 10.12.6                |
| Language | fr\_FR                              |
| Timezone | Europe/Paris                        |

| Package  | Version    |
| :------- | :--------- |
| testthat | 2.0.0.9000 |
| covr     | 3.1.0      |
| covrpage | 0.0.52     |

</details>

<!--- Final Status : error/failed --->
