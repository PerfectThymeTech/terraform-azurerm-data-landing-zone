resource "databricks_cluster_policy" "cluster_policy" {
  for_each = var.databricks_cluster_policies
  name     = each.key

  definition = jsonencode(each.value)

  depends_on = [
    var.dependencies
  ]
}
