#' Warn if
#'
#' Friendlier messaging functions.
#'
#' @export
#'
#' @param .x the element to evaluate. It can be a predicate function (i.e a function returning TRUE).
#' @param .l the list of elements to evaluate
#' @param .p the predicate with the condition to test on \code{.x} or \code{.l}. Default is \code{isTRUE}.
#' @param msg the message to return. If NULL (default), the built-in message is printed.
#'
#' @importFrom rlang as_function
#'
#' @rdname messagehandler
#'
#' @examples
#' \dontrun{
#' x <- 12
#' stop_if(x, ~ .x > 13)
#' stop_if_not(x, is.character)
#'
#' a <- "this is not numeric"
#' warn_if(a, is.character)
#' warn_if_not(a, is.numeric)
#' b <- 20
#' warn_if(
#'   b,
#'   ~ . > 10,
#'   msg = "Wow, that's a lot of b"
#' )
#' c <- "a"
#' message_if(
#'   c,
#'   is.character,
#'   msg = "You entered a character element"
#' )
#' }
#'
stop_if <- function(
  .x,
  .p = isTRUE,
  msg = NULL
) {
  if (as_function(.p)(.x)) {
    if (is.null(msg)) {
      stop(
        paste0(
          "Test `",
          deparse(
            substitute(.p)
          ),
          "` on `",
          deparse(
            substitute(.x)
          ),
          "` returned an error."
        ),
        call. = FALSE
      )
    } else {
      stop(
        msg,
        call. = FALSE
      )
    }
  }
}

#' @export
#' @rdname messagehandler

stop_if_any <- function(.l, .p = isTRUE, msg = NULL) {
  if (is.null(msg)) {
    msg <- paste(
      "Test `",
      deparse(
        substitute(.l)
      ),
      "` on `",
      deparse(
        substitute(.p)
      ),
      "` returned an alert."
    )
  }
  if_any(
    .l,
    .p,
    ~ stop(
      msg,
      call. = FALSE
    )
  )
}

#' @export
#' @rdname messagehandler

stop_if_all <- function(
  .l,
  .p = isTRUE,
  msg = NULL
) {
  if (is.null(msg)) {
    msg <- paste(
      "Test `",
      deparse(
        substitute(.l)
      ),
      "` on `",
      deparse(
        substitute(.p)
      ),
      "` returned an alert."
    )
  }
  if_all(
    .l,
    .p,
    ~ stop(
      msg,
      call. = FALSE
    )
  )
}

#' @export
#' @rdname messagehandler

stop_if_none <- function(
  .l,
  .p = isTRUE,
  msg = NULL
) {
  if (is.null(msg)) {
    msg <- paste(
      "Test `",
      deparse(
        substitute(.l)
      ),
      "` on `",
      deparse(
        substitute(.p)
      ),
      "` returned an alert."
    )
  }
  if_none(
    .l,
    .p,
    ~ stop(
      msg,
      call. = FALSE
    )
  )
}

#' @export
#' @rdname messagehandler

stop_if_not <- function(
  .x,
  .p = isTRUE,
  msg = NULL
) {
  if (!as_function(.p)(.x)) {
    if (is.null(msg)) {
      stop(
        paste0(
          "Test `",
          deparse(
            substitute(.p)
          ),
          "` on `",
          deparse(
            substitute(.x)
          ),
          "` returned an error."
        ),
        call. = FALSE
      )
    } else {
      stop(msg, call. = FALSE)
    }
  }
}

#' @export
#' @rdname messagehandler

warn_if <- function(
  .x,
  .p = isTRUE,
  msg = NULL
) {
  if (as_function(.p)(.x)) {
    if (is.null(msg)) {
      warning(
        paste0(
          "Test `",
          deparse(
            substitute(.p)
          ),
          "` on `",
          deparse(
            substitute(.x)
          ),
          "` returned a warning."
        ),
        call. = FALSE,
        immediate. = TRUE
      )
    } else {
      warning(msg, call. = FALSE)
    }
  }
}


