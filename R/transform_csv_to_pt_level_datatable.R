#' This file contains experimental code with list-defined instructions
#' for building a patient level datatable from raw CSV.
#' 
#' The idea is that we reduce the import to a set of scriptable
#' actions that the import function can select from and are more
#' maintainable / generic.
#' 
#' It is expected we'll start down this road with a hybrid of hard
#' coding and scriptable components.

#' The following line can be used to produce a data frame from the
#' lists; but lists (ie. a vector of objects of class transforms) are
#' probably the best way to create the data initially.
#' 
#' test_frame <- do.call(rbind.data.frame, test_transforms)

#' @export
ssnap_record_transforms <- c(
  record_transform_tidy_csv_boolean(c(
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
    "S2IAIComplicationOther")
  ),
  record_transform_tidy_csv_factor_to_logical(
    input_column = "S1OnsetDateType",
    output_column = "S1OnsetDateIsPrecise",
    true_value = "P",
    false_value = "BE"),
  record_transform_tidy_csv_factor_to_logical(
    input_column = "S1OnsetTimeType",
    output_column = "S1OnsetTimeIsPrecise",
    true_value = "P",
    false_value = "BE"),
  record_transform_tidy_csv_factor_to_logical(
    input_column = "S2BrainImagingModality",
    output_column = "S2BrainImagingModalityIsCT",
    true_value = "CT",
    false_value = "MRI"),
  record_transform_tidy_csv_factor_to_logical(
    input_column = "S7CareHomeDischarge",
    output_column = "S7CareHomeDischargeToNewResidence",
    true_value = "NPR",
    false_value = "PR"),
  record_transform_tidy_csv_factor_to_logical(
    input_column = "S7CareHomeDischargeType",
    output_column = "S7CareHomeDischargePermanentResidence",
    true_value = "P",
    false_value = "T"),
  record_transform_tidy_csv_factor_to_logical(
    input_column = "S7DischargedEsdmt",
    output_column = "S7DischargedSpecialistEsdmt",
    true_value = "SNS",
    false_value = "NS"),
  record_transform_tidy_csv_factor_to_logical(
    input_column = "S7DischargedMcrt",
    output_column = "S7DischargedSpecialistMcrt",
    true_value = "SNS",
    false_value = "NS")
)
