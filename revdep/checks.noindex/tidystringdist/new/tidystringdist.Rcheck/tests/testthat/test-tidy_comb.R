context("tidy_comb")

test_that("tidy combination all works on list", {
  df <- tidy_comb_all(LETTERS[1:3])
  expect_equal(nrow(df), 3)
  expect_equal(ncol(df), 2)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
})

test_that("tidy combination works on list", {
  df <- tidy_comb("a", LETTERS[1:3])
  expect_equal(nrow(df), 3)
  expect_equal(ncol(df), 2)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
})

test_that("tidy combination all works on data.frame", {
  df <- tidy_comb_all(iris, Species)
  expect_equal(nrow(df), 3)
  expect_equal(ncol(df), 2)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
})

test_that("tidy combination works on data.frame", {
  df <- tidy_comb(iris, "this", Species)
  expect_equal(nrow(df), 3)
  expect_equal(ncol(df), 2)
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df, "data.frame"))
})
