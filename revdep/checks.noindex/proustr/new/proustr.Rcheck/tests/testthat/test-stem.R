context("stem")

test_that("steming words works", {
  a <- data.frame(words = c("matin", "heure", "fatigue","sonner","lois", "tests","fusionner"))
  df <- pr_stem_words(a, words)
  expect_true(inherits(df, "data.frame"))
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_equal(df$words[1], "matin")
  expect_equal(df$words[2], "heur")
  expect_equal(df$words[3], "fatigu")
  expect_equal(nrow(df), 7)
  expect_equal(ncol(df), 1)
})

test_that("steming sentences works", {
  a <- proustr::laprisonniere[1:10,]
  df <- pr_stem_sentences(a, text)
  expect_true(inherits(df, "data.frame"))
  expect_true(inherits(df, "tbl_df"))
  expect_true(inherits(df, "tbl"))
  expect_true(inherits(df$text[1], "character"))
})
  