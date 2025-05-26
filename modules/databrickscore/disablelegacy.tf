resource "databricks_disable_legacy_access_setting" "disable_legacy_access_setting_engineering" {
  disable_legacy_access {
    value = true
  }
}

# resource "databricks_disable_legacy_dbfs_setting" "disable_legacy_dbfs_setting_engineering" { # Currently in private preview
#   disable_legacy_dbfs {
#     value = true
#   }
# }

# resource "databricks_disable_legacy_features_setting" "disable_legacy_features_setting_engineering" { # Currently in private preview
#   disable_legacy_features {
#     value = true
#   }
# }
