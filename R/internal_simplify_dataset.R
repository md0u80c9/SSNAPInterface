#' @importFrom rlang !!
#' @importFrom rlang !!!
#' @importFrom rlang :=
#' @importFrom rlang enquo
#' @importFrom rlang .data

fields_to_simplify_booleans <- c(
  "S1ArriveByAmbulance",
  "S2ThrombolysisComplications",
  "S2NeurovascularClinicAssessed",
  "S3EndOfLifePathway",
  "S4Physio",
  "S4OccTher",
  "S4SpeechLang",
  "S4Psychology",
  "S6PalliativeCareByDischarge",
  "S6EndOfLifePathwayByDischarge",
  "S7StrokeUnitDeath",
  "S2TIAInLastMonth",
  "S5UrinaryTractInfection7Days",
  "S5PneumoniaAntibiotics7Days",
  "S6MalnutritionScreening",
  "S6IntPneumaticComp",
  "S7AdlHelp",
  "S7DischargeAtrialFibrillationAnticoagulation",
  "S7DischargeJointCarePlanning",
  "S7DischargePIConsent",
  "S8FollowUpPIConsent",
  "S8MoodBehaviourCognitiveScreened",
  "S8MoodBehaviourCognitivePsychologicalSupport",
  "S8PersistentAtrialFibrillation",
  "S8TakingAntiplateletDrug",
  "S8TakingAnticoagulent",
  "S8TakingLipidLowering",
  "S8TakingAntihypertensive",
  "S8SinceStrokeAnotherStroke",
  "S8SinceStrokeMyocardialInfarction",
  "S8SinceStrokeOtherHospitalisationIllness",
  "S2IAI",
  "S2IAIClinicalTrial",
  "S2IAICtaMra",
  "S2IAIAspects",
  "S2IAIPerfusionImaging",
  "S2IAIThromboAspiration",
  "S2IAIStentRetriever",
  "S2IAIProximalBallonFlowArrestGuideCather",
  "S2IAIDistalAccessCatheter",
  "S2IAIComplicationSymptomaticIntraCranialHaemorrhage",
  "S2IAIComplicationExtraCranialHaemorrhage",
  "S2IAIComplicationOther"
)

factor_to_logical_y_na_n <- function(x) {
  dplyr::case_when(
    x == "Y" ~ TRUE,
    is.na(x) ~ NA,
    TRUE ~ FALSE)
}

factor_to_new_islogical_tf <- function(column,
                                       true_value,
                                       false_value) {
  dplyr::case_when(
    column == true_value ~ TRUE,
    column == false_value ~ FALSE,
    TRUE ~ NA)
}


factor_to_new_islogical <- function(column,
                                    is_value) {
  dplyr::case_when(
    column == is_value ~ TRUE,
    is.na(column) ~ NA,
    TRUE ~ FALSE)
}

# Define constant POSIXct values for unentered dates or not
# applicable dates.

not_entered_date <- as.POSIXct(0,
                               origin = "1970-01-01",
                               tz = "UTC")
not_applicable_date  <- as.POSIXct(-1,
                                   origin = "1970-01-01",
                                   tz = "UTC")

#' tpa_no_but is a vector of named integer values describing which
#' binary bit in a number represents which thrombolysis reason so
#' rather than having numeric values scattered in code which may be
#' unclear or need commenting every time you can refer to a named
#' vector item.
#' 
#' This allows us to take a few mathematical shortcuts.
#' 
#' To find if a value is TRUE you want to do a logical AND against
#' the value.
#' 
#' To find everyone who had no 'no buts' you just look for 0;
#' everyone who had at least one no but has a value > 0.
#' @return a named numeric vector of thrombolysis reasons and their
#' representative value within the bitfield.
#' @export

tpa_no_but <- c(Haemorrhagic = 1,
                Improving = 2,
                Comorbidity = 4,
                Medication = 8,
                Refusal = 16,
                OtherMedical = 32,
                Age = 64,
                TooMildSevere = 128,
                TimeUnknownWakeUp = 256,
                TimeWindow = 512)


