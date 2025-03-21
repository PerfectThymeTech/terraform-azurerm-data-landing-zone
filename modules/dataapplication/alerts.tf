resource "azurerm_monitor_activity_log_alert" "monitor_activity_log_alert_service_health" {
  name                = "${local.prefix}-alert-servicehealth"
  location            = "global"
  resource_group_name = azurerm_resource_group.resource_group_app_monitoring.name
  tags                = local.tags

  enabled     = true
  description = "Alerts for service health and maintenance events."
  scopes = [
    data.azurerm_subscription.current.id,
  ]
  action {
    action_group_id = azurerm_monitor_action_group.monitor_action_group.id
    webhook_properties = {
      alert_type          = "service-health",
      alert_location      = var.location
      alert_env           = var.environment
      alert_scope         = data.azurerm_client_config.current.subscription_id
      alert_instance      = local.prefix
      alert_app_name      = var.app_name
      alert_severity      = var.alerting.categories.service_health.severity
      alert_incidentlevel = var.alerting.categories.service_health.incident_level
    }
  }
  criteria {
    category = "ServiceHealth"
    service_health {
      events = [
        "Incident",
        "Maintenance"
      ]
      locations = [
        "Global",
        data.azurerm_location.current.display_name,
      ]
    }
  }
}
