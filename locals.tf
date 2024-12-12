locals {
  prefix                        = "${lower(var.prefix)}-${var.environment}"
  diagnostics_configurations    = []
  connectivity_delay_in_seconds = 20
}

locals {
  # Merge databricks workspace details
  databricks_workspace_details_apps = {
    # for key, value in local.data_application_definitions :
    # key => module.data_application[key].databricks_workspace_details
  }
  databricks_workspace_details = merge(
    module.core.databricks_workspace_details,
    local.databricks_workspace_details_apps,
  )

  # Merge databricks private endpoint rules
  databricks_private_endpoint_rules_apps = {
    # for key, value in local.data_application_definitions :
    # key => module.data_application[key].databricks_private_endpoint_rules
  }
  databricks_private_endpoint_rules = merge(
    module.core.databricks_private_endpoint_rules,
    local.databricks_private_endpoint_rules_apps,
  )
}

locals {
  data_application_library_path = var.data_application_library_path

  # Load file paths
  data_application_filepaths_json = local.data_application_library_path == "" ? [] : tolist(fileset(local.data_application_library_path, "**/*.{json,json.tftpl}"))
  data_application_filepaths_yaml = local.data_application_library_path == "" ? [] : tolist(fileset(local.data_application_library_path, "**/*.{yml,yml.tftpl,yaml,yaml.tftpl}"))

  # Load file content
  data_application_definitions_json = {
    for filepath in local.data_application_filepaths_json :
    filepath => jsondecode(templatefile("${local.data_application_library_path}/${filepath}", var.data_application_file_variables))
  }
  data_application_definitions_yaml = {
    for filepath in local.data_application_filepaths_yaml :
    filepath => yamldecode(templatefile("${local.data_application_library_path}/${filepath}", var.data_application_file_variables))
  }

  # Merge data
  data_application_definitions_merged = merge(
    local.data_application_definitions_json,
    local.data_application_definitions_yaml
  )

  # Data applications by name
  data_application_definitions = {
    for key, value in local.data_application_definitions_merged :
    try(value.name, "unknown") => value
  }
}

locals {
  databricks_cluster_policy_library_path = var.databricks_cluster_policy_library_path

  # Load file paths
  databricks_cluster_policy_filepaths_json = local.databricks_cluster_policy_library_path == "" ? [] : tolist(fileset(local.databricks_cluster_policy_library_path, "**/*.{json,json.tftpl}"))
  databricks_cluster_policy_filepaths_yaml = local.databricks_cluster_policy_library_path == "" ? [] : tolist(fileset(local.databricks_cluster_policy_library_path, "**/*.{yml,yml.tftpl,yaml,yaml.tftpl}"))

  # Load file content
  databricks_cluster_policy_definitions_json = {
    for filepath in local.databricks_cluster_policy_filepaths_json :
    filepath => jsondecode(file("${local.databricks_cluster_policy_library_path}/${filepath}")) # templatefile("${local.databricks_cluster_policy_library_path}/${filepath}", var.databricks_cluster_policy_file_variables))
  }
  databricks_cluster_policy_definitions_yaml = {
    for filepath in local.databricks_cluster_policy_filepaths_yaml :
    filepath => yamldecode(file("${local.databricks_cluster_policy_library_path}/${filepath}")) # templatefile("${local.databricks_cluster_policy_library_path}/${filepath}", var.databricks_cluster_policy_file_variables))
  }

  # Merge data
  databricks_cluster_policy_definitions_merged = merge(
    local.databricks_cluster_policy_definitions_json,
    local.databricks_cluster_policy_definitions_yaml
  )

  # Databricks cluster policies by name
  databricks_cluster_policy_definitions = {
    for key, value in local.databricks_cluster_policy_definitions_merged :
    try(value.name, "unknown") => value
  }
}
