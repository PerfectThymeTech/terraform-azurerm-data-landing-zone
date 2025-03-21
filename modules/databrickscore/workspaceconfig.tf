resource "databricks_workspace_conf" "workspace_conf" {
  custom_config = {
    allow_downloads                                  = false
    customerApprovedWSLoginExpirationTime            = "1998-01-01T00:00:00.000Z"
    enableIpAccessLists                              = true
    enableExportNotebook                             = false
    enableResultsDownloading                         = false
    enableTokensConfig                               = false
    enableDeprecatedClusterNamedInitScripts          = false
    enableDeprecatedGlobalInitScripts                = false
    enableUploadDataUis                              = false # Consider enabling this for development
    enableNotebookTableClipboard                     = false
    enableWebTerminal                                = true
    enableDbfsFileBrowser                            = false
    enableDatabricksAutologgingAdminConf             = true
    enableFileStoreEndpoint                          = false
    enableProjectsAllowList                          = true
    enableJobsEmailsV2                               = true
    enableVerboseAuditLogs                           = true
    enforceUserIsolation                             = true
    maxTokenLifetimeDays                             = "1"
    mlflowRunArtifactDownloadEnabled                 = false
    projectsAllowListPermissions                     = "ALLOWLISTED_CLONE_COMMIT_PUSH" # ALLOWLISTED_COMMIT_PUSH
    projectsAllowList                                = "https://github.com/"           # Update to specific URI
    reposIpynbResultsExportPermissions               = "DISABLE"
    storeInteractiveNotebookResultsInCustomerAccount = true
  }
}
