locals {
  acr_name = replace(format("%s%s", var.resource_group_name, var.nonce), "-", "")
}

resource "azurerm_container_registry" "this" {
  name                          = local.acr_name
  resource_group_name           = azurerm_resource_group.this.name
  location                      = azurerm_resource_group.this.location
  sku                           = var.acr_sku
  admin_enabled                 = var.acr_admin_enabled
  public_network_access_enabled = var.acr_public_network_access_enabled
}

// seet https://github.com/kumarvna/terraform-azurerm-container-registry/blob/main/main.tf#L216
# https://github.com/kumarvna/terraform-azurerm-container-registry/tree/main/examples/container_registry_with_georeplications
# https://github.com/kumarvna/terraform-azurerm-container-registry/blob/main/variables.tf
# https://github.com/kumarvna/terraform-azurerm-container-registry

data "azurerm_log_analytics_workspace" "law" {
  name                = "scicoria-shared-law"
  resource_group_name = "scicoria-fn1"
}

module "diagnostics" {
  source                     = "../modules"
  diagnostic_name            = "acr-diag"
  target_resource_id         = azurerm_container_registry.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  diag_logs                  = var.diag_logs
  diag_metrics               = var.diag_metrics
}