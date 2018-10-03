context("if")

test_that("any, all and none works", {

  expect_message(message_if_all(.l = LETTERS,
                                .p = is.character,
                                msg = "This is character only"))

  expect_message(message_if_any(.l = 1:10,
                                 .p = function(vec){
                                   is.numeric(vec)
                                 },
                                 msg = "No numeric here"))
  expect_message(message_if_none(.l = letters,
                                 .p = function(vec){
                                   is.numeric(vec)
                                 }))

  expect_error(stop_if_all(.l = 12:14,
                           .p = is.numeric))
  expect_error(stop_if_all(.l = 12:14,
                           .p = is.numeric,
                           msg = "nop"))

  expect_error(stop_if_any(.l = 12:14,
                           .p = is.numeric))
  expect_error(stop_if_any(.l = 12:14,
                           .p = is.numeric,
                           msg = "y should be numeric"))

  expect_error(stop_if_none(.l = 12:14,
                            .p = is.character))
  expect_error(stop_if_none(.l = 12:14,
                            .p = is.character,
                            msg = "y should be numeric"))

  expect_warning(warn_if_all(.l = 1:14,
                             .p = is.numeric))
  expect_warning(warn_if_all(.l = 1:14,
                             .p = is.numeric,
                             msg = "hey!"))

  expect_warning(warn_if_any(.l = 1:13,
                             .p = ~ .x == 10))
  expect_warning(warn_if_any(.l = 1:13,
                             .p = ~ .x == 10 ,
                             msg = "b should be 10"))

  expect_warning(warn_if_none(.l = 20:30,
                              .p = ~ .x == 10))
  expect_warning(warn_if_none(.l = 20:30,
                              .p = ~ .x == 10 ,
                              msg = "b should be 10"))

  expect_message(message_if_any(.l = letters,
                                .p = is.character))
  expect_message(message_if_any(.l = letters,
                                .p = is.character,
                                msg = "You entered a character vector"))

  expect_message(message_if_all(.l = LETTERS,
                                .p = is.character))

})

test_that("if_then work", {
  a <- if_then(1,
               is.numeric,
               ~ return("lol"))
  expect_is(a,
            "character")
  expect_length(a, 1)
  expect_equal(a, "lol")
  ab <- if_then(1, ~ .x < 10, ~ return("lol"))
  expect_is(ab, "character")
  expect_length(ab, 1)
  expect_equal(ab, "lol")
  ac <- if_then(1, ~ .x > 10, ~ return("lol"))
  expect_null(ac)
  ad <- if_then(1, function(x) x < 10, ~ return("lol"))
  expect_is(ad, "character")
  expect_length(ad, 1)
  expect_equal(ad, "lol")
  ae <- if_then(1, function(x) x < 10, function() return("lol"))
  expect_is(a, "character")
  expect_length(a, 1)
  expect_equal(a, "lol")
  af <- if_then(1, is.numeric, ~ return("Yay"))
  expect_is(af, "character")
  expect_length(af, 1)
  expect_equal(af, "Yay")
  g <- if_then(1, function(x) is.numeric(x), ~ return("lol"))
  expect_is(g, "character")
  expect_length(g, 1)
  expect_equal(g, "lol")
  h <- if_then(1, function(x) is.numeric(x), function() return("lol"))
  expect_is(h, "character")
  expect_length(h, 1)
  expect_equal(h, "lol")
  i <- if_then(1, is.character, function() return("lol"))
  expect_null(i)
  j <- if_then(1, ~ .x > 10, function() return("lol"))
  expect_null(j)
  k <- if_not(1, ~ .x > 10, function() return("lol"))
  expect_is(k, "character")
  l <- if_not(1, ~ .x < 10, function() return("lol"))
  expect_null(l)

})
test_that("if_else work", {
  a <- if_else(TRUE, .f = ~ return("Yay"), .else = ~ return("Nay"))
  expect_equal(a, "Yay")
  expect_is(a, "character")
  b <- if_else(FALSE, .f = ~ return("Yay"), .else = ~ return("Nay"))
  expect_equal(b, "Nay")
  expect_is(b, "character")
  c <- if_else(.x = TRUE, .f = function() return("lol"), .else = function() return("lol"))
  expect_is(c, "character")
  expect_length(c, 1)
  expect_equal(c, "lol")

})

test_that("scoped if works", {
  b <- if_all(1:10, is.numeric, ~ return(letters[1:10]))
  expect_is(b, "character")
  expect_length(b, 10)
  expect_equal(b, letters[1:10])
  ba <- if_all(1:10, function(x) is.numeric(x), ~ return(letters[1:10]))
  expect_is(ba, "character")
  expect_length(ba, 10)
  expect_equal(ba, letters[1:10])
  bb <- if_all(1:10, function(x) is.numeric(x), function() return(letters[1:10]))
  expect_is(bb, "character")
  expect_length(bb, 10)
  expect_equal(bb, letters[1:10])
  c <- if_any(1:10, is.numeric, ~ return(letters[1:10]))
  expect_is(c, "character")
  expect_length(c, 10)
  expect_equal(c, letters[1:10])
  ca <- if_any(1:10, function(x) is.numeric(x), ~ return(letters[1:10]))
  expect_is(ca, "character")
  expect_length(ca, 10)
  expect_equal(ca, letters[1:10])
  cb <- if_any(1:10, function(x) is.numeric(x), function() return(letters[1:10]))
  expect_is(cb, "character")
  expect_length(cb, 10)
  expect_equal(cb, letters[1:10])
  d <- if_none(1:10, is.character, ~ return(letters[1:10]))
  expect_is(d, "character")
  expect_length(d, 10)
  expect_equal(d, letters[1:10])
  e <- if_none(1:10, ~ .x < 5, ~ return(letters[1:10]))
  expect_is(e, "character")
  expect_length(e, 10)
  expect_equal(e, letters[1:10])
  f <- if_none(1:10, function(x) x < 5, function() return(letters[1:10]))
  expect_is(f, "character")
  expect_length(f, 10)
  expect_equal(f, letters[1:10])
})

