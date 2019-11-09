#' SSNAP Column operators.
#' 
#' This is hopefully an evolution of record_transform_classes.
#' 
#' 
#' 
#'
ssnap_column_operation <- function(.vars) {
  
  if (!is.character(.vars)) {
    stop(".vars must be a string")
  }
  
  column_operation_output <- rlang::list2(
    ".vars" = .vars)
  class(column_operation_output) <- "ssnap_column_operation"
  return(column_operation_output)
}

#' Test if the object is an ssnap_column_operation
#'
#' This function returns `TRUE` for cohort_definitions
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the `ssnap_column_operation`
#' class.
#' @export

is_ssnap_column_operation <- function(x) {
  "ssnap_column_operation" %in% class(x)
}

#' @rdname is_ssnap_column_operation
#' @usage NULL
#' @export
is.ssnap_column_operation <- is_ssnap_column_operation



ssnap_column_substitution <- function(.vars,
                                      .funs) {
  
  if (!is.character(.vars)) {
    stop(".vars must be a string")
  }
  if (!rlang::is_expression(.funs)) {
    stop(".funs must be an expression")
  }
  
  column_operation_output <- rlang::list2(
    ".vars" = .vars,
    ".funs" = .funs)
  class(column_operation_output) <- 
    c("ssnap_column_substitution",
      "ssnap_column_operation")
  return(column_operation_output)
}

#' Test if the object is an ssnap_column_operation
#'
#' This function returns `TRUE` for cohort_definitions
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the `ssnap_column_substitution`
#' class.
#' @export

is_ssnap_column_substitution <- function(x) {
  "ssnap_column_substitution" %in% class(x)
}

#' @rdname is_ssnap_column_substitution
#' @usage NULL
#' @export
is.ssnap_column_substitution <- is_ssnap_column_substitution



ssnap_column_simplification <- function(.vars,
                                        .requires_columns,
                                        .funs) {
  
  if (!is.character(.vars)) {
    stop(".vars must be a string")
  }
  if (!rlang::is_expression(.funs)) {
    stop(".funs must be an expression")
  }
  
  column_operation_output <- rlang::list2(
    ".vars" = .vars,
    ".requires_columns" = .requires_columns,
    ".funs" = .funs)
  class(column_operation_output) <- 
    c("ssnap_column_simplification",
      "ssnap_column_operation")
  return(column_operation_output)
}

#' Test if the object is an ssnap_column_operation
#'
#' This function returns `TRUE` for cohort_definitions
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the `ssnap_column_simplification`
#' class.
#' @export

is_ssnap_column_simplification <- function(x) {
  "ssnap_column_simplification" %in% class(x)
}

#' @rdname is_ssnap_column_simplification
#' @usage NULL
#' @export
is.ssnap_column_simplification <- is_ssnap_column_simplification




ssnap_column_derivation <- function(.vars,
                                    .requires_columns,
                                    .funs) {
  
  if (!is.character(.vars)) {
    stop(".vars must be a string")
  }
  if (!is.character(.requires_columns)) {
    stop(".requires_columns must be a string")
  }
  if (!rlang::is_expression(.funs)) {
    stop(".funs must be an expression")
  }
  
  column_operation_output <- rlang::list2(
    ".vars" = .vars,
    ".requires_columns" = .requires_columns,
    ".funs" = .funs)
  class(column_operation_output) <- 
    c("ssnap_column_derivation",
      "ssnap_column_operation")
  return(column_operation_output)
}

#' Test if the object is an ssnap_column_operation
#'
#' This function returns `TRUE` for cohort_definitions
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the `ssnap_column_derivation`
#' class.
#' @export

is_ssnap_column_derivation <- function(x) {
  "ssnap_column_derivation" %in% class(x)
}

#' @rdname is_ssnap_column_operation
#' @usage NULL
#' @export
is.ssnap_column_derivation <- is_ssnap_column_derivation




ssnap_column_lookup <- function(.vars,
                                .tbl) {
  
  if (!is.character(.vars)) {
    stop(".vars must be a string")
  }
  if (!tibble::is_tibble(.tbl)) {
    stop(".tbl must be a tibble")
  }

  column_operation_output <- rlang::list2(
    ".vars" = .vars,
    ".tbl" = .tbl)
  class(column_operation_output) <- 
    c("ssnap_column_lookup",
      "ssnap_column_operation")
  return(column_operation_output)
}

#' Test if the object is an ssnap_column_operation
#'
#' This function returns `TRUE` for cohort_definitions
#'
#' @param x An object
#' @return `TRUE` if the object inherits from the `ssnap_column_lookup`
#' class.
#' @export

is_ssnap_column_lookup <- function(x) {
  "ssnap_column_lookup" %in% class(x)
}

#' @rdname is_ssnap_column_operation
#' @usage NULL
#' @export
is.ssnap_column_lookup <- is_ssnap_column_lookup
