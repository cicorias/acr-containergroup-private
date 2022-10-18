resource "azurerm_monitor_diagnostic_setting" "this" {
  count                      = var.log_analytics_workspace_id != null ? 1 : 0
  name                       = var.diagnostic_name
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = var.diag_logs
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
    for_each = var.diag_metrics
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
    ignore_changes = [log, metric]
  }
}