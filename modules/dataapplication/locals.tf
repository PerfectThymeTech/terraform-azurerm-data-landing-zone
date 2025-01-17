locals {
  # General locals
  prefix                           = "${lower(var.prefix)}-${lower(var.app_name)}-${var.environment}"
  budget_start_date_rotation_years = 9

  # Databricks locals
  databricks_enterprise_application_id = "2ff814a6-3304-4ab8-85cb-cd0e6f879c1d"

  # AI service locals
  ai_service_kind_firewall_bypass_azure_services_list = [
    "OpenAI"
  ]
  ai_service_kind_role_map_write = {
    "AnomalyDetector"         = "Cognitive Services User"
    "ComputerVision"          = "Cognitive Services User"
    "CognitiveServices"       = "Cognitive Services User"
    "ContentModerator"        = "Cognitive Services User"
    "CustomVision.Training"   = "Cognitive Services Custom Vision Contributor"
    "CustomVision.Prediction" = "Cognitive Services Custom Vision Contributor"
    "Face"                    = "Cognitive Services User"
    "FormRecognizer"          = "Cognitive Services User"
    "ImmersiveReader"         = "Cognitive Services User"
    "LUIS"                    = "Cognitive Services Language Owner"
    "Personalizer"            = "Cognitive Services User"
    "SpeechServices"          = "Cognitive Services Speech Contributor"
    "TextAnalytics"           = "Cognitive Services Language Owner"
    "TextTranslation"         = "Cognitive Services Language Owner"
    "OpenAI"                  = "Cognitive Services OpenAI Contributor"
  }
  ai_service_kind_role_map_use = {
    "AnomalyDetector"         = "Cognitive Services User"
    "ComputerVision"          = "Cognitive Services User"
    "CognitiveServices"       = "Cognitive Services User"
    "ContentModerator"        = "Cognitive Services User"
    "CustomVision.Training"   = "Cognitive Services Custom Vision Reader"
    "CustomVision.Prediction" = "Cognitive Services Custom Vision Reader"
    "Face"                    = "Cognitive Services User"
    "FormRecognizer"          = "Cognitive Services User"
    "ImmersiveReader"         = "Cognitive Services User"
    "LUIS"                    = "Cognitive Services Language Reader"
    "Personalizer"            = "Cognitive Services User"
    "SpeechServices"          = "Cognitive Services Speech User"
    "TextAnalytics"           = "Cognitive Services Language Reader"
    "TextTranslation"         = "Cognitive Services Language Reader"
    "OpenAI"                  = "Cognitive Services OpenAI User"
  }
}
