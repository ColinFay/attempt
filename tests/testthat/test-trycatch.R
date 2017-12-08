context("trycatch")

test_that("errors catching", {
  a <- try_catch(log("a"), .e = ~ paste0("There was an error: ", .x))
  expect_is(a, "character")
  expect_match(a, "There was an error:")
})

test_that("warning catching", {
  a <- try_catch(warning("a"), .w = ~ paste0("There was a warning: ", .x))
  expect_is(a, "character")
  expect_match(a, "There was a warning:")
})

test_that("finally works", {
  a <- try_catch(NULL, .f = ~ print("bye"))
  expect_null(a)
})
