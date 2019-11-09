#' Choose CSV columns given list of SSNAP column names
#' 
#' Each measure in SSNAPStats can describe which measures it needs
#' from an imported CSV file.
#' 
#' SSNAPInterface needs to make additional adjustments to that list
#' to reverse the 'tidying effects' it applies to the raw data, to
#' allow us to do a selective load of only the relevant columns.
#' 
#' This function should effectively calculate given a list of SSNAP
#' measure column names, which raw columns it needs.
#' 
#' @param requested_fields A character vector of all the SSNAP fields
#' requested for the cohorts.
#' @export

ssnap_measure_to_raw_csv_columns <- function(requested_fields) {
  substitutions <- c(
    S1PatientClockStartDateTime = glue::glue(
      "TransferFromTeamCode ",
      "TransferFromDateTime ",
      "S1Diagnosis ",
      "TeamCode ",
      "S1OnsetInHospital ",
      "S1OnsetDateTime ",
      "S1FirstArrivalDateTime"),
    S1IsMale = "S1Gender",
    S1FirstStrokeUnitArrivalDateTime = glue::glue(
      "S1FirstStrokeUnitArrivalDateTime ",
      "S1FirstStrokeUnitArrivalTimeNotEntered ",
      "S1FirstStrokeUnitArrivalNA"),
    S1OnsetDateIsPrecise = "S1OnsetDateType",
    S1OnsetTimeIsPrecise = "S1OnsetTimeType",
    S2BrainImagingDateTime = glue::glue(
      "S2BrainImagingDateTime ",
      "S2BrainImagingTimeNotEntered ",
      "S2BrainImagingNotPerformed"),
    S2StrokeTypeIsInfarct = "S2StrokeType",
    S2ThrombolysisNoBut = glue::glue(
      "S2ThrombolysisNoButHaemorrhagic ",
      "S2ThrombolysisNoButImproving ",
      "S2ThrombolysisNoButComorbidity ",
      "S2ThrombolysisNoButMedication ",
      "S2ThrombolysisNoButRefusal ",
      "S2ThrombolysisNoButOtherMedical ",
      "S2ThrombolysisNoButAge ",
      "S2ThrombolysisNoButTooMildSevere ",
      "S2ThrombolysisNoButTimeUnknownWakeUp ",
      "S2ThrombolysisNoButTimeWindow"),
    S2ThrombolysisComplications = glue::glue(
      "S2ThrombolysisComplications ",
      "S2ThrombolysisComplicationSih ",
      "S2ThrombolysisComplicationAO ",
      "S2ThrombolysisComplicationEB ",
      "S2ThrombolysisComplicationOther"),
    S2SwallowScreening4HrsDateTime = glue::glue(
      "S2SwallowScreening4HrsDateTime ",
      "S2SwallowScreening4HrsTimeNotEntered ",
      "S2SwallowScreening4HrsNotPerformed"),
    S2IAIThrombectomyAspirationDeviceDateTime = glue::glue(
      "S2IAIThrombectomyAspirationDeviceDateTime ",
      "S2IAIThrombectomyAspirationDeviceTimeNotEntered ",
      "S2IAIThrombectomyAspirationDeviceNotPerformed"),
    S3StrokeConsultantAssessedDateTime = glue::glue(
      "S3StrokeConsultantAssessedDateTime ",
      "S3StrokeConsultantAssessedTimeNotEntered ",
      "S3StrokeConsultantNotAssessed"),
    S3StrokeNurseAssessedDateTime = glue::glue(
      "S3StrokeNurseAssessedDateTime ",
      "S3StrokeNurseAssessedTimeNotEntered ",
      "S3StrokeNurseNotAssessed"),
    S3SwallowScreening72HrsDateTime = glue::glue(
      "S3SwallowScreening72HrsDateTime ",
      "S3SwallowScreening72HrsTimeNotEntered ",
      "S3SwallowScreening72HrsNotPerformed"),
    S3SpLangTherapistSwallow72HrsDateTime = glue::glue(
      "S3SpLangTherapistSwallow72HrsDateTime ",
      "S3SpLangTherapistSwallow72HrsTimeNotEntered ",
      "S3SpLangTherapistSwallow72HrsNotAssessed"),
    S3OccTherapist72HrsDateTime = glue::glue(
      "S3OccTherapist72HrsDateTime ",
      "S3OccTherapist72HrsTimeNotEntered ",
      "S3OccTherapist72HrsNotAssessed"),
    S3Physio72HrsDateTime = glue::glue(
      "S3Physio72HrsDateTime ",
      "S3Physio72HrsTimeNotEntered ",
      "S3Physio72HrsNotAssessed"),
    S3SpLangTherapistComm72HrsDateTime = glue::glue(
      "S3SpLangTherapistComm72HrsDateTime ",
      "S3SpLangTherapistComm72HrsTimeNotEntered ",
      "S3SpLangTherapistComm72HrsNotAssessed"),
    S1TeamClockStartDateTime = glue::glue(
      "S4ArrivalDateTime ",
      "TransferFromTeamCode ",
      "TransferFromDateTime ",
      "S1Diagnosis ",
      "TeamCode ",
      "S1OnsetInHospital ",
      "S1OnsetDateTime ",
      "S1FirstArrivalDateTime"),
    S7CareHomeDischargePermanentResidence =
      "S7CareHomeDischargeType",
    S7CareHomeDischargeToNewResidence =
      "S7CareHomeDischarge",
    S7DischargedSpecialistEsdmt =
      "S7DischargedEsdmt",
    S7DischargedSpecialistMcrt =
      "S7DischargedMcrt",
    S7TeamClockStopDateTime = glue::glue(
      "S7HospitalDischargeDateTime ",
      "S7DeathDate"),
    S7DeathDate = glue::glue(
      "S7StrokeUnitDischargeDateTime ",
      "S7StrokeUnitDeath ",
      "S7DeathDate"),
    S7StrokeUnitDeath = glue::glue(
      "S7StrokeUnitDeath ",
      "S7DeathDate"),
    S7DiedOnDayOfStrokeUnitDischarge = glue::glue(
      "S7StrokeUnitDeath ",
      "S7StrokeUnitDischargeDateTime ",
      "S7DeathDate")
  )
  unlist(strsplit(
    stringr::str_replace_all(requested_fields, substitutions),
    split = " "))
}