#' @export
#' @rdname messagehandler

warn_if_any <- function(.l, .p = isTRUE, msg = NULL) {
  if (is.null(msg)) {
    msg <- paste(
      "Test `",
      deparse(
        substitute(.l)
      ),
      "` on `",
      deparse(
        substitute(.p)
      ),
      "` returned an alert."
    )
  }
  if_any(
    .l,
    .p,
    ~ warning(
      msg,
      call. = FALSE
    )
  )
}

#' @export
#' @rdname messagehandler

warn_if_all <- function(.l, .p = isTRUE, msg = NULL) {
  if (is.null(msg)) {
    msg <- paste(
      "Test `",
      deparse(substitute(.l)),
      "` on `",
      deparse(substitute(.p)),
      "` returned an alert."
    )
  }
  if_all(
    .l,
    .p,
    ~ warning(msg, call. = FALSE)
  )
}

#' @export
#' @rdname messagehandler

warn_if_none <- function(.l, .p = isTRUE, msg = NULL) {
  if (is.null(msg)) {
    msg <- paste(
      "Test `",
      deparse(
        substitute(.l)
      ),
      "` on `",
      deparse(
        substitute(.p)
      ),
      "` returned an alert."
    )
  }
  if_none(
    .l,
    .p,
    ~ warning(msg, call. = FALSE)
  )
}

#' @export
#' @rdname messagehandler

warn_if_not <- function(.x, .p = isTRUE, msg = NULL) {
  if (!as_function(.p)(.x)) {
    if (is.null(msg)) {
      warning(
        paste0(
          "Test `",
          deparse(
            substitute(.p)
          ),
          "` on `",
          deparse(
            substitute(.x)
          ),
          "` returned a warning."
        ),
        call. = FALSE,
        immediate. = TRUE
      )
    } else {
      warning(msg, call. = FALSE)
    }
  }
}


#' @export
#' @rdname messagehandler

message_if <- function(.x = NULL, .p = isTRUE, msg = NULL) {
  if (as_function(.p)(.x)) {
    if (is.null(msg)) {
      message(
        paste(
          "Test `",
          deparse(
            substitute(.p)
          ),
          "` on `",
          deparse(
            substitute(.x)
          ),
          "` returned an alert."
        )
      )
    } else {
      message(msg)
    }
  }
}

#' @export
#' @rdname messagehandler

message_if_any <- function(.l, .p = isTRUE, msg = NULL) {
  if (is.null(msg)) {
    msg <- paste(
      "Test `",
      deparse(
        substitute(.l)
      ),
      "` on `",
      deparse(
        substitute(.p)
      ),
      "` returned an alert."
    )
  }
  if_any(
    .l,
    .p,
    ~ message(msg)
  )
}



#' @export
#' @rdname messagehandler

message_if_all <- function(.l, .p = isTRUE, msg = NULL) {
  if (is.null(msg)) {
    msg <- paste("Test `", deparse(substitute(.l)), "` on `", deparse(substitute(.p)), "` returned an alert.")
  }
  if_all(
    .l,
    .p,
    ~ message(msg)
  )
}

#' @export
#' @rdname messagehandler

message_if_none <- function(.l, .p = isTRUE, msg = NULL) {
  if (is.null(msg)) {
    msg <- paste("Test `", deparse(substitute(.l)), "` on `", deparse(substitute(.p)), "` returned an alert.")
  }
  if_none(
    .l,
    .p,
    ~ message(msg)
  )
}

#' @export
#' @rdname messagehandler

message_if_not <- function(.x, .p = isTRUE, msg = NULL) {
  if (!as_function(.p)(.x)) {
    if (is.null(msg)) {
      message(
        paste(
          "Test `",
          deparse(
            substitute(.p)
          ),
          "` on `",
          deparse(
            substitute(.x)
          ),
          "` returned an alert."
        )
      )
    } else {
      message(msg)
    }
  }
}
