#' Load SSNAP data from CSV file into memory
#'
#' This function imports data from a csv file exported by
#' www.strokeaudit.org.
#' 
#' Most SSNAP data exporting all teams will include a number of 'test'
#' or 'fake' teams. By default, we ignore these teams. If however you
#' need to include these teams (for example to test some new code,)
#' you can set ignore_fake_team_data to FALSE.
#' 

#' @param filename Filename of the CSV file to load.
#' @param column_names A character vector of the column names which
#' are required. If this is not specified, all columns are imported.
#' Where possible, columns should be specified as this makes the
#' analysis significantly quicker.
#' @param ignore_fake_team_data A boolean. By default (TRUE) any team
#' codes known to be fake or test team codes are skipped. If FALSE,
#' all teams are exported. 
#' @return A tibble containing the imported SSNAP data.
#' @export

read_audit_csv <- function(filename,
                           column_names = NULL,
                           ignore_fake_team_data = TRUE) {

  if (!(is.character(filename))) {
    stop("filename should be a character")
  }

  raw_column_names <- if (!is.null(column_names)) {
    unique(ssnap_measure_to_raw_csv_columns(column_names))
  }

  col_types <- if (!is.null(column_names)) {
    column_names <- c(column_names,
                      "TeamCode",
                      "PatientId",
                      "ProClinV1Id")
    do.call(readr::cols_only,
            column_types$cols[column_names])
  } else {
    do.call(readr::cols,
            c(column_types$cols,
            .default = readr::col_guess()))
  }

  imported_data <-
    vroom::vroom(filename, col_types = col_types, delim = ",")

# In some export formats S7TransferTeamCode is known as
# S7TransferHospitalCode, so we need to convert it for consistency.
# TODO - one of our column functions needs to convert this

  if ("S7TransferHospitalCode" %in% colnames(imported_data)) {
    imported_data <- dplyr::rename(
      imported_data,
      S7TransferTeamCode = .data[["S7TransferHospitalCode"]])
  }

  # Change the community codes so that they are -ve and team codes
  # Can be dealt with as numbers.
  imported_data <- dplyr::mutate_at(imported_data,
    .vars = dplyr::vars(dplyr::ends_with("TeamCode")),
    .funs = teamcode_to_number
  )

  # Simplify some factors to booleans; if column names are specified
  # Then we are only interested in those columns, otherwise do them
  # all.
  optional_boolean_column_names <- if (is.null(column_names)) {
    fields_to_simplify_booleans
  } else {
    intersect(column_names, fields_to_simplify_booleans)
  }

  # If we are ignoring fake teams, remove those less than -900 and
  # More than 900 (these are the allocated team code ranges)
  if (ignore_fake_team_data) {
    imported_data <- dplyr::filter(
      imported_data,
      dplyr::between(.data[["TeamCode"]], -900, 900))
  }
  
  if (length(optional_boolean_column_names) > 0) {
    imported_data <- dplyr::mutate_at(imported_data,
      .vars = dplyr::vars(optional_boolean_column_names),
      .funs = factor_to_logical_y_na_n)
  }

  # Then perform the simplify operation which trims the total number
  # of columns: if column_names isn't specified work on all columns.
  simplify_column_names <- if (is.null(column_names)) {
    names(internal_simplify_dataset)
  } else {
    # All column names contains both the raw names and post-processed
    # names - we then pick operations which act on both the new names
    # and raw ones from the operation lists (raw ops are commonly to
    # delete the column)
    all_column_names <- union(column_names, raw_column_names)
    intersect(all_column_names, names(internal_simplify_dataset))
  }

  imported_data <- dplyr::mutate(
    imported_data,
    !!! internal_simplify_dataset[simplify_column_names]
  )

  # Add Inpatient Spells to the dataset
  # Group the data by the patient Id, and sort it by the ProClinV1Id.

  imported_data <- dplyr::arrange(imported_data,
                                 .data[["PatientId"]],
                                 .data[["ProClinV1Id"]])
  imported_data <- dplyr::group_by(imported_data,
    .data[["PatientId"]])
  imported_data <- dplyr::mutate(imported_data,
    InpatientReadmission = cumsum(
      (dplyr::lead(.data[["TeamCode"]], n = 1,
      default = -1) > 0) & (.data[["TeamCode"]] < 0) * 1))

  imported_data <- dplyr::ungroup(imported_data)

  return(imported_data)
}
