context("error")

test_that("error handling", {
  expect_error(pr_detect_days(c("a", "b", "c")))
  expect_error(pr_detect_months(c("a", "b", "c")))
  expect_error(pr_detect_pro(c("a", "b", "c")))
  expect_error(pr_stem_words(c("a", "b", "c")))
  expect_error(pr_stem_sentences(c("a", "b", "c")))
  expect_error(pr_normalize_punc(c("a", "b", "c")))
  expect_error(proust_random(c("a", "b", "c")))
})
