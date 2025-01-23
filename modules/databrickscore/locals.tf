locals {
  # General locals
  prefix = "${lower(var.prefix)}-core-${var.environment}"
  system_schema_names = [
    "access",
    "billing",
    "compute",
    "lakeflow",
    "marketplace",
    "query",
    "serving",
    "storage",
  ]
}
