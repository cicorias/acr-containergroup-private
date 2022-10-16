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

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = data.azurerm_log_analytics_workspace.law.id != null ? 1 : 0
  name                       = lower(format("%s-%s-%s", "spc", "diag", local.acr_name))
  target_resource_id         = azurerm_container_registry.this.id
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id // var.log_analytics_workspace_id

  dynamic "log" {
    for_each = var.acr_diag_logs
    content {
      category = log.value.category
      enabled  = log.value.enabled

      retention_policy {
        enabled = log.value.retention_enabled
        days    = log.value.retention_days
      }
    }
  }

  dynamic "metric" {
    for_each = var.acr_diag_metrics
    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_enabled
        days    = metric.value.retention_days
      }
    }
  }

  lifecycle {
    ignore_changes = [log] //, metric]
  }
}