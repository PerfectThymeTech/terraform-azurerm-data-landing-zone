output "databricks_cluster_policy_ids" {
  description = "Specifies the id's of the databricks cluster policies"
  sensitive   = false
  value = {
    for key, value in var.databricks_cluster_policies :
    value.name => databricks_cluster_policy.cluster_policy[key].id
  }
}
