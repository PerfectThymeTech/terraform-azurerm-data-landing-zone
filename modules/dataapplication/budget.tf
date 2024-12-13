resource "time_rotating" "rotating_current" {
  rotation_years = 9
}

resource "azurerm_consumption_budget_subscription" "consumption_budget_subscription" {
  name            = "${local.prefix}-bdgt"
  subscription_id = data.azurerm_subscription.current.id

  amount     = var.budget.categories.azure
  time_grain = "Monthly"
  time_period {
    start_date = "${time_rotating.rotating_current.year}-${time_rotating.rotating_current.month}-01T00:00:00Z"
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
    operator       = "GreaterThanOrEqualTo"
    threshold      = "80"
    threshold_type = "Actual"
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
    operator       = "GreaterThanOrEqualTo"
    threshold      = "110"
    threshold_type = "Forecasted"
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
    operator       = "GreaterThanOrEqualTo"
    threshold      = "130"
    threshold_type = "Forecasted"
  }
}
