Tests and Coverage
================
14 November, 2018 09:31:56

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                                      | Coverage (%) |
| :------------------------------------------ | :----------: |
| tidystringdist                              |     100      |
| [R/tidycomb.R](../R/tidycomb.R)             |     100      |
| [R/tidystringdist.R](../R/tidystringdist.R) |     100      |
| [R/utils.R](../R/utils.R)                   |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                                          |  n |  time | error | failed | skipped | warning |
| :------------------------------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-tidy\_comb.R](testthat/test-tidy_comb.R)                | 20 | 0.039 |     0 |      0 |       0 |       0 |
| [test-tidy\_string\_dist.R](testthat/test-tidy_string_dist.R) | 24 | 0.055 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                                              | context            | test                                     | status |  n |  time |
| :---------------------------------------------------------------- | :----------------- | :--------------------------------------- | :----- | -: | ----: |
| [test-tidy\_comb.R](testthat/test-tidy_comb.R#L5)                 | tidy\_comb         | tidy combination all works on list       | PASS   |  5 | 0.026 |
| [test-tidy\_comb.R](testthat/test-tidy_comb.R#L14)                | tidy\_comb         | tidy combination works on list           | PASS   |  5 | 0.005 |
| [test-tidy\_comb.R](testthat/test-tidy_comb.R#L23)                | tidy\_comb         | tidy combination all works on data.frame | PASS   |  5 | 0.005 |
| [test-tidy\_comb.R](testthat/test-tidy_comb.R#L32)                | tidy\_comb         | tidy combination works on data.frame     | PASS   |  5 | 0.003 |
| [test-tidy\_string\_dist.R](testthat/test-tidy_string_dist.R#L10) | tidy\_string\_dist | tidy stringdist works                    | PASS   | 12 | 0.032 |
| [test-tidy\_string\_dist.R](testthat/test-tidy_string_dist.R#L28) | tidy\_string\_dist | tidyeval works                           | PASS   | 12 | 0.023 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.4.4 (2018-03-15)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS 10.14                         |
| Language | en\_US                              |
| Timezone | Europe/Paris                        |

| Package  | Version    |
| :------- | :--------- |
| testthat | 2.0.0.9000 |
| covr     | 3.2.0      |
| covrpage | 0.0.65     |

</details>

<!--- Final Status : pass --->
