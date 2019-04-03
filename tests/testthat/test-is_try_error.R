context("test-is_try_error")

test_that("is_try_error works", {
  x <- attempt(log("a"), silent = TRUE)
  expect_true(is_try_error(x))
  x <- attempt(log(10), silent = TRUE)
  expect_false(is_try_error(x))
})
