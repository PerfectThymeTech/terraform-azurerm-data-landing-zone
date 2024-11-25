locals {
  # General locals
  prefix = "${lower(var.prefix)}-${var.app_name}-${var.environment}"
}
