resource "databricks_disable_legacy_access_setting" "disable_legacy_access_setting" {
  disable_legacy_access {
    value = true
  }
}

# resource "databricks_disable_legacy_dbfs_setting" "disable_legacy_dbfs_setting" { # Currently in private preview
#   disable_legacy_dbfs {
#     value = true
#   }
# }