#' Bit-field flags for recording complications from thrombolysing a
#' patient
#'
#' In the raw data these are represented by a non-exclusive series
#' of Booleans. To save space and improve processing time, rather
#' than store the tPA complications as a series of TRUE/FALSE values,
#' we can store it as a binary number - where 0 is FALSE and 1 is
#' TRUE. Each parameter is therefore given a value of 1^X, where X is
#' incremented from 0.
#' 
#' tpa_complications is a vector of named integer values describing
#' which binary bit in a number represents which thrombolysis reason
#' so rather than having numeric values scattered in code which may be
#' unclear or need commenting every time you can refer to a named
#' vector item.
#' 
#' This allows us to take a few mathematical shortcuts.
#' 
#' To find if a value is TRUE you want to do a logical AND against
#' the value.
#' 
#' To find everyone who had no 'no buts' you just look for 0;
#' everyone who had at least one no but has a value > 0.
#' @return a named numeric vector of thrombolysis reasons and their
#' representative value within the bitfield.
#' @export

tpa_complications <- c(SymptomaticICH    = 1,
                       Angiooedema       = 2,
                       ExtracranialBleed = 4,
                       Other             = 8)


#' A list of expressions for wrangling the source CSV file into a
#' more efficient format for analysis.
#' 
#' There are four main stages within this process:
#' Changing non-optional booleans which were stored as factors into
#' booleans.
#' Moving booleans for not entered or not applicable when applied to
#' dates into the date format by storing as 0 or negative constants.
#' Setting up bitfields for groups of logical values - ie.
#' thrombolysis no-but reasons or thrombolysis complications.
#' 
#' With selective column import, we only want to apply transformations
#' applicable to the columns we have imported, so we select the
#' relevant expressions from this list by their name and apply them.

