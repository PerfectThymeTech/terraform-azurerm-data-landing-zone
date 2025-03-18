resource "databricks_sql_endpoint" "sql_endpoint" {
  for_each = var.databricks_sql_endpoint_details

  name = "${local.prefix}-${each.key}"

  auto_stop_mins = each.value.auto_stop_mins
  channel {
    name = "CHANNEL_NAME_CURRENT"
  }
  cluster_size              = each.value.cluster_size
  enable_photon             = true
  enable_serverless_compute = false
  max_num_clusters          = each.value.max_num_clusters
  min_num_clusters          = each.value.min_num_clusters
  warehouse_type            = "PRO"
  spot_instance_policy      = "RELIABILITY_OPTIMIZED"
  tags {
    dynamic "custom_tags" {
      for_each = merge(var.tags, { prefix = local.prefix })
      iterator = entry
      content {
        key   = entry.key
        value = entry.value
      }
    }
  }
}
