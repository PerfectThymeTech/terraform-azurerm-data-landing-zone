resource "databricks_workspace_conf" "workspace_conf" {
  custom_config = {
    customerApprovedWSLoginExpirationTime   = "1998-01-01T00:00:00.000Z"
    enableAclsConfig                        = false
    enableIpAccessLists                     = true
    enableExportNotebook                    = false
    enableResultsDownloading                = false
    enableTokensConfig                      = false
    enableDeprecatedClusterNamedInitScripts = false
    enableDeprecatedGlobalInitScripts       = false
    enableUploadDataUis                     = false
    enableNotebookTableClipboard            = false
    enableWebTerminal                       = true
    enableDbfsFileBrowser                   = false
    enableDatabricksAutologgingAdminConf    = true
    enableFileStoreEndpoint                 = false
    enforceUserIsolation                    = true
    maxTokenLifetimeDays                    = "1"
    mlflowRunArtifactDownloadEnabled        = false
    enableProjectsAllowList                 = true
    projectsAllowListPermissions            = "ALLOWLISTED_CLONE_COMMIT_PUSH" # ALLOWLISTED_COMMIT_PUSH
    projectsAllowList                       = "https://github.com/"
    reposIpynbResultsExportPermissions      = "DISABLE"
  }
}
