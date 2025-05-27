resource "databricks_restrict_workspace_admins_setting" "restrict_workspace_admins_setting_engineering" {
  restrict_workspace_admins {
    status = "RESTRICT_TOKENS_AND_JOB_RUN_AS"
  }
}
