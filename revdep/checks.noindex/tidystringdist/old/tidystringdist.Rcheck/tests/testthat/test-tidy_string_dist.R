context("tidy_string_dist")

starwars <- structure(list(name = c("Luke Skywalker", "C-3PO", "R2-D2", "Darth Vader",
                              "Leia Organa", "Owen Lars", "Beru Whitesun lars", "R5-D4", "Biggs Darklighter", "Obi-Wan Kenobi")), .Names = "name", row.names = c(NA, -10L), class = c("tbl_df",
                                                                                                      "tbl", "data.frame"))
tidy_comb_sw <- tidy_comb_all(starwars, name)

test_that("tidy stringdist works", {
  df <- tidy_stringdist(tidy_comb_sw, method = "jw")
  expect_equal(nrow(tidy_comb_sw), nrow(df))
  expect_equal(ncol(df), 3)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
  expect_false(any(df$jw > 1))
  df <- suppressWarnings(tidy_stringdist(tidy_comb_sw))
  expect_equal(nrow(tidy_comb_sw), nrow(df))
  expect_equal(ncol(df), 12)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
  expect_false(any(df$jw > 1))
})

test_that("tidyeval works", {
  names(tidy_comb_sw) <- c("a", "b")
  df <- tidy_stringdist(tidy_comb_sw, a, b, method = "jw")
  expect_equal(nrow(tidy_comb_sw), nrow(df))
  expect_equal(ncol(df), 3)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
  expect_false(any(df$jw > 1))
  df <- suppressWarnings(tidy_stringdist(tidy_comb_sw, a, b))
  expect_equal(nrow(tidy_comb_sw), nrow(df))
  expect_equal(ncol(df), 12)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
  expect_false(any(df$jw > 1))
})

