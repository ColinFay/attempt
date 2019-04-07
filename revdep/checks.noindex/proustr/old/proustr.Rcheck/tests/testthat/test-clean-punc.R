context("punctuation cleaning")

test_that("quote cleaning", {
  skip_on_cran()
  expect_equal(clean_punc(vec = intToUtf8(8243)), '"')
  expect_equal(clean_punc(vec = intToUtf8(8246)), '"')
  expect_equal(clean_punc(vec = paste0(intToUtf8(171), intToUtf8(32))), '"')
  expect_equal(clean_punc(vec = paste0(intToUtf8(32), intToUtf8(187))), '"')
  expect_equal(clean_punc(vec = intToUtf8(8220)), '"')
  expect_equal(clean_punc(vec = intToUtf8(8221)), '"')
  expect_equal(clean_punc(vec = intToUtf8(96)), '"')
  expect_equal(clean_punc(vec = intToUtf8(180)), '"')
  expect_equal(clean_punc(vec = intToUtf8(8222)), '"')
  expect_equal(clean_punc(vec = intToUtf8(8220)), '"')
})

test_that("apostrophe cleaning", {
  skip_on_cran()
  expect_equal(clean_punc(vec = intToUtf8(1370)), "'")
  expect_equal(clean_punc(vec = intToUtf8(65040)), "'")
  expect_equal(clean_punc(vec = intToUtf8(8217)), "'")
})

test_that("dot dot dot cleaning", {
  skip_on_cran()
  expect_equal(clean_punc(vec = intToUtf8(8230)), "...")
})

test_that("alnum cleaning", {
  skip_on_cran()
  a <- pr_keep_only_alnum("neuilly-en-thelle")
  expect_equal(a, "neuilly en thelle")
})
test_that("unnacent cleaning", {
  skip_on_cran()
  expect_equal(pr_unacent("du chêne"), "du chene")
  expect_equal(pr_unacent("du chéne"), "du chene")
  expect_equal(pr_unacent("du chàne"), "du chane")
  expect_equal(pr_unacent("du chène"), "du chene")
})