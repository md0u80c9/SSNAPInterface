#' Record transform classes
#' 
#' This file contains a set of operations to take raw CSV (or in the
#' future SQL) data and convert it to record-level data which can be
#' used for aggregation and output.
#' 
#' The file defines a parent class, record_transform, and a
#' set of subclasses representing different subclasses, and
#' associated helper function for creating one or more of these
#' objects.
#' 

#' This line is a piece of 'dummy' definition to get a feel for
#' What the transform objects will look like.
record_transform <- function() {
  list(
    "replaces_column" = TRUE,
    "source_column" = "MyBooleanField"
  )
}

#' Test if the object is a record_transform
#'
#' This function returns `TRUE` for record_transforms
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the
#' `record_transform` class.
#' @export

is_record_transform <- function(x) {
  "record_transform" %in% class(x)
}


#' @rdname is_record_transform
#' @usage NULL
#' @export
is.record_transform <- is_record_transform




record_transform_tidy_csv_boolean <- function(source_column) {
  purrr::map(source_column, function(x) {
      new_boolean <- list("replaces_column" = TRUE,
                          "input_column" = x,
                          "output_column" = x)
      class(new_boolean) <- c("tidy_csv_boolean",
                              "record_transform")
      new_boolean
  })
}

#' Test if the object is a record_transform
#'
#' This function returns `TRUE` for record_transforms
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the
#' `record_transform` class.
#' @export

is_tidy_csv_boolean <- function(x) {
  "tidy_csv_boolean" %in% class(x)
}


#' @rdname is_tidy_csv_boolean
#' @usage NULL
#' @export
is.tidy_csv_boolean <- is_tidy_csv_boolean




record_transform_tidy_csv_factor_to_logical <- 
  function(input_column,
           output_column,
           true_value,
           false_value) {
  purrr::pmap(list(input_column,
                   output_column,
                   true_value,
                   false_value), function(a, b, c, d) {
    if (is.null(b)) {
      b == a
    }
    new_boolean <- list("replaces_column" = TRUE,
                        "input_column" = a,
                        "output_column" = b,
                        "true_value" = c,
                        "false_value" = d)
    class(new_boolean) <- c("tidy_csv_factor_to_logical",
                            "record_transform")
    new_boolean
  })
}

#' Test if the object is a record_transform
#'
#' This function returns `TRUE` for record_transforms
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the
#' `record_transform` class.
#' @export

is_tidy_csv_factor_to_logical <- function(x) {
  "tidy_csv_factor_to_logical" %in% class(x)
}


#' @rdname is_tidy_csv_factor_to_logical
#' @usage NULL
#' @export
is.tidy_csv_factor_to_logical <- is_tidy_csv_factor_to_logical

