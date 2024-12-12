resource "databricks_cluster_policy" "cluster_policy" {
  for_each = local.databricks_cluster_policy_definitions

  name                               = each.value.name
  description                        = each.value.description
  max_clusters_per_user              = each.value.maxClustersPerUser
  policy_family_definition_overrides = null
  policy_family_id                   = null

  definition = jsonencode(each.value.definition)
  # dynamic "libraries" {
  #   for_each = each.value.libraries
  #   iterator = package
  #   content {
  #     # TODO: Add library support
  #   }
  # }
}
