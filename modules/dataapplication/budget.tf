resource "azurerm_consumption_budget_subscription" "consumption_budget_subscription" {
  name            = "${local.prefix}-bdgt"
  subscription_id = data.azurerm_subscription.current.id

  amount     = var.budget.categories.azure
  time_grain = "Monthly"
  time_period {
    start_date = "2024-11-01T00:00:00Z"
  }
  filter {
    dynamic "tag" {
      for_each = var.tags
      iterator = item
      content {
        name     = item.key
        operator = "In"
        values   = [item.value]
      }
    }
  }
  notification {
    enabled = true
    contact_emails = [
      var.budget.endpoints.email.email_address
    ]
    contact_groups = [
      azurerm_monitor_action_group.monitor_action_group.id
    ]
    contact_roles  = []
    operator       = "GreaterThanOrEqualTo" # EqualTo, GreaterThan
    threshold      = "80"
    threshold_type = "Actual" # Forecasted
  }
}
