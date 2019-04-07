context("Error message")

test_that("API error message are thrown", {
  expect_error(get_supported_lang(), "You need to set an API key.")
  expect_error(get_lang())
  expect_error(get_lang("This is a test"))
})
