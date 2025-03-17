module "fabric_workspace" {
  source = "github.com/PerfectThymeTech/terraform-azurerm-modules//modules/fabricworkspace?ref=main"
  providers = {
    fabric = fabric
  }

  count = var.fabric_workspace_details.enabled && var.fabric_capacity_details.enabled ? 1 : 0

  workspace_capacity_name    = var.fabric_capacity_details.name
  workspace_display_name     = "${local.prefix}-wsp001"
  workspace_description      = "Fabric workspace for stamp '${var.prefix}' and app '${var.app_name}'"
  workspace_identity_enabled = true
  workspace_settings = {
    automatic_log = {
      enabled = true
    }
    # environment = {
    #   default_environment_name = ""
    #   runtime_version          = "1.3"
    # }
    high_concurrency = {
      notebook_interactive_run_enabled = true
    }
    pool = {
      customize_compute_enabled = true
      # default_pool_name         = "starterPool"
    }
  }
  workspace_git              = null
  workspace_role_assignments = {}
}
