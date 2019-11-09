context("Check calculated_field_patientclockstart")
# Currently this doesn't work as we've imported it from SSNAPStats
# and haven't connected it to the right function
clockstart <- tibble::tibble(
  S1FirstArrivalDateTime = as.POSIXct(c("2017-01-01 00:00:01",
                                        "2017-02-01 00:00:01",
                                        "2017-05-01 00:00:01",
                                        "2017-04-01 00:00:01",
                                        "2017-05-01 00:01:01")),
  S1OnsetInHospital = c(FALSE, FALSE, TRUE, TRUE, FALSE),
  S1OnsetDateTime = as.POSIXct(c("2017-05-01 00:00:01",
                                 "2017-05-01 00:00:01",
                                 "2017-03-01 00:00:01",
                                 "2017-04-01 00:02:01",
                                 "2017-05-01 00:00:01")),
  S4ArrivalDateTime = as.POSIXct(c("2017-03-01 00:00:01",
                                        "2017-04-01 00:00:01",
                                        "2017-05-01 00:00:01",
                                        "2017-04-01 00:00:01",
                                        "2017-05-01 00:01:01")),
  TransferFromTeamCode = c(NA, NA, NA, NA, NA),
  TransferFromDateTime = c(NA, NA, NA, NA, NA),
  S1Diagnosis = c("S", "S", "S", "S", "S"),
  TeamCode = c("295", "295", "295", "295", "295")
)
  
  clockstart <- dplyr::mutate(
    clockstart,
    !!! internal_simplify_dataset["S1PatientClockStartDateTime"])

test_that("Check S1PatientClockStartDateTime is created correctly", {
  expect_is(clockstart[["S1PatientClockStartDateTime"]], "POSIXct")
  expect_equal(clockstart[["S1PatientClockStartDateTime"]],
               as.POSIXct(c("2017-01-01 00:00:01",
                            "2017-02-01 00:00:01",
                            "2017-03-01 00:00:01",
                            "2017-04-01 00:02:01",
                            "2017-05-01 00:01:01")))
})

  clockstart <- dplyr::mutate(
    clockstart,
    !!! internal_simplify_dataset["S1TeamClockStartDateTime"])


test_that("Check S1TeamClockStartDateTime is created correctly", {
  expect_equal(clockstart[["S1TeamClockStartDateTime"]],
             as.POSIXct(c("2017-03-01 00:00:01",
                          "2017-04-01 00:00:01",
                          "2017-05-01 00:00:01",
                          "2017-04-01 00:02:01",
                          "2017-05-01 00:01:01")))
})
