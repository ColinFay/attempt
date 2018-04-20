context("trycatch")

test_that("errors catching", {
  a <- try_catch(log("a"), .e = ~ return(paste0("There was an error: ", .x)))
  expect_is(a, "character")
  expect_match(a, "There was an error:")
  a <- try_catch(log(1), .e = ~ paste0("There was an error: ", .x))
  expect_equal(a, 0)
  plop <- function(){
    try(log("a"))
    attempt(log("a"))
    return(12)
  }
  a <- plop()
  expect_equal(a, 12)
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
  expect_output(try_catch(log(1), .f = ~ print("a")), "a")
})

test_that("trycatch works with an external variabel", {
  a <- 1
  expect_equal(try_catch(log(a), .e = ~ .x), 0)
  expect_is(try_catch(log("a"), .e = ~ .x), "simpleError")
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
  expect_is(res_log$error, "logical")
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
  c <- suppressWarnings(map_try_catch_df("plop", warning))
  expect_is(c, "tbl_df")
  expect_is(c, "tbl")
  expect_is(c, "data.frame")
  expect_equal(nrow(c), 1)
  expect_equal(ncol(c), 4)
  expect_true(is.na(c$error[1]))
  expect_is(c$value, "list")
  expect_equal(c$value[[1]], "plop")
})

context("attempt")

test_that("attempt works", {
  a <- attempt(log(1))
  expect_equal(a, 0)
  b <- attempt(log("a"), msg = "lol")
  expect_is(b, "try-error")
  expect_match(b, "lol")
  c <- attempt(log("a"), msg = "lol", verbose = TRUE)
  expect_is(c, "try-error")
  expect_match(c, "lol")
  d <- attempt(matrix(1:3, 2))
  expect_is(d, "try-error")
  e <- attempt(matrix(1:3, 2), msg = "lol")
  expect_is(e, "try-error")
  f <- attempt(matrix(1:3, 2), msg = "nop", verbose = TRUE)
  expect_is(f, "try-error")
})

test_that("attempt and try work the same way", {
  a <- try(log("a"))
  b <- attempt(log("a"))
  c <- attempt(log("a"), verbose = TRUE)
  expect_equal(class(a), class(b))
  expect_equal(length(a), length(b))
  expect_equal(attr(a, "condition"), attr(c, "condition"))
})


context("adverbs")

test_that("silently works", {
  silent_log <- silently(log)
  a <- silent_log("a")
  expect_is(a, "try-error")
  }
)

test_that("surely works", {
  sure_log <- surely(log)
  b <- sure_log("a")
  expect_is(b, "try-error")
  expect_length(b, 1)
})

test_that("silent_attempt works", {
  expect_is(silent_attempt(log(1)), "NULL")
  a <- silent_attempt(matrix(1:3, 2))
  expect_is(a, "try-error")
  b <- silent_attempt(log("a"))
  expect_is(b, "try-error")

  }
)

test_that("with_* works", {
  as_num_msg <- with_message(as.numeric, msg = "We're performing a numeric conversion")
  as_num_warn <- with_warning(as.numeric, msg = "We're performing a numeric conversion")
  expect_message(as_num_msg("1"))
  expect_warning(as_num_warn("1"))
  expect_is(suppressMessages(as_num_msg("1")), "numeric")
  expect_is(suppressWarnings(as_num_warn("1")), "numeric")
  plop <- function() {
    message("message")
    warning("warning")
    }
  nomess <- without_message(plop)
  nowar <- without_warning(plop)
  expect_message(nowar())
  expect_warning( nomess())
  }
)

