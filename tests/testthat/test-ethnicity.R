# nolint start

# library(ssnapinterface)
# context("Check ethnicity conversion")
#
# Define a minimalist dataset for the tibble
# Define each so that two pass and two fail (in different patterns)
# For the last value we are proving known failures / unknown values
# should fail
#
#ethnicity_test <- tibble::tibble(
#  Country = c("England", "Wales", "Northern Ireland",
#              "Independent Republic of SSNAP"),
#  S1Ethnicity = c("B", "P", "IT", "NA")
#)
#
#ethnicity_test <- internal_standardiseukethnicity(ethnicity_test)
#
#test_that("Check EthnicityEngWales is created correctly", {
#  expect_equal(ethnicity_test[["EthnicityEngWales"]],
#               c("Irish", "Any other Black background", NA, NA))
#})
#
#test_that("Check EthnicityNI is created correctly", {
#  expect_equal(ethnicity_test[["EthnicityNI"]],
#               c(NA, NA, "Irish Traveller", NA))
#})
#
#test_that("Check EthnicityCatUK is created correctly", {
#  expect_equal(ethnicity_test[["EthnicityCatUK"]],
#               c("White", "Black", "White", "Unknown"))
#})
#
# nolint end
