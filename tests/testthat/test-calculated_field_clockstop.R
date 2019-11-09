context("Check calculated_field_teamclockstop")

# Check the results of deaths on the stroke unit are handled correctly

# Patient 1 isn't dead (so should end up with an NA death date).
# Patient 2 dies but not on the stroke unit (so should get a
# midnight on date of death).
# Patient 3 dies on the stroke unit so is a 23:59 death.

test_that("Handles discharge and puts a time of 23:59 on deaths", {
  clock_stop_data <- tibble::tibble(
    S7HospitalDischargeDateTime = as.POSIXct(
      c("2017-01-01 00:12:00", NA, NA)),
    S7StrokeUnitDischargeDateTime = as.POSIXct(c(NA, NA, NA)),
    S7StrokeUnitDeath = c( NA, FALSE, TRUE),
    S7DeathDate = as.POSIXct(
      c(NA, "2017-01-02 00:00:00", "2017-01-04 00:00:00"))
  )

  clock_stop_data <- dplyr::mutate(
    clock_stop_data,
    !!! internal_simplify_dataset["S7DiedOnDayOfStrokeUnitDischarge"],
    !!! internal_simplify_dataset["S7DeathDate"])

  expect_equal(clock_stop_data[["S7DeathDate"]],
    as.POSIXct(c(NA, "2017-01-02 00:00:00", "2017-01-04 23:59:00")))
})

# Check the results of deaths not on the stroke unit are handled
test_that("Deaths not on the stroke unit are handled correctly", {
  clock_stop_data <- tibble::tibble(S7HospitalDischargeDateTime =
    as.POSIXct(c(NA, NA, NA, NA)),
  S7StrokeUnitDischargeDateTime = as.POSIXct(
    c("2017-01-01 00:12:00", "2017-01-01 00:12:00",
      "2017-01-03 00:00:01", "2017-01-01 00:12:00")),
  S7StrokeUnitDeath = c(FALSE, FALSE, FALSE, FALSE),
  S7DeathDate = as.POSIXct(c("2017-01-01", "2017-01-02",
                             "2017-01-03", "2017-01-04"))
  )

  clock_stop_data <- dplyr::mutate(
    clock_stop_data,
    !!! internal_simplify_dataset["S7DiedOnDayOfStrokeUnitDischarge"],
    !!! internal_simplify_dataset["S7DeathDate"],
    !!! internal_simplify_dataset["S7TeamClockStopDateTime"])

  expect_equal(clock_stop_data[["S7TeamClockStopDateTime"]],
    as.POSIXct(c("2017-01-01 00:12:00", "2017-01-02 00:00:00",
                 "2017-01-03 00:00:01", "2017-01-04 00:00:00")))
})

# Check that if we get sent incomplete data (no discharge or death
# date) this is handled correctly
test_that("return NA if discharge datetime and death date are NA", {
  clock_stop_data <- tibble::tibble(
    S7HospitalDischargeDateTime = as.POSIXct(
      c("2017-01-01 00:12:00", NA,
        "2017-01-03 00:00:01", NA)),
    S7StrokeUnitDischargeDateTime = as.POSIXct(c(NA, NA, NA, NA)),
    S7StrokeUnitDeath = c(NA, TRUE, NA, TRUE),
    S7DeathDate = as.POSIXct(c(NA, "2017-02-01", NA, NA))
  )

  clock_stop_data <- dplyr::mutate(
    clock_stop_data,
    !!! internal_simplify_dataset["S7DiedOnDayOfStrokeUnitDischarge"],
    !!! internal_simplify_dataset["S7DeathDate"],
    !!! internal_simplify_dataset["S7TeamClockStopDateTime"])

  expect_equal(clock_stop_data[["S7TeamClockStopDateTime"]],
    as.POSIXct(c("2017-01-01 00:12:00", "2017-02-01 23:59:00",
                 "2017-01-03 00:00:01", NA)))
})
