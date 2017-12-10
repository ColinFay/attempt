context("trycatch")

test_that("errors catching", {
  a <- try_catch(log("a"), .e = ~ paste0("There was an error: ", .x))
  expect_is(a, "character")
  expect_match(a, "There was an error:")
  a <- try_catch(log(1), .e = ~ paste0("There was an error: ", .x))
  expect_equal(a, 0)
})

test_that("warning catching", {
  a <- try_catch(warning("a"), .w = ~ paste0("There was a warning: ", .x))
  expect_is(a, "character")
  expect_match(a, "There was a warning:")
  a <- try_catch(log("a"),
                 .e = function(e){
                   return(e)
                 })
  expect_is(a, "simpleError")
  expect_is(a, "error")
  expect_is(a, "condition")
})

test_that("finally works", {
  a <- try_catch(NULL, .f = ~ print("bye"))
  expect_null(a)
})

context("try_catch_df")

test_that("try_catch_df works", {
  res_log <- try_catch_df(log("a"))
  expect_is(res_log, "tbl_df")
  expect_is(res_log, "tbl")
  expect_is(res_log, "data.frame")
  expect_match(res_log$call, "log")
  expect_is(res_log$error, "character")
  expect_is(res_log$value, "list")
  expect_equal(res_log$value[[1]], "error")
  res_log <- try_catch_df(log(1))
  expect_is(res_log, "tbl_df")
  expect_is(res_log, "tbl")
  expect_is(res_log, "data.frame")
  expect_match(res_log$call, "log")
  expect_is(res_log$error, "character")
  expect_is(res_log$value, "list")
  expect_equal(res_log$value[[1]], 0)
})

context("map_try_catch")

test_that("map_try_catch works", {
  a <- map_try_catch(l = list(1, 3, "a"), fun = log, .e = ~ .x)
  expect_is(a, "list")
  expect_equal(a[[1]], 0)
  expect_equal(round(a[[2]], 2), 1.1)
  expect_is(a[[3]], "error")
  b <- map_try_catch_df(list(1,3,"a"), log)
  expect_is(b, "tbl_df")
  expect_is(b, "tbl")
  expect_is(b, "data.frame")
  expect_equal(nrow(b), 3)
  expect_equal(ncol(b), 4)
  expect_match(b$call[1], "log")
  expect_that(b$error[1], function(x) is.na(x))
  expect_is(b$value, "list")
  expect_equal(b$value[[1]], 0)
})

context("try_that")

test_that("try_that works", {
  a <- try_that(log("a"))
  expect_null(a)
  a <- try_that(log(1))
  expect_equal(a, 0)
})
