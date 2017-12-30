context("test-utils.R")

# test_that("build_and_eval works", {
#   expect_equal(build_and_eval(f = log, 1), 0)
#   expect_equal(build_and_eval(f = nrow, iris), 150)
#   expect_error(build_and_eval(f = log, "a"))
#   expect_equal(build_and_eval(~ .x +1, 1), 2)
#   f <- function() TRUE
#   expect_true(build_and_eval(f, .))
# })

test_that("try_catch_builder works", {
  a <- try_catch_builder(log, "a", .e = "error")
  expect_is(a, "call")
  expect_match(as.character(a)[1], "try_catch")
  expect_match(as.character(a)[2], "log")
  a <- try_catch(expr = .Primitive("log")("a"), .e = ~ return(.x))
  expect_is(a, "error")
  a <- try_catch_df_builder(log, "a", .e = "error")
  expect_is(a, "call")
  expect_match(as.character(a)[1], "try_catch")
  expect_match(as.character(a)[2], "log")
})

