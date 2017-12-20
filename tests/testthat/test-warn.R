context("test-warn.R")

test_that("stop, warn and message works", {

  expect_error(stop_if(.x = 12,
          .p = is.numeric))
  expect_error(stop_if(.x = 12,
          .p = is.numeric,
          msg = "plop"))
  expect_error(stop_if(.,
          .p = function(x) TRUE,
          msg = "plop"))

  expect_error(stop_if_not(.x = "20",
              .p = is.numeric))
  expect_error(stop_if_not(.x = "20",
              .p = is.numeric,
              msg = "y should be numeric"))
  expect_error(stop_if_not(.,
                       .p = function(x) FALSE,
                       msg = "plop"))


  expect_warning(warn_if(.x = "this is not numeric",
          .p = is.character))
  expect_warning(warn_if(.x = "this is not numeric",
          .p = is.character,
          msg = "lol"))
  expect_warning(warn_if(.,
                       .p = function(x) TRUE,
                       msg = "plop"))

  expect_warning(warn_if_not(.x = 20,
              .p = ~ .x == 10))
  expect_warning(warn_if_not(.x = 20,
              .p = ~ .x == 10 ,
              msg = "b should be 10"))
  expect_warning(warn_if_not(.,
                           .p = function(x) FALSE,
                           msg = "plop"))


  expect_message(message_if(.x = "a",
             .p = is.character))
  expect_message(message_if(.x = "a",
             .p = is.character,
             msg = "You entered a character element"))
  expect_message(message_if(.,
                         .p = function(x) TRUE,
                         msg = "plop"))


  expect_message(message_if(.x = 100,
             .p = ~ sqrt(.x) < 42,
             msg = "The square root of your element must be more than 42"))
  expect_message(message_if(.x = 100,
             .p = ~ sqrt(.x) < 42))
  expect_message(message_if_not(.x = 100,
             .p = ~ sqrt(.x) > 42))
  expect_message(message_if_not(.x = 100,
             .p = ~ sqrt(.x) > 42,
             msg = "Your sqrt should be less than 30"))
  expect_message(message_if_not(.,
                             .p = function(x) FALSE,
                             msg = "plop"))

  expect_message(message_if_not(.x = 30,
             .p = function(vec){
               return(vec > 30)
             },
             msg = "Your element should be less that 30"))
  expect_message(message_if_not(.x = 30,
             .p = function(vec){
               return(vec > 30)
             }))
})

context("test-any-all-none.R")

test_that("any, all and none works", {

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
  expect_message(message_if_all(.l = LETTERS,
             .p = is.character,
             msg = "This is character only"))

  expect_message(message_if_none(.l = letters,
             .p = function(vec){
               is.numeric(vec)
             },
             msg = "No numeric here"))
  expect_message(message_if_none(.l = letters,
             .p = function(vec){
               is.numeric(vec)
             }))
})


