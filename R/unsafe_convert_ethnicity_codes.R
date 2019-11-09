#' Convert ethnicity codes to UK-wide descriptions
#'
#' Ethnicity is stored as a set of letter-based codes. Unfortunately
#' England and Northern Ireland have different codes. In order to use
#' the information, we therefore need to use the code and country
#' information (which we have to get by converting the team code into
#' more detailed info including country) and convert it to a common
#' set for all areas.
#' 
#' @section Why is it unsafe:
#' 
#' The code was written some time back. However we don't pass the
#' tibble in functions any more (we pass quos so we can pack
#' sets of quos together in a single mutate statement), and for
#' speed we don't convert team codes and add country data unless it's
#' essential. As we don't have an active use for this code we haven't
#' converted it yet. We would need to convert it to quos, and
#' work out how we handle needing Country (ideally users wanting
#' ethnicity shouldn't need to specify the team code conversion).
#' 
#' @param data_table A tibble containing source data including
#' Country and S1 Ethnicity
#' 
#' @return The tibble but with EthnicityCatUK added

unsafe_convert_ethnicity_codes <- function(data_table) {
  # Move all England and Wales teams ethnicity to an
  # EthnicityEngWales column.
  # Move all NI teams ethnicity to an EthnicityNI column

  data_table <- dplyr::mutate(data_table,
    EthnicityCodeEngWales = .data[["S1Ethnicity"]],
    EthnicityCodeNI = .data[["S1Ethnicity"]])
  data_table[["EthnicityCodeEngWales"]][(data_table[["Country"]] !=
    "England") & (data_table[["Country"]] != "Wales")] <- NA
  data_table[["EthnicityCodeNI"]][(data_table$Country !=
    "Northern Ireland")] <- NA
  data_table[["S1Ethnicity"]] <- NULL

  # Replace England and Wales Ethnicity codes with text
  teamcsvpath <- system.file("extdata", "ethnicityengwales.csv",
    package = "ssnapinterface")
  teamdata <- readr::read_csv(teamcsvpath,
    col_names = TRUE,
    readr::cols(EthnicityCodeEngWales = readr::col_character(),
                EthnicityEngWales = readr::col_character(),
                EthnicityCatEngWales = readr::col_character()
  ))
  # Use the data as-is to change the team code into a team name
  data_table <- dplyr::left_join(data_table, teamdata,
    by = "EthnicityCodeEngWales")
  teamdata[["EthnicityCodeEngWales"]] <- NULL

  # Replace NI Ethnicity codes with textual descriptors
  teamcsvpath <- system.file("extdata", "ethnicityni.csv",
    package = "ssnapinterface")
  teamdata <- readr::read_csv(teamcsvpath,
    col_names = TRUE,
    readr::cols(EthnicityCodeNI = readr::col_character(),
                EthnicityNI = readr::col_character(),
                EthnicityCatNI = readr::col_character()
  ))
  # Use the data as-is to change the team code into a team name
  data_table <- dplyr::left_join(data_table, teamdata,
    by = "EthnicityCodeNI")
  teamdata[["EthnicityCodeNI"]] <- NULL

  # Then create column EthnicityCatUK based upon the categories
  data_table <- dplyr::mutate(data_table,
    EthnicityCatUK = dplyr::if_else(
      is.na(data_table[["EthnicityCatEngWales"]]),
      data_table[["EthnicityCatNI"]],
      data_table[["EthnicityCatEngWales"]]))
  data_table[["EthnicityCatUK"]][is.na(
    data_table[["EthnicityCatUK"]])] <- "Unknown"

  # Tidy up by removing code columns and the temporary Cat columns
  data_table[["EthnicityCodeEngWales"]] <- NULL
  data_table[["EthnicityCodeNI"]] <- NULL
  data_table[["EthnicityCatEngWales"]] <- NULL
  data_table[["EthnicityCatNI"]] <- NULL
  return(data_table)
}