internal_simplify_dataset <- rlang::exprs(

# The first set of expressions simplifies non-optional boolean
# information stored in the CSV.
#
# There are several variations of booleans used within the CSVs. We
# want to consistently use them as booleans. In R, the Booleans can
# be optional, whereas in the CSV sometimes these are represented
# by two booleans.
#
# Where we have stored a field which has two possible values, we
# rename the column to IsX - where X is one of the two options.
# For example, S1Gender becomes IsMale.
#
# Where booleans are optional, we also can take in a field
# representing a missing boolean, we take these in and apply NAs.
#
# This simplifies significantly the number of fields, and provides
# consistency to the code to handle these values.

  S1IsMale = (.data$S1Gender == "M"),
  S1Gender = NULL,
  S1OnsetInHospital = (.data[["S1OnsetInHospital"]] == "Y"),

  S1OnsetDateIsPrecise = factor_to_new_islogical_tf(
    .data[["S1OnsetDateType"]], "P", "BE"),
  S1OnsetDateType = NULL,

  S1OnsetTimeIsPrecise = factor_to_new_islogical_tf(
    .data[["S1OnsetTimeType"]], "P", "BE"),
  S1OnsetTimeType = NULL,
  S2CoMCongestiveHeartFailure =
    (.data[["S2CoMCongestiveHeartFailure"]] == "Y"),
  S2CoMHypertension = (.data[["S2CoMHypertension"]] == "Y"),
  S2CoMAtrialFibrillation =
    (.data[["S2CoMAtrialFibrillation"]] == "Y"),
  S2CoMDiabetes = (.data[["S2CoMDiabetes"]] == "Y"),
  S2CoMStrokeTIA = (.data[["S2CoMStrokeTIA"]] == "Y"),

  S2StrokeTypeIsInfarct = (.data[["S2StrokeType"]] == "I"),
  S2StrokeType = NULL,
  S2BrainImagingModalityIsCT = factor_to_new_islogical(
    .data[["S2BrainImagingModality"]], "CT"),
  S2BrainImagingModality = NULL,
  S7CareHomeDischargeToNewResidence = factor_to_new_islogical(
    .data[["S7CareHomeDischarge"]], "NPR"),
  S7CareHomeDischarge = NULL,

  S7CareHomeDischargePermanentResidence = factor_to_new_islogical(
    .data[["S7CareHomeDischargeType"]], "P"),
  S7CareHomeDischargeType = NULL,

  S7DischargedSpecialistEsdmt = factor_to_new_islogical_tf(
    .data[["S7DischargedEsdmt"]], "SNS", "NS"),
    S7DischargedEsdmt = NULL,

  S7DischargedSpecialistMcrt = factor_to_new_islogical_tf(
    .data[["S7DischargedMcrt"]], "SNS", "NS"),
  S7DischargedMcrt = NULL,
  S7DischargeAtrialFibrillation =
    (.data[["S7DischargeAtrialFibrillation"]] == "Y"),
  S7DischargeNamedContact =
    (.data[["S7DischargeNamedContact"]] == "Y"),
  S8MoodBehaviourCognitiveSupportNeeded =
    (.data[["S8MoodBehaviourCognitiveSupportNeeded"]] == "Y"),

# The next group simplifies date information stored in the CSV.
#
# Some fields have a "not seen" and / or a "not entered field".
#
# R stores dates and times as integer values since midnight on 1st
# January, 1970. Any time after that time is positive, anything
# before it is negative.
#
# We can simplify date storage by recording "not seen" as
# "31-12-1969 23:59:59" - in other words "-1". Other reason codes
# are possible by using -2, -3 etc.
#
# Where dates and times are missing in R we can store those as NA.
#
# Values are returned as quosures ready to be passed to a dplyr
# mutate command. This avoids us passing and modifying large blocks
# of memory and to combine a lot of operations together.

  S1FirstStrokeUnitArrivalDateTime = dplyr::case_when(
    .data[["S1FirstStrokeUnitArrivalTimeNotEntered"]] ~
      not_entered_date,
    .data[["S1FirstStrokeUnitArrivalNA"]] ~ not_applicable_date,
    TRUE ~ .data[["S1FirstStrokeUnitArrivalDateTime"]]),
  S1FirstStrokeUnitArrivalTimeNotEntered = NULL,
  S1FirstStrokeUnitArrivalNA = NULL,

  S2BrainImagingDateTime = dplyr::case_when(
    .data[["S2BrainImagingTimeNotEntered"]] ~ not_entered_date,
    .data[["S2BrainImagingNotPerformed"]] ~ not_applicable_date,
    TRUE ~ .data[["S2BrainImagingDateTime"]]),
  S2BrainImagingTimeNotEntered = NULL,
  S2BrainImagingNotPerformed = NULL,

  S2SwallowScreening4HrsDateTime = dplyr::case_when(
    .data[["S2SwallowScreening4HrsTimeNotEntered"]] ~
      not_entered_date,
    .data[["S2SwallowScreening4HrsNotPerformed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S2SwallowScreening4HrsDateTime"]]),
  S2SwallowScreening4HrsTimeNotEntered = NULL,
  S2SwallowScreening4HrsNotPerformed = NULL,

  S2IAIThrombectomyAspirationDeviceDateTime = dplyr::case_when(
    .data[["S2IAIThrombectomyAspirationDeviceTimeNotEntered"]] ~
      not_entered_date,
    .data[["S2IAIThrombectomyAspirationDeviceNotPerformed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S2IAIThrombectomyAspirationDeviceDateTime"]]),
  S2IAIThrombectomyAspirationDeviceNotPerformed = NULL,
  S2IAIThrombectomyAspirationDeviceTimeNotEntered = NULL,

  S3StrokeNurseAssessedDateTime = dplyr::case_when(
    .data[["S3StrokeNurseAssessedTimeNotEntered"]] ~
      not_entered_date,
    .data[["S3StrokeNurseNotAssessed"]] ~ not_applicable_date,
    TRUE ~ .data[["S3StrokeNurseAssessedDateTime"]]),
  S3StrokeNurseAssessedTimeNotEntered = NULL,
  S3StrokeNurseNotAssessed = NULL,

  S3StrokeConsultantAssessedDateTime = dplyr::case_when(
    .data[["S3StrokeConsultantAssessedTimeNotEntered"]] ~
      not_entered_date,
    .data[["S3StrokeConsultantNotAssessed"]] ~ not_applicable_date,
    TRUE ~ .data[["S3StrokeConsultantAssessedDateTime"]]),
  S3StrokeConsultantAssessedTimeNotEntered = NULL,
  S3StrokeConsultantNotAssessed = NULL,

  S3SwallowScreening72HrsDateTime = dplyr::case_when(
    .data[["S3SwallowScreening72HrsTimeNotEntered"]] ~
      not_entered_date,
    .data[["S3SwallowScreening72HrsNotPerformed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S3SwallowScreening72HrsDateTime"]]),
  S3SwallowScreening72HrsTimeNotEntered = NULL,
  S3SwallowScreening72HrsNotPerformed = NULL,

  S3OccTherapist72HrsDateTime = dplyr::case_when(
    .data[["S3OccTherapist72HrsTimeNotEntered"]] ~ not_entered_date,
    .data[["S3OccTherapist72HrsNotAssessed"]] ~ not_applicable_date,
    TRUE ~ .data[["S3OccTherapist72HrsDateTime"]]),
  S3OccTherapist72HrsTimeNotEntered = NULL,
  S3OccTherapist72HrsNotAssessed = NULL,

  S3Physio72HrsDateTime = dplyr::case_when(
    .data[["S3Physio72HrsTimeNotEntered"]] ~ not_entered_date,
    .data[["S3Physio72HrsNotAssessed"]] ~ not_applicable_date,
    TRUE ~ .data[["S3Physio72HrsDateTime"]]),
  S3Physio72HrsTimeNotEntered = NULL,
  S3Physio72HrsNotAssessed = NULL,

  S3SpLangTherapistComm72HrsDateTime = dplyr::case_when(
    .data[["S3SpLangTherapistComm72HrsTimeNotEntered"]] ~
      not_entered_date,
    .data[["S3SpLangTherapistComm72HrsNotAssessed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S3SpLangTherapistComm72HrsDateTime"]]),
  S3SpLangTherapistComm72HrsTimeNotEntered = NULL,
  S3SpLangTherapistComm72HrsNotAssessed = NULL,

  S3SpLangTherapistSwallow72HrsDateTime = dplyr::case_when(
    .data[["S3SpLangTherapistSwallow72HrsTimeNotEntered"]] ~
      not_entered_date,
    .data[["S3SpLangTherapistSwallow72HrsNotAssessed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S3SpLangTherapistSwallow72HrsDateTime"]]),
  S3SpLangTherapistSwallow72HrsTimeNotEntered = NULL,
  S3SpLangTherapistSwallow72HrsNotAssessed = NULL,

  S4StrokeUnitArrivalDateTime = dplyr::case_when(
    .data[["S4StrokeUnitArrivalTimeNotEntered"]] ~ not_entered_date,
    .data[["S4StrokeUnitArrivalNA"]] ~ not_applicable_date,
    TRUE ~ .data[["S4StrokeUnitArrivalDateTime"]]),
  S4StrokeUnitArrivalTimeNotEntered = NULL,
  S4StrokeUnitArrivalNA = NULL,

  S6OccTherapistByDischargeDateTime = dplyr::case_when(
    .data[["S6OccTherapistByDischargeTimeNotEntered"]] ~
      not_entered_date,
    .data[["S6OccTherapistByDischargeNotAssessed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S6OccTherapistByDischargeDateTime"]]),
  S6OccTherapistByDischargeTimeNotEntered = NULL,
  S6OccTherapistByDischargeNotAssessed = NULL,

  S6PhysioByDischargeDateTime = dplyr::case_when(
    .data[["S6PhysioByDischargeTimeNotEntered"]] ~ not_entered_date,
    .data[["S6PhysioByDischargeNotAssessed"]] ~ not_applicable_date,
    TRUE ~ .data[["S6PhysioByDischargeDateTime"]]),
  S6PhysioByDischargeTimeNotEntered = NULL,
  S6PhysioByDischargeNotAssessed = NULL,

  S6SpLangTherapistCommByDischargeDateTime = dplyr::case_when(
    .data[["S6SpLangTherapistCommByDischargeTimeNotEntered"]] ~
      not_entered_date,
    .data[["S6SpLangTherapistCommByDischargeNotAssessed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S6SpLangTherapistCommByDischargeDateTime"]]),
  S6SpLangTherapistCommByDischargeTimeNotEntered = NULL,
  S6SpLangTherapistCommByDischargeNotAssessed = NULL,

  S6SpLangTherapistSwallowByDischargeDateTime = dplyr::case_when(
    .data[["S6SpLangTherapistSwallowByDischargeTimeNotEntered"]] ~
      not_entered_date,
    .data[["S6SpLangTherapistSwallowByDischargeNotAssessed"]] ~
      not_applicable_date,
    TRUE ~ .data[["S6SpLangTherapistSwallowByDischargeDateTime"]]),
  S6SpLangTherapistSwallowByDischargeTimeNotEntered = NULL,
  S6SpLangTherapistSwallowByDischargeNotAssessed = NULL,


  # Combine the RCP Thrombolysis No But Reasons into a single
  # No But Reason Code. The bitfield is defined at the top of the
  # file.
  S2ThrombolysisNoBut =
    (.data[["S2ThrombolysisNoButHaemorrhagic"]] *
      tpa_no_but["Haemorrhagic"]) +
    (.data[["S2ThrombolysisNoButImproving"]] *
      tpa_no_but["Improving"]) +
    (.data[["S2ThrombolysisNoButComorbidity"]] *
      tpa_no_but["Comorbidity"]) +
    (.data[["S2ThrombolysisNoButMedication"]] *
      tpa_no_but["Medication"]) +
    (.data[["S2ThrombolysisNoButRefusal"]] *
      tpa_no_but["Refusal"]) +
    (.data[["S2ThrombolysisNoButOtherMedical"]] *
      tpa_no_but["OtherMedical"]) +
    (.data[["S2ThrombolysisNoButAge"]] * tpa_no_but["Age"]) +
    (.data[["S2ThrombolysisNoButTooMildSevere"]] *
      tpa_no_but["TooMildSevere"]) +
    (.data[["S2ThrombolysisNoButTimeUnknownWakeUp"]] *
      tpa_no_but["TimeUnknownWakeUp"]) +
    (.data[["S2ThrombolysisNoButTimeWindow"]] *
      tpa_no_but["TimeWindow"]),

  S2ThrombolysisNoButHaemorrhagic = NULL,
  S2ThrombolysisNoButTimeWindow = NULL,
  S2ThrombolysisNoButComorbidity = NULL,
  S2ThrombolysisNoButMedication = NULL,
  S2ThrombolysisNoButAge = NULL,
  S2ThrombolysisNoButRefusal = NULL,
  S2ThrombolysisNoButImproving = NULL,
  S2ThrombolysisNoButTooMildSevere = NULL,
  S2ThrombolysisNoButTimeUnknownWakeUp = NULL,
  S2ThrombolysisNoButOtherMedical = NULL,


  # Combine thrombolysis complications into a single Reason Code.
  S2ThrombolysisComplications =
    (.data[["S2ThrombolysisComplicationSih"]] *
      tpa_complications["SymptomaticICH"]) +
    (.data[["S2ThrombolysisComplicationAO"]] *
      tpa_complications["Angiooedema"]) +
    (.data[["S2ThrombolysisComplicationEB"]] *
      tpa_complications["ExtracranialBleed"]) +
    (.data[["S2ThrombolysisComplicationOther"]] *
      tpa_complications["Other"]),

  S2ThrombolysisComplicationSih   = NULL,
  S2ThrombolysisComplicationAO    = NULL,
  S2ThrombolysisComplicationEB    = NULL,
  S2ThrombolysisComplicationOther = NULL,

  # If the patient didn't die on a stroke unit, but died on the same
  # day as discharge from the stroke unit,
  # Set the death date/time to be the date and time of stroke unit
  # discharge
  # To do this truncate the stroke unit discharge date and time to be
  # just a date for all those who didn't die on the stroke unit
  # Compare the dates against the date of death - where they are the
  # same replace with the stroke unit discharge date/time.

  S7StrokeUnitDeath = dplyr::case_when(
    (.data[["S7StrokeUnitDeath"]] == "T") ~ TRUE,
    (!is.na(.data[["S7DeathDate"]])) ~ FALSE,
    TRUE ~ NA),

#  S7DiedOnDayOfStrokeUnitDischarge = !(.data[["S7StrokeUnitDeath"]]) &
#    !is.na(.data[["S7StrokeUnitDischargeDateTime"]]) &
#    (lubridate::floor_date(.data[["S7StrokeUnitDischargeDateTime"]],
#      "day") == .data[["S7DeathDate"]]),

  S7DeathDate = dplyr::case_when(
    # This expression is 'died on day of stroke unit discharge':
    # Stroke unit death AND there is a discharge date/time from the
    # stroke unit AND the floor date of that discharge date/time
    # matches the death date/time.
    # NB checking is.na S7StrokeUnitDischargeDateTime may not be
    # needed (check later).
    # If true, use the date and time of stroke unit discharge.
    !(.data[["S7StrokeUnitDeath"]]) &
      !is.na(.data[["S7StrokeUnitDischargeDateTime"]]) &
      (lubridate::floor_date(.data[["S7StrokeUnitDischargeDateTime"]],
                             "day") == .data[["S7DeathDate"]])
      ~ .data[["S7StrokeUnitDischargeDateTime"]],
    # If patients died on a stroke unit then the date of death is
    # used with the time set to 23:59. Where (60 * 60 * 23) is
    # 23:00hrs and (60 * 59) 59 minutes respectively.
    .data[["S7StrokeUnitDeath"]] ~ .data[["S7DeathDate"]] +
      lubridate::hours(23) + lubridate::minutes(59),
    # If the patient was discharged from the stroke unit but died
    # on a subsequent day, the death date/time is left as 00:00
    # (which is the default so no calculation needed).
    TRUE ~ .data[["S7DeathDate"]]),

  S7TeamClockStopDateTime = dplyr::if_else(
    is.na(.data[["S7HospitalDischargeDateTime"]]),
    .data[["S7DeathDate"]],
    .data[["S7HospitalDischargeDateTime"]]),

  S1PatientClockStartDateTime =
    dplyr::case_when(
      # NA if we are a six month transfer
      (!is.na(.data[["TransferFromTeamCode"]]) &
        is.na(.data[["TransferFromDateTime"]])) |
      # NA if we are not a stroke
        (.data$S1Diagnosis != "S") |
      # NA if TeamCode starts with "C" or "c" (ie. community)
        stringr::str_detect(.data[["TeamCode"]], "C") |
        stringr::str_detect(.data[["TeamCode"]], "c") ~
          as.POSIXct(NA),
      .data[["S1OnsetInHospital"]] ~ .data[["S1OnsetDateTime"]],
      TRUE ~ .data[["S1FirstArrivalDateTime"]]),

  S1TeamClockStartDateTime =
    dplyr::case_when(
      is.na(.data[["S1PatientClockStartDateTime"]]) ~ as.POSIXct(NA),
      .data[["S1PatientClockStartDateTime"]] <
        .data[["S4ArrivalDateTime"]] ~ .data[["S4ArrivalDateTime"]],
      TRUE ~ .data[["S1PatientClockStartDateTime"]])
)
