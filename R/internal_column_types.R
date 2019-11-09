# Column type definitions
# Temporarily export them whilst we test the ssnap_measure checking
# Unit test will work as expected

#' @export
datetimeformat <- "%Y-%m-%d %H:%M"

#' @export
column_types <- readr::cols(
  ProClinV1Id = readr::col_integer(),
  PatientId = readr::col_integer(),
  TeamCode = readr::col_character(),
  ImportIdentifier = readr::col_character(),
  CreatedDateTime = readr::col_datetime(format = datetimeformat),
  CreatedUserName = readr::col_character(),
  UpdatedDateTime = readr::col_datetime(format = datetimeformat),
  UpdatedUserName = readr::col_character(),
  TransferToActionDateTime =
    readr::col_datetime( format = datetimeformat),
  TransferToActionUserName = readr::col_character(),
  TransferToDateTime = readr::col_datetime(format = datetimeformat),
  TransferToTeamCode = readr::col_character(),
  TransferToProClinV1Id = readr::col_integer(),
  TransferFromActionDateTime =
    readr::col_datetime(format = datetimeformat),
  TransferFromActionUserName = readr::col_character(),
  TransferFromDateTime = readr::col_datetime(format = datetimeformat),
  TransferFromTeamCode = readr::col_character(),
  TransferFromProClinV1Id = readr::col_integer(),
  Locked = readr::col_skip(),
  LockedDateTime = readr::col_datetime(format = datetimeformat),
  LockedUserName = readr::col_character(),
  Closed = readr::col_logical(),
  InitialDiagnosis = readr::col_skip(),
  AuditType = readr::col_skip(),
  Status72h = readr::col_factor(c(0, 10, 20, 30)),
  StatusDischarge = readr::col_factor(c(0, 10, 20, 30)),
  Status = readr::col_factor(c(0, 10, 20, 30)),
  LockedS1 = readr::col_logical(),
  LockedS1DateTime = readr::col_skip(),
  LockedS1UserName = readr::col_skip(),
  S1Status = readr::col_skip(),
  S1HospitalNumber = readr::col_character(),
  S1NHSNumber = readr::col_character(),
  S1NoNHSNumber = readr::col_skip(),
  S1Surname = readr::col_character(),
  S1Forename = readr::col_character(),
  S1BirthDate = readr::col_datetime(format = datetimeformat),
  S1AgeOnArrival = readr::col_integer(),
  S1Gender = readr::col_factor(c("M", "F")),
  S1PostcodeOut = readr::col_character(),
  S1PostcodeIn = readr::col_character(),
  S1Ethnicity = readr::col_character(),
  S1Diagnosis = readr::col_factor(c("S", "T", "O")),
  S1OnsetInHospital = readr::col_factor(c("Y", "N")),
  S1OnsetDateTime = readr::col_datetime(format = datetimeformat),
  S1OnsetTimeNotEntered = readr::col_skip(),
  S1OnsetDateType = readr::col_factor(c("P", "BE", "DS")),
  S1OnsetTimeType = readr::col_factor(c("P", "BE", "NK")),
  S1ArriveByAmbulance = readr::col_factor(c("Y", "N")),
  S1AmbulanceTrust = readr::col_factor(c(
    "ISA1", "ISA2", "ISA3", "NIA", "RRU", "RX5", "RX6",
    "RX7", "RX8", "RX9", "RYA", "RYB", "RYC", "RYD",
    "RYE", "RYF", "WAL", "5QT", "North", "South")),
  S1CadNumber = readr::col_character(),
  S1CadNumberNK = readr::col_skip(),
  S1FirstArrivalDateTime = readr::col_datetime(format = datetimeformat),
  S1FirstArrivalTimeNotEntered = readr::col_skip(),
  S1FirstWard = readr::col_factor(c("MAC", "SU", "ICH", "O")),
  S1FirstStrokeUnitArrivalDateTime =
    readr::col_datetime(format = datetimeformat),
  S1FirstStrokeUnitArrivalTimeNotEntered = readr::col_logical(),
  S1FirstStrokeUnitArrivalNA = readr::col_logical(),
  LockedS2 = readr::col_logical(),
  LockedS2DateTime = readr::col_skip(),
  LockedS2UserName = readr::col_skip(),
  S2Status = readr::col_skip(),
  S2CoMCongestiveHeartFailure = readr::col_factor(c("Y", "N")),
  S2CoMHypertension = readr::col_factor(c("Y", "N")),
  S2CoMAtrialFibrillation = readr::col_factor(c("Y", "N")),
  S2CoMDiabetes = readr::col_factor(c("Y", "N")),
  S2CoMStrokeTIA = readr::col_factor(c("Y", "N")),
  S2CoMAFAntiplatelet = readr::col_factor(c("Y", "N", "NB", NA)),
  S2CoMAFAnticoagulent = readr::col_factor(c("Y", "N", "NB", NA)),
  S2RankinBeforeStroke = readr::col_integer(),
  S2NihssArrival = readr::col_integer(),
  S2NihssArrivalLoc = readr::col_integer(),
  S2NihssArrivalLocQuestions = readr::col_integer(),
  S2NihssArrivalLocCommands = readr::col_integer(),
  S2NihssArrivalBestGaze = readr::col_integer(),
  S2NihssArrivalVisual = readr::col_integer(),
  S2NihssArrivalFacialPalsy = readr::col_integer(),
  S2NihssArrivalMotorArmLeft = readr::col_integer(),
  S2NihssArrivalMotorArmRight = readr::col_integer(),
  S2NihssArrivalMotorLegLeft = readr::col_integer(),
  S2NihssArrivalMotorLegRight = readr::col_integer(),
  S2NihssArrivalLimbAtaxia = readr::col_integer(),
  S2NihssArrivalSensory = readr::col_integer(),
  S2NihssArrivalBestLanguage = readr::col_integer(),
  S2NihssArrivalDysarthria = readr::col_integer(),
  S2NihssArrivalExtinctionInattention = readr::col_integer(),
  S2BrainImagingDateTime = readr::col_datetime(format = datetimeformat),
  S2BrainImagingTimeNotEntered = readr::col_logical(),
  S2BrainImagingNotPerformed = readr::col_logical(),
  S2StrokeType = readr::col_factor(c("I", "PIH")),
  S2Thrombolysis = readr::col_factor(c("Y", "N", "NB")),
  S2ThrombolysisNoReason =
    readr::col_factor(c("TNA", "OTSH", "USQE", "N", NA)),
  S2ThrombolysisNoButHaemorrhagic = readr::col_logical(),
  S2ThrombolysisNoButTimeWindow = readr::col_logical(),
  S2ThrombolysisNoButComorbidity = readr::col_logical(),
  S2ThrombolysisNoButMedication = readr::col_logical(),
  S2ThrombolysisNoButRefusal = readr::col_logical(),
  S2ThrombolysisNoButAge = readr::col_logical(),
  S2ThrombolysisNoButImproving = readr::col_logical(),
  S2ThrombolysisNoButTooMildSevere = readr::col_logical(),
  S2ThrombolysisNoButTimeUnknownWakeUp = readr::col_logical(),
  S2ThrombolysisNoButOtherMedical = readr::col_logical(),
  S2ThrombolysisDateTime = readr::col_datetime(format = datetimeformat),
  S2ThrombolysisTimeNotEntered = readr::col_skip(),
  S2ThrombolysisComplications = readr::col_factor(c("Y", "N", NA)),
  S2ThrombolysisComplicationSih = readr::col_logical(),
  S2ThrombolysisComplicationAO = readr::col_logical(),
  S2ThrombolysisComplicationEB = readr::col_logical(),
  S2ThrombolysisComplicationOther = readr::col_logical(),
  S2ThrombolysisComplicationOtherDetails = readr::col_character(),
  S2Nihss24Hrs = readr::col_integer(),
  S2Nihss24HrsNK = readr::col_logical(),
  S2SwallowScreening4HrsDateTime =
    readr::col_datetime(format = datetimeformat),
  S2SwallowScreening4HrsTimeNotEntered = readr::col_logical(),
  S2SwallowScreening4HrsNotPerformed = readr::col_logical(),
  S2SwallowScreening4HrsNotPerformedReason =
    readr::col_factor(c("OR", "PR", "PU", "NK", NA)),
  S2IAI = readr::col_character(),
  S2IAIClinicalTrial = readr::col_character(),
  S2IAICtaMra = readr::col_character(),
  S2IAIAspects = readr::col_character(),
  S2IAIPerfusionImaging = readr::col_character(),
  S2IAIAnaesthesia = readr::col_character(),
  S2IAILeadOperator = readr::col_character(),
  S2IAIThromboAspiration = readr::col_character(),
  S2IAIStentRetriever = readr::col_character(),
  S2IAIProximalBallonFlowArrestGuideCather = readr::col_character(),
  S2IAIDistalAccessCatheter = readr::col_character(),
  S2IAIArterialPunctureDateTime =
    readr::col_datetime(format = datetimeformat),
  S2IAIArterialPunctureTimeNotEntered = readr::col_skip(),
  S2IAIThrombectomyAspirationDeviceDateTime =
    readr::col_datetime(format = datetimeformat),
  S2IAIThrombectomyAspirationDeviceNotPerformed =
    readr::col_logical(),
  S2IAIThrombectomyAspirationDeviceTimeNotEntered =
    readr::col_logical(),
  S2IAIEndOfProcedureDateTime =
    readr::col_datetime(format = datetimeformat),
  S2IAIEndOfProcedureTimeNotEntered = readr::col_logical(),
  S2IAIComplicationSymptomaticIntraCranialHaemorrhage =
    readr::col_character(),
  S2IAIComplicationExtraCranialHaemorrhage =
    readr::col_character(),
  S2IAIComplicationOther = readr::col_character(),
  S2IAITiciPreIntervention = readr::col_character(),
  S2IAITiciPostIntervention = readr::col_character(),
  S2IAITransferTo = readr::col_character(),
  S2TIAInLastMonth = readr::col_factor(c("Y", "N", "NK", NA)),
  S2NeurovascularClinicAssessed =
    readr::col_factor(c("Y", "N", NA)),
  S2BarthelBeforeStroke = readr::col_integer(),
  S2BrainImagingModality = readr::col_factor(c("CT", "MRI")),
  LockedS3 = readr::col_logical(),
  LockedS3DateTime = readr::col_skip(),
  LockedS3UserName = readr::col_skip(),
  S3Status = readr::col_skip(),
  S3PalliativeCare = readr::col_skip(),
  S3PalliativeCareDecisionDate =
    readr::col_datetime(format = datetimeformat),
  S3EndOfLifePathway = readr::col_factor(c("Y", "N", NA)),
  S3StrokeNurseAssessedDateTime =
    readr::col_datetime(format = datetimeformat),
  S3StrokeNurseAssessedTimeNotEntered = readr::col_logical(),
  S3StrokeNurseNotAssessed = readr::col_logical(),
  S3StrokeConsultantAssessedDateTime =
    readr::col_datetime(format = datetimeformat),
  S3StrokeConsultantAssessedTimeNotEntered = readr::col_logical(),
  S3StrokeConsultantNotAssessed = readr::col_logical(),
  S3SwallowScreening72HrsDateTime =
    readr::col_datetime(format = datetimeformat),
  S3SwallowScreening72HrsTimeNotEntered = readr::col_logical(),
  S3SwallowScreening72HrsNotPerformed = readr::col_logical(),
  S3SwallowScreening72HrsNotPerformedReason =
    readr::col_factor(c("OR", "PR", "PU", "NK", NA)),
  S3OccTherapist72HrsDateTime = readr::col_datetime(
    format = datetimeformat),
  S3OccTherapist72HrsTimeNotEntered = readr::col_logical(),
  S3OccTherapist72HrsNotAssessed = readr::col_logical(),
  S3OccTherapist72HrsNotAssessedReason = readr::col_factor(c(
    "OR", "PR", "PU", "ND", "NK", NA)),
  S3Physio72HrsDateTime = readr::col_datetime(format = datetimeformat),
  S3Physio72HrsTimeNotEntered = readr::col_logical(),
  S3Physio72HrsNotAssessed = readr::col_logical(),
  S3Physio72HrsNotAssessedReason =
    readr::col_factor(c("OR", "PR", "PU", "ND", "NK", NA)),
  S3SpLangTherapistComm72HrsDateTime =
    readr::col_datetime(format = datetimeformat),
  S3SpLangTherapistComm72HrsTimeNotEntered = readr::col_logical(),
  S3SpLangTherapistComm72HrsNotAssessed = readr::col_logical(),
  S3SpLangTherapistComm72HrsNotAssessedReason = readr::col_factor(
    c("OR", "PR", "PU", "ND", "NK", NA)),
  S3SpLangTherapistSwallow72HrsDateTime = readr::col_datetime(
    format = datetimeformat),
  S3SpLangTherapistSwallow72HrsTimeNotEntered =
    readr::col_logical(),
  S3SpLangTherapistSwallow72HrsNotAssessed = readr::col_logical(),
  S3SpLangTherapistSwallow72HrsNotAssessedReason =
    readr::col_factor(c("OR", "PR", "PU", "PS", "NK", NA)),
  LockedS4 = readr::col_logical(),
  LockedS4DateTime = readr::col_skip(),
  LockedS4UserName = readr::col_skip(),
  S4Status = readr::col_skip(),
  S4ArrivalDateTime = readr::col_datetime(format = datetimeformat),
  S4ArrivalTimeNotEntered = readr::col_skip(),
  S4FirstWard =  readr::col_factor(c("MAC", "SU", "ICH", "O")),
  S4StrokeUnitArrivalDateTime =
    readr::col_datetime(format = datetimeformat),
  S4StrokeUnitArrivalTimeNotEntered = readr::col_logical(),
  S4StrokeUnitArrivalNA = readr::col_logical(),
  S4Physio = readr::col_factor(c("Y", "N", NA)),
  S4PhysioEndDate = readr::col_datetime(format = datetimeformat),
  S4PhysioDays = readr::col_integer(),
  S4PhysioMinutes = readr::col_integer(),
  S4OccTher = readr::col_factor(c("Y", "N", NA)),
  S4OccTherEndDate = readr::col_datetime(format = datetimeformat),
  S4OccTherDays = readr::col_integer(),
  S4OccTherMinutes = readr::col_integer(),
  S4SpeechLang = readr::col_factor(c("Y", "N", NA)),
  S4SpeechLangEndDate = readr::col_datetime(format = datetimeformat),
  S4SpeechLangDays = readr::col_integer(),
  S4SpeechLangMinutes = readr::col_integer(),
  S4Psychology = readr::col_factor(c("Y", "N", NA)),
  S4PsychologyEndDate = readr::col_datetime(format = datetimeformat),
  S4PsychologyDays = readr::col_integer(),
  S4PsychologyMinutes = readr::col_integer(),
  S4RehabGoalsDate = readr::col_datetime(format = datetimeformat),
  S4RehabGoalsNone = readr::col_skip(),
  S4RehabGoalsNoneReason =
    readr::col_factor(c("PR", "OR", "MU", "NI", "NRP", "NK", NA)),
  LockedS5 = readr::col_logical(),
  LockedS5DateTime = readr::col_skip(),
  LockedS5UserName = readr::col_skip(),
  S5Status = readr::col_skip(),
  S5LocWorst7Days = readr::col_integer(),
  S5UrinaryTractInfection7Days =
    readr::col_factor(c("Y", "N", "NK", NA)),
  S5PneumoniaAntibiotics7Days =
    readr::col_factor(c("Y", "N", "NK", NA)),
  LockedS6 = readr::col_logical(),
  LockedS6DateTime = readr::col_skip(),
  LockedS6UserName = readr::col_skip(),
  S6Status = readr::col_skip(),
  S6OccTherapistByDischargeDateTime =
    readr::col_datetime(format = datetimeformat),
  S6OccTherapistByDischargeTimeNotEntered = readr::col_logical(),
  S6OccTherapistByDischargeNotAssessed = readr::col_logical(),
  S6OccTherapistByDischargeNotAssessedReason = readr::col_factor(
    c("OR", "PR", "MU", "ND", "NK", NA)),
  S6PhysioByDischargeDateTime =
    readr::col_datetime(format = datetimeformat),
  S6PhysioByDischargeTimeNotEntered = readr::col_logical(),
  S6PhysioByDischargeNotAssessed = readr::col_logical(),
  S6PhysioByDischargeNotAssessedReason =
    readr::col_factor(c("OR", "PR", "MU", "ND", "NK", NA)),
  S6SpLangTherapistCommByDischargeDateTime =
    readr::col_datetime(format = datetimeformat),
  S6SpLangTherapistCommByDischargeTimeNotEntered =
    readr::col_logical(),
  S6SpLangTherapistCommByDischargeNotAssessed =
    readr::col_logical(),
  S6SpLangTherapistCommByDischargeNotAssessedReason =
    readr::col_factor(c("OR", "PR", "MU", "ND", "NK", NA)),
  S6SpLangTherapistSwallowByDischargeDateTime =
    readr::col_datetime(format = datetimeformat),
  S6SpLangTherapistSwallowByDischargeTimeNotEntered =
    readr::col_logical(),
  S6SpLangTherapistSwallowByDischargeNotAssessed =
    readr::col_logical(),
  S6SpLangTherapistSwallowByDischargeNotAssessedReason =
    readr::col_factor(c("OR", "PR", "MU", "NK", NA)),
  S6UrinaryContinencePlanDate =
    readr::col_date(format = datetimeformat),
  S6UrinaryContinencePlanNoPlan = readr::col_skip(),
  S6UrinaryContinencePlanNoPlanReason =
    readr::col_factor(c("OR", "PR", "PC", "NK", NA)),
  S6MalnutritionScreening = readr::col_character(),
  S6MalnutritionScreeningDietitianDate =
    readr::col_datetime(format = datetimeformat),
  S6MalnutritionScreeningDietitianNotSeen = readr::col_skip(),
  S6MoodScreeningDate = readr::col_date(format = datetimeformat),
  S6MoodScreeningNoScreening = readr::col_skip(),
  S6MoodScreeningNoScreeningReason =
    readr::col_factor(c("OR", "PR", "MU", "NK", NA)),
  S6CognitionScreeningDate =
    readr::col_date(format = datetimeformat),
  S6CognitionScreeningNoScreening = readr::col_skip(),
  S6CognitionScreeningNoScreeningReason =
    readr::col_factor(c("OR", "PR", "MU", "NK", NA)),
  S6PalliativeCareByDischarge = readr::col_character(),
  S6PalliativeCareByDischargeDate =
    readr::col_datetime(format = datetimeformat),
  S6EndOfLifePathwayByDischarge = readr::col_character(),
  S6FirstRehabGoalsDate = readr::col_datetime(format = datetimeformat),
  S6IntPneumaticComp = readr::col_factor(c("Y", "N", "NK", NA)),
  S6IntPneumaticCompStartDate =
    readr::col_datetime(format = datetimeformat),
  S6IntPneumaticCompEndDate =
    readr::col_datetime(format = datetimeformat),
  LockedS7 = readr::col_logical(),
  LockedS7DateTime = readr::col_datetime(format = datetimeformat),
  LockedS7UserName = readr::col_skip(),
  S7Status = readr::col_skip(),
  S7DischargeType = readr::col_factor(
    c("D", "CH", "H", "SE", "T", "TC", "TN", "TCN")),
  S7DeathDate = readr::col_datetime(format = datetimeformat),
  S7StrokeUnitDeath = readr::col_factor(c("Y", "N", NA)),
  S7TransferTeamCode = readr::col_character(),
  # NB S7TransferHospitalCode is a synonym for S7TransferTeamCode
  # which we fix later
  S7TransferHospitalCode = readr::col_character(),
  S7StrokeUnitDischargeDateTime =
    readr::col_datetime(format = datetimeformat),
  S7StrokeUnitDischargeTimeNotEntered = readr::col_skip(),
  S7HospitalDischargeDateTime =
    readr::col_datetime(format = datetimeformat),
  S7HospitalDischargeTimeNotEntered = readr::col_skip(),
  S7EndRehabDate = readr::col_datetime(format = datetimeformat),
  S7RankinDischarge = readr::col_integer(),
  S7CareHomeDischarge = readr::col_factor(c("PR", "NPR", NA)),
  S7CareHomeDischargeType = readr::col_factor(c("T", "P", NA)),
  S7HomeDischargeType =
    readr::col_factor(c("LA", "NLA", "NK", NA)),
  S7DischargedEsdmt = readr::col_factor(c("SNS", "NS", "N", NA)),
  S7DischargedMcrt = readr::col_factor(c("SNS", "NS", "N", NA)),
  S7AdlHelp = readr::col_factor(c("Y", "N", NA)),
  S7AdlHelpType =
    readr::col_factor(c("PC", "IC", "PIC", "U", "PR", NA)),
  S7DischargeVisitsPerWeek = readr::col_integer(),
  S7DischargeVisitsPerWeekNK = readr::col_logical(),
  S7DischargeAtrialFibrillation =
    readr::col_factor(c("Y", "N", NA)),
  S7DischargeAtrialFibrillationAnticoagulation =
    readr::col_factor(c("Y", "N", "NB", NA)),
  S7DischargeJointCarePlanning = readr::col_factor(c("Y", "N", NA)),
  S7DischargeNamedContact = readr::col_factor(c("Y", "N", NA)),
  S7DischargeBarthel = readr::col_integer(),
  S7DischargePIConsent = readr::col_factor(c("Y", "N", NA)),
  CFStatus = readr::col_factor(c(0, 10, 20, 30)),
  PCOoR = readr::col_character(),
  LockedS8 = readr::col_skip(),
  LockedS8DateTime = readr::col_skip(),
  LockedS8UserName = readr::col_skip(),
  S8Status = readr::col_skip(),
  S8FollowUp = readr::col_factor(c("Y", "N", "NB", "ND", NA)),
  S8FollowUpDate = readr::col_datetime(format = datetimeformat),
  S8FollowUpType = readr::col_factor(c("IP", "T", "O", "P", NA)),
  S8FollowUpBy = readr::col_factor(
    c("GP", "SC", "T", "DN", "VS", "SCC", "O", NA)),
  S8FollowUpByOther = readr::col_character(),
  S8FollowUpPIConsent = readr::col_factor(c("Y", "N", NA)),
  S8MoodBehaviourCognitiveScreened =
    readr::col_factor(c("Y", "N", "NB", NA)),
  S8MoodBehaviourCognitiveSupportNeeded =
    readr::col_factor(c("Y", "N", NA)),
  S8MoodBehaviourCognitivePsychologicalSupport =
    readr::col_factor(c("Y", "N", "NB", NA)),
  S8Living = readr::col_factor(c("H", "CH", "O", NA)),
  S8LivingOther = readr::col_character(),
  S8Rankin6Month = readr::col_integer(),
  S8Rankin6MonthNK = readr::col_skip(),
  S8PersistentAtrialFibrillation =
    readr::col_factor(c("Y", "N", "NK", NA)),
  S8TakingAntiplateletDrug =
    readr::col_factor(c("Y", "N", "NK", NA)),
  S8TakingAnticoagulent = readr::col_factor(c("Y", "N", "NK", NA)),
  S8TakingLipidLowering = readr::col_factor(c("Y", "N", "NK", NA)),
  S8TakingAntihypertensive =
    readr::col_factor(c("Y", "N", "NK", NA)),
  S8SinceStrokeAnotherStroke =
    readr::col_factor(c("Y", "N", "NK", NA)),
  S8SinceStrokeMyocardialInfarction =
    readr::col_factor(c("Y", "N", "NK", NA)),
  S8SinceStrokeOtherHospitalisationIllness =
    readr::col_factor(c("Y", "N", "NK", NA))
)
